//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


//GROUPS (Lists): Wishlist
class GroupsViewController: UIViewController {

    //SETUP
    let groupsAPI = GroupsAPI()
    private var groups: [GroupModel] = []
    
    private let tableView = UITableView()
    private let underlineView = UIView()
    private var underlineLeadingConstraint: NSLayoutConstraint!

    let userDefaultManager = UserDefaultManager()
    let imageFunctions = ImageFunctions()

    //DATA
    //myGroups are groups the user created and own. sharedGroups are groups the user was invited to
    private var myGroups: [GroupModel] {
        return GroupDataController.shared.groups.filter { group in
            group.createdBy == GroupDataController.shared.currentUser
        }
    }
    
    private var sharedGroups: [GroupModel] {
        return GroupDataController.shared.groups.filter { group in
            group.createdBy != GroupDataController.shared.currentUser
        }
    }
    
    //GROUPS
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        printPageInfo(vcName: "GroupsViewController")
 
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
    
    //ACTIONS
    @objc private func openProfile() {
        let currentUserName = UsersDataController.shared.currentUser
        print("Profile tapped - Current user: \(currentUserName)")
    }
    

    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }
    
    //SEGMENT CONTROLLER
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        return sc
    }()

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        underlineLeadingConstraint.constant = segmentWidth * CGFloat(sender.selectedSegmentIndex)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        // Reload table view to show filtered groups
        tableView.reloadData()
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider()
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    
    //LAYOUT
    private func setupNavigationBar() {
        navigationItem.title = "Wishlist"

        let createGroupButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openCreateGroup)
        )
        navigationItem.rightBarButtonItem = createGroupButton

        if let image = UIImage(named: "background_14") {
            let circularImage = imageFunctions.makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
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

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none  // Comment out divider lines between cells

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

    
    //FUNCTIONS
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }
}


//TABLE VIEW
extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            return myGroups.count
        case 1: // Shared With Me
            return sharedGroups.count
        default:
            return 0
        }
    }

     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group: GroupModel
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            group = myGroups[indexPath.row]
        case 1: // Shared With Me
            group = sharedGroups[indexPath.row]
        default:
            group = GroupModel(groupID: 0, groupName: "", groupImage: nil, createdBy: nil, activeGroupMembers: [], pendingGroupMembers: [])
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group: GroupModel
        let currentUserOwnsGroup: Bool
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: // My Lists
            group = myGroups[indexPath.row]
            currentUserOwnsGroup = true
        case 1: // Shared With Me
            group = sharedGroups[indexPath.row]
            currentUserOwnsGroup = false
        default:
            group = GroupModel(groupID: 0, groupName: "", groupImage: nil, createdBy: nil, activeGroupMembers: [], pendingGroupMembers: [])
            currentUserOwnsGroup = false
        }
        
        // Navigate to IndividualGroupViewController
        let storyboard = UIStoryboard(name: Constants.StoryboardNames.groupsStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.groupID = group.groupID
        vc.currentUserOwnsGroup = currentUserOwnsGroup
        navigationController?.pushViewController(vc, animated: true)
    }
}

