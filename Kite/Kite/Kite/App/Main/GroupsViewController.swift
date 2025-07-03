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
        
        print("GroupsViewController")
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

        let headerLabel = UILabel()
        headerLabel.text = "Groups"
        headerLabel.font = .boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center

        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        // Set the header's frame explicitly to be recognized by tableView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    //Functions B: API Functions
    //Function B1: Get all the Groups
    private func fetchGroups() {
        let currentUser = userDefaultManager.getLoggedInUser()

        Task {
            do {
                let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
                if groupsResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                self.groups = groupsResponseModel.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch groups:", error)
            }
        }
    }
}


extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
}


