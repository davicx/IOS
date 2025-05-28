//
//  FriendViewController.swift
//  Kite
//
//  Created by David Vasquez on 5/26/25.
//

import UIKit



class YourFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users: [Friend] = []

    private var friends: [Friend] = []
    private var friendRequests: [Friend] = []
    private var currentData: [Friend] = []

    private let tableView = UITableView()
    private let segmentedControl = UISegmentedControl(items: ["Friends", "Friend Requests"])

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white

        friends = users.filter {
            $0.friendshipKey == "friends" ||
            $0.friendshipKey == "request_pending"
        }
        friendRequests = users.filter { $0.friendshipKey == "invite_pending" }

        setupSegmentedControl()
        setupTableView()

        // Default to Friends tab
        segmentedControl.selectedSegmentIndex = 0
        currentData = friends
    }

    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            currentData = friends
        } else {
            currentData = friendRequests
        }
        addUnderlineForSelectedSegment()
        tableView.reloadData()
    }

    private func addUnderlineForSelectedSegment() {
        segmentedControl.subviews
            .filter { $0.tag == 999 }
            .forEach { $0.removeFromSuperview() }

        let underlineWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineX = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth
        let underlineFrame = CGRect(
            x: underlineX,
            y: segmentedControl.frame.height - underlineHeight,
            width: underlineWidth,
            height: underlineHeight
        )

        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.label
        underline.tag = 999
        segmentedControl.addSubview(underline)
    }


    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.removeBackgroundAndDivider() // We'll define this below

        // Underline-style: transparent background
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear

        // Set text styles
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

        // Add underline manually
        addUnderlineForSelectedSegment()

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        // Layout in header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        segmentedControl.frame = CGRect(x: 16, y: 4, width: view.frame.width - 32, height: 36)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
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

        tableView.register(YourFriendsTableViewCell.self,
                           forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentData[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.TableViewCellIdentifier.friendCell,
            for: indexPath
        ) as! YourFriendsTableViewCell
        cell.configure(with: user)

        
        // Wire up the closures if you need callbacks:
        cell.cancelRequestTapped = { [weak self] in
            guard let self = self else { return }
            switch user.friendshipKey {
            case "request_pending":
                // Directly cancel outgoing request
                print("Cancel request to \(user.friendName)")
                // → your API call to cancel request here

            case "friends":
                // Ask before removing a confirmed friend
                let alert = UIAlertController(
                    title: "Remove Friend",
                    message: "Are you sure you want to remove @\(user.friendName) from your friends?",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
                    print("Removing friend \(user.friendName)")
                    // → your API call to remove friend here
                })
                self.present(alert, animated: true, completion: nil)

            default:
                break
            }
        }


        cell.acceptInviteTapped = {
            // accept invite API call
            print("Accept invite from \(user.friendName)")
        }
        cell.declineInviteTapped = {
            // decline invite API call
            print("Decline invite from \(user.friendName)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = currentData[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(
            withIdentifier: "FriendProfileViewControllerID"
        ) as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension UISegmentedControl {
    func removeBackgroundAndDivider() {
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
}



//WORKING
/*
class YourFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users: [Friend] = []

    private var friends: [Friend] = []
    private var friendRequests: [Friend] = []
    private var currentData: [Friend] = []

    private let tableView = UITableView()
    private let segmentedControl = UISegmentedControl(items: ["Friends", "Friend Requests"])

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white

        // Split data into friends and requests
        friends = users.filter { $0.requestPending == 0 }
        friendRequests = users.filter { $0.requestPending == 1 }

        setupSegmentedControl()
        setupTableView()

        segmentedControl.selectedSegmentIndex = 0
        currentData = friends
    }

    // MARK: - Segmented Control
    @objc private func segmentChanged() {
        currentData = segmentedControl.selectedSegmentIndex == 0 ? friends : friendRequests
        tableView.reloadData()
    }

    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = .systemBlue

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        segmentedControl.frame = CGRect(x: 16, y: 8, width: view.frame.width - 32, height: 34)
        headerView.addSubview(segmentedControl)

        tableView.tableHeaderView = headerView
    }

    // MARK: - Table View
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

        tableView.register(YourFriendsTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell)
    }

    // MARK: - DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.friendCell, for: indexPath) as! YourFriendsTableViewCell
        cell.configure(with: user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = currentData[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

 */
/*
 //SIMPLE WORKS
class YourFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users: [Friend] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white
        
        for user in users {
            print("User: \(user.requestSentBy),  \(user.friendName), requestPending: \(user.requestPending)")
        }
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72

        // Register your custom cell
        tableView.register(YourFriendsTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.friendCell)
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.friendCell, for: indexPath) as! YourFriendsTableViewCell
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFriend = users[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FriendProfileViewControllerID") as? FriendProfileViewController {
            vc.friend = selectedFriend
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
*/

