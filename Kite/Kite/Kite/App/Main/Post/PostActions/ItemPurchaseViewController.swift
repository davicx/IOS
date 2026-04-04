//
//  ItemPurchaseViewController.swift
//  Kite
//
//  Created by David Vasquez on 2/14/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT
//ACTIONS
//FUNCTIONS

class ItemPurchaseViewController: UIViewController {

    //LOGIC
    var post: Post?
    var groupID: Int?
    private var groupMembers: [User] = []
    private var selectedUsernames: Set<String> = []

    //UI COMPONENTS
    private let tableView = UITableView()
    private let cancelButton = UIButton(type: .system)
    private let purchaseButton = UIButton(type: .system)
    private let buttonStackView = UIStackView()

    private var groupDataController: GroupDataController { GroupDataController.shared }
    private var usersDataController: UsersDataController { UsersDataController.shared }

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "ItemPurchaseViewController")
        loadGroupMembers()
    }


    //LAYOUT
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.register(ItemPurchaseUserCell.self, forCellReuseIdentifier: "ItemPurchaseUserCell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }


    //ACTIONS
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func purchaseTapped() {
        guard let post = post, let groupID = groupID else { return }
        let showPurchased = Array(selectedUsernames).sorted()
        purchaseButton.isUserInteractionEnabled = false
        Task {
            await PostLogic.shared.purchaseItem(post: post, groupID: groupID, showPurchased: showPurchased)
            await MainActor.run {
                self.purchaseButton.isUserInteractionEnabled = true
                self.dismiss(animated: true)
            }
        }
    }
    
    //FUNCTIONS
    private func loadGroupMembers() {
        guard let groupID = groupID else {
            print("ItemPurchaseViewController: no groupID set")
            return
        }
        let groupIDString = String(groupID)
        groupDataController.fetchGroupUsers(groupID: groupIDString) { [weak self] in
            guard let self = self else { return }
            guard let groupUsers = self.groupDataController.getGroupUsers(groupID: groupIDString) else {
                print("ItemPurchaseViewController: could not load group users for groupID \(groupID) (fetch or decode failed)")
                return
            }
            let allUsernames = groupUsers.activeGroupUsers + groupUsers.pendingGroupUsers
            if allUsernames.isEmpty {
                print("ItemPurchaseViewController: group has no members")
                return
            }
            Task {
                var users: [User] = []
                for username in allUsernames {
                    if let user = await self.usersDataController.getOrFetchUser(username: username) {
                        users.append(user)
                    }
                }
                await MainActor.run {
                    self.groupMembers = users
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func setupButtons() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        Buttons.styleNotSelectedButton(cancelButton, width: 120, height: 44)

        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        Buttons.styleSelectedGreenButton(purchaseButton, width: 120, height: 44)

        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(purchaseButton)

        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -16),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension ItemPurchaseViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMembers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = groupMembers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemPurchaseUserCell", for: indexPath) as! ItemPurchaseUserCell
        cell.configure(with: user)
        cell.accessoryType = selectedUsernames.contains(user.userName) ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = groupMembers[indexPath.row]
        if selectedUsernames.contains(user.userName) {
            selectedUsernames.remove(user.userName)
        } else {
            selectedUsernames.insert(user.userName)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

