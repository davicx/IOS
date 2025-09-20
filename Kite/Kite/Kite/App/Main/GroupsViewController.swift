//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


//GROUPS (Lists): Wishlist
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    // MARK: - Segmented Control + Underline
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        return sc
    }()

    private let underlineView = UIView()
    private var underlineLeadingConstraint: NSLayoutConstraint!

    // MARK: - Computed Properties for Filtered Groups
    private var myLists: [GroupModel] {
        return GroupDataController.shared.groups.filter { group in
            group.createdBy == GroupDataController.shared.currentUser
        }
    }
    
    private var sharedWithMe: [GroupModel] {
        return GroupDataController.shared.groups.filter { group in
            group.createdBy != GroupDataController.shared.currentUser
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("________________________")
        print("GroupsViewController")
        print("LISTS: Wishlist")
        print("________________________")
        print(" ")
        
        setupNavigationBar()
        setupTableView()
        fetchGroups()
        
        // Listen for group updates
        GroupDataController.shared.onGroupsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("________________________")
        print("GroupsViewController")
        print("LISTS: Wishlist")
        print("________________________")
        print(" ")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGroups()
        // Ensure table view reflects current segmented control state
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    // MARK: - NAVIGATION BAR
    private func setupNavigationBar() {
        navigationItem.title = "Wishlist"

        let createGroupButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openCreateGroup)
        )
        navigationItem.rightBarButtonItem = createGroupButton

        if let image = UIImage(named: "user") {
            let circularImage = makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
                .withRenderingMode(.alwaysOriginal)

            let profileButton = UIBarButtonItem(
                image: circularImage,
                style: .plain,
                target: self,
                action: #selector(openProfile)
            )
            navigationItem.leftBarButtonItem = profileButton
        }
    }

    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()
            image.draw(in: rect)
        }
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }
    
    @objc private func openProfile() {
        print("Profile tapped")
    }
    
    // MARK: - Segmented Control Setup
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider()
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    // MARK: - TableView Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        headerView.backgroundColor = .systemBackground

        setupSegmentedControl()
        headerView.addSubview(segmentedControl)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.8),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])

        // Underline
        headerView.addSubview(underlineView)
        underlineView.backgroundColor = .black
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
        NSLayoutConstraint.activate([
            underlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            underlineLeadingConstraint,
            underlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)),
            underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])

        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        underlineLeadingConstraint.constant = segmentWidth * CGFloat(sender.selectedSegmentIndex)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        // Reload table view to show filtered groups
        tableView.reloadData()
    }

    
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            return myLists.count
        case 1: // Shared With Me
            return sharedWithMe.count
        default:
            return 0
        }
    }

     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group: GroupModel
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            group = myLists[indexPath.row]
        case 1: // Shared With Me
            group = sharedWithMe[indexPath.row]
        default:
            group = GroupModel(groupID: 0, groupName: "", groupImage: nil, createdBy: nil, activeGroupMembers: [], pendingGroupMembers: [])
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group: GroupModel
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            group = myLists[indexPath.row]
        case 1: // Shared With Me
            group = sharedWithMe[indexPath.row]
        default:
            group = GroupModel(groupID: 0, groupName: "", groupImage: nil, createdBy: nil, activeGroupMembers: [], pendingGroupMembers: [])
        }
        
        let storyboard = UIStoryboard(name: Constants.StoryboardNames.groupsStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
}

