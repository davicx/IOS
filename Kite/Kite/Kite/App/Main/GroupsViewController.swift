//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchGroups()
        
        // Listen for group updates
        GroupDataController.shared.onGroupsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        print("GroupsViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh groups when view appears to ensure data is up to date
        fetchGroups()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clean up the callback to prevent memory leaks
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    
    //FUNCTIONS
    //Functions A: Table View
    //Function A1: Setup the Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Custom Header View
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        // Header Label
        let headerLabel = UILabel()
        headerLabel.text = "Groups"
        headerLabel.font = .boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Create Group Button
        let createGroupButton = UIButton(type: .system)
        createGroupButton.setTitle("+", for: .normal)
        createGroupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        createGroupButton.setTitleColor(.systemBlue, for: .normal)
        createGroupButton.translatesAutoresizingMaskIntoConstraints = false
        createGroupButton.addTarget(self, action: #selector(openCreateGroup), for: .touchUpInside)

        headerView.addSubview(headerLabel)
        headerView.addSubview(createGroupButton)

        // Header layout
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            createGroupButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            createGroupButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }

    //Functions B: API Functions
    //Function B1: Get all the Groups
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }

}


extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupDataController.shared.groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = GroupDataController.shared.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = GroupDataController.shared.groups[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }


}


