//
//  IndividualGroupMembersVC.swift
//  Kite
//
//  Created by David Vasquez on 9/15/25.
//

import UIKit


class IndividualGroupMembersVC: UIViewController {
    
    // Group members data
    var groupMembers: [User] = []
    
    // Table view for displaying members
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendCell")
    }
}

// MARK: - Table View Delegate & Data Source
extension IndividualGroupMembersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = groupMembers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        cell.configure(with: member)
        
        // For group members, we'll disable the friend action button since they're already in the group
        cell.friendActionButton.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMember = groupMembers[indexPath.row]
        
        // Navigate to member's profile
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedMember
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
