//
//  Docs.swift
//  Kite
//
//  Created by David Vasquez on 2/20/25.
//

import Foundation

//PROFILE



//WORKING
/*
class YourFriendsViewController: UIViewController {
    var users: [Friend] = []

    private var friends: [Friend] = []
    private var friendRequests: [Friend] = []
    private var currentData: [Friend] = []

    private let tableView = UITableView()
    private let segmentedControl = UISegmentedControl(items: ["Friends", "Friend Requests"])
    private var underlineView: UIView?

    
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



    //STYLE and SETUP
    //Table View
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
    
    //Segmented Controller
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addUnderlineForSelectedSegment()
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
        let underlineWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineY = segmentedControl.frame.height - underlineHeight
        let underlineX = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth

        if let underline = underlineView {
            //UIView.animate(withDuration: 0.3) {
            UIView.animate(withDuration: 0.25) { underline.frame.origin.x = underlineX }
        } else {
            let underline = UIView(frame: CGRect(x: underlineX, y: underlineY, width: underlineWidth, height: underlineHeight))
            underline.backgroundColor = .label
            underline.tag = 999
            segmentedControl.addSubview(underline)
            underlineView = underline
        }
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

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        // Layout in header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        segmentedControl.frame = CGRect(x: 16, y: 4, width: view.frame.width - 32, height: 36)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
    }

    //LOGIC

}

extension YourFriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentData[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.TableViewCellIdentifier.friendCell,
            for: indexPath
        ) as! YourFriendsTableViewCell

        cell.configure(with: user)

        cell.cancelRequestTapped = { [weak self] in
            self?.handleCancelTapped(for: user)
        }

        cell.acceptInviteTapped = { [weak self] in
            self?.handleAcceptInvite(for: user)
        }

        cell.declineInviteTapped = { [weak self] in
            self?.handleDeclineInvite(for: user)
        }

        return cell
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = currentData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.TableViewCellIdentifier.friendCell,
            for: indexPath
        ) as! YourFriendsTableViewCell
        cell.configure(with: user)
        cell.selectionStyle = .none
        
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
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

*/


//WORKING
/*
class YourFriendsTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)
    let acceptButton = UIButton(type: .system)
    let declineButton = UIButton(type: .system)

    var cancelRequestTapped: (() -> Void)?
    var acceptInviteTapped: (() -> Void)?
    var declineInviteTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        followButton.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(handleAcceptTapped), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(handleDeclineTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [profileImageView, usernameLabel, fullNameLabel, followButton, acceptButton, declineButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray

        [followButton, acceptButton, declineButton].forEach {
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        }

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 100),

            acceptButton.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 60),

            declineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder

        acceptButton.isHidden = true
        declineButton.isHidden = true
        followButton.isHidden = false

        switch user.friendshipKey {
        case "request_pending":
            followButton.setTitle("Cancel", for: .normal)
            followButton.backgroundColor = .lightGray
            followButton.setTitleColor(.white, for: .normal)

        case "invite_pending":
            followButton.isHidden = true
            acceptButton.isHidden = false
            declineButton.isHidden = false

            acceptButton.setTitle("Accept", for: .normal)
            acceptButton.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.2, alpha: 1.0)
            acceptButton.setTitleColor(.white, for: .normal)

            declineButton.setTitle("Decline", for: .normal)
            declineButton.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
            declineButton.setTitleColor(.white, for: .normal)

        default:
            followButton.setTitle("Friends", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    @objc private func handleFollowTapped() {
        //cancelRequestTapped?()
        print("cancelRequestTapped")
    }

    @objc private func handleAcceptTapped() {
        //acceptInviteTapped?()
        print("acceptInviteTapped")

    }

    @objc private func handleDeclineTapped() {
        //declineInviteTapped?()
        print("declineInviteTapped")

    }
}
 */

/*
 //SIMPLE WORKING
class YourFriendsTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        followButton.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

        followButton.translatesAutoresizingMaskIntoConstraints = false
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(followButton)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 96)
        ])

    }

    @objc private func handleFollowTapped() {
        //followButtonTapped?()
        print("HIYA!")
    }
    
    let pinkColor = UIColor(red: 1.0, green: 0.18, blue: 0.48, alpha: 1.0) // #FF2D7E

    func configure(with user: Friend) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder

        if user.requestPending == 1 {
            // Show pink Follow button
            followButton.setTitle("Add Friend", for: .normal)
            followButton.backgroundColor = UIColor(red: 1.0, green: 0.18, blue: 0.48, alpha: 1.0) // Pink
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0
        } else {
            // Show default "Following" style
            followButton.setTitle("Friends", for: .normal)
            followButton.backgroundColor = .white
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}


*/



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


/*
class UserCell: UITableViewCell {
    static let identifier = "UserCell"

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let fullNameLabel = UILabel()
    let followButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.textColor = .gray
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

        followButton.translatesAutoresizingMaskIntoConstraints = false
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(followButton)

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),

            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with user: FriendModel) {
        usernameLabel.text = "@\(user.friendName)"
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        profileImageView.image = UIImage(named: "background_1") // Placeholder image
        followButton.setTitle("Following", for: .normal)
        followButton.backgroundColor = .white
        followButton.setTitleColor(.black, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.lightGray.cgColor
    }
}

private let tableView = UITableView()

private func setupTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 72
    view.addSubview(tableView)

    NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
}
 */



/*

class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var users: [FriendModel] = [] // Use real model from API


    class UserCell: UITableViewCell {
        static let identifier = "UserCell"

        let profileImageView = UIImageView()
        let usernameLabel = UILabel()
        let fullNameLabel = UILabel()
        let followButton = UIButton(type: .system)

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 24
            profileImageView.clipsToBounds = true

            usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false

            fullNameLabel.font = UIFont.systemFont(ofSize: 14)
            fullNameLabel.textColor = .gray
            fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

            followButton.translatesAutoresizingMaskIntoConstraints = false
            followButton.layer.cornerRadius = 6
            followButton.clipsToBounds = true
            followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

            contentView.addSubview(profileImageView)
            contentView.addSubview(usernameLabel)
            contentView.addSubview(fullNameLabel)
            contentView.addSubview(followButton)

            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 48),
                profileImageView.heightAnchor.constraint(equalToConstant: 48),

                usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

                fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
                fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

                followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        /*
        func configure(with user: User) {
            profileImageView.image = UIImage(named: user.imageName)
            usernameLabel.text = user.username
            fullNameLabel.text = user.fullName
            let title = user.isFollowing ? "Following" : "Follow"
            followButton.setTitle(title, for: .normal)
            followButton.backgroundColor = user.isFollowing ? .white : UIColor.systemRed
            followButton.setTitleColor(user.isFollowing ? .black : .white, for: .normal)
            followButton.layer.borderWidth = user.isFollowing ? 1 : 0
            followButton.layer.borderColor = user.isFollowing ? UIColor.lightGray.cgColor : nil
        }
         */
        func configure(with user: FriendModel) {
             profileImageView.image = UIImage(named: "background_9") // Dummy image
             usernameLabel.text = user.friendName
             fullNameLabel.text = "\(user.firstName) \(user.lastName)"
             let isFollowing = true // Assume true since this is the "following" list
             let title = isFollowing ? "Following" : "Follow"
             followButton.setTitle(title, for: .normal)
             followButton.backgroundColor = isFollowing ? .white : .systemRed
             followButton.setTitleColor(isFollowing ? .black : .white, for: .normal)
             followButton.layer.borderWidth = isFollowing ? 1 : 0
             followButton.layer.borderColor = isFollowing ? UIColor.lightGray.cgColor : nil
         }
    }

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Following"

        setupUsers()
        setupTableView()
    }

    private func setupUsers() {
        // Placeholder users for now, will be replaced with API data later
        let imageNames = ["background_1", "background_2", "background_3"]
        for i in 0..<20 {
            users.append(FriendModel(
                username: "user\(i)",
                fullName: "Full Name \(i)",
                imageName: imageNames[i % imageNames.count],
                isFollowing: i % 2 == 0
            ))
        }
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(with: user)
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    @objc private func followButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        users[index].requestPending.toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
*/

//WORKING
/*
class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var placeholderUsers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Following"
        
        placeholderUsers = (1...20).map { "User \($0)" }

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = placeholderUsers[indexPath.row]
        return cell
    }
}
*/


/*
@objc private func editButtonTapped() {
    guard let userResponse = userResponseModel else { return }
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController

    // Send the data
    editProfileVC.inputFirstName = userResponse.data.firstName
    editProfileVC.inputLastName = userResponse.data.lastName
    editProfileVC.inputBiography = userResponse.data.biography

    if let profileImage = userProfileLayout.profileImageView.imageView.image {
        editProfileVC.inputProfileImage = profileImage
    }
    
    navigationController?.pushViewController(editProfileVC, animated: true)
}
 */

/*
@objc private func editButtonTapped() {
    print("EDIT ME!!")
    let editProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
    navigationController?.pushViewController(editProfileVC, animated: true)
}
 */

//ADD THIS LOGIC
/*
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showEditProfileViewController" {
        let editProfileViewController = segue.destination as! EditProfileViewController
        //self.userProfileLayout.editProfileViewController.inputFirstName = userResponseModel?.data.firstName ?? "Error getting User Name"
        //self.userProfileLayout.editProfileViewController.inputLastName = userResponseModel?.data.lastName ?? "Error getting Full Name"
        //self.userProfileLayout.editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

    
        //if let profileImage = profileImageView.image {
        //    editProfileViewController.inputProfileImage = profileImage
       // }
    
        
        // Set the delegate
        //editProfileViewController.delegate = self
    }
}
*/
//ADD THIS LOGIC

//THIS WORKS!!!!
/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    

    //MAIN VIEWS
    @IBOutlet weak var UserProfileImageView: UIView!
    @IBOutlet weak var UserProfileUserNameView: UIView!
    @IBOutlet weak var UserProfileSocialsView: UIView!
    @IBOutlet weak var UserProfileEditView: UIView!
    @IBOutlet weak var UserProfileBiographyView: UIView!
    
    private let userProfileLayout = UserProfileLayout()
    
    //UI ELEMENTS
    @IBOutlet weak var profileImageView: UIImageView!
    
    /*

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    */
     
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
 

        userProfileLayout.setup(in: view)
        
        /*
        setUpViews()
        

        let userFollowerView = UserFollowersView()
        userFollowerView.translatesAutoresizingMaskIntoConstraints = false
        self.userFollowerView.addSubview(userFollowerView)

        NSLayoutConstraint.activate([
            userFollowerView.topAnchor.constraint(equalTo: self.userFollowerView.topAnchor),
            userFollowerView.leadingAnchor.constraint(equalTo: self.userFollowerView.leadingAnchor),
            userFollowerView.trailingAnchor.constraint(equalTo: self.userFollowerView.trailingAnchor),
            userFollowerView.bottomAnchor.constraint(equalTo: self.userFollowerView.bottomAnchor)
        ])
         */
        
        let deviceId = getDeviceId()
        print("Device ID:", deviceId)
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
            
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
            }
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        print("hi!")
    }
    
    //SEND Data to Edit Profile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditProfileViewController" {
            let editProfileViewController = segue.destination as! EditProfileViewController
            editProfileViewController.inputFirstName = userResponseModel?.data.firstName ?? "Error getting User Name"
            editProfileViewController.inputLastName = userResponseModel?.data.lastName ?? "Error getting Full Name"
            editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

            /*
            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
             */
            
            // Set the delegate
            editProfileViewController.delegate = self
        }
    }
    
    
    func setUpViews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
     
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Check if an updated image was provided
        if let newImage = updatedImage {
            print("Updating profile image in ProfileViewController")
            profileImageView.image = newImage
        }

         
        print("Profile updated: \(firstName), \(lastName), \(biography)")
    }
}
 */






/*
class ProfileViewController: UIViewController {

    

    /*

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    */
     
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        userProfileLayout.setup(in: view)
        
        /*
        setUpViews()
        

        let userFollowerView = UserFollowersView()
        userFollowerView.translatesAutoresizingMaskIntoConstraints = false
        self.userFollowerView.addSubview(userFollowerView)

        NSLayoutConstraint.activate([
            userFollowerView.topAnchor.constraint(equalTo: self.userFollowerView.topAnchor),
            userFollowerView.leadingAnchor.constraint(equalTo: self.userFollowerView.leadingAnchor),
            userFollowerView.trailingAnchor.constraint(equalTo: self.userFollowerView.trailingAnchor),
            userFollowerView.bottomAnchor.constraint(equalTo: self.userFollowerView.bottomAnchor)
        ])
         */
        
        
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                /*
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
            */
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
            }
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        print("hi!")
    }
    
    //SEND Data to Edit Profile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditProfileViewController" {
            let editProfileViewController = segue.destination as! EditProfileViewController
            editProfileViewController.inputFirstName = userResponseModel?.data.firstName ?? "Error getting User Name"
            editProfileViewController.inputLastName = userResponseModel?.data.lastName ?? "Error getting Full Name"
            editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

            /*
            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
             */
            
            // Set the delegate
            editProfileViewController.delegate = self
        }
    }
    
    /*
    func setUpViews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
     */
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        /*
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Check if an updated image was provided
        if let newImage = updatedImage {
            print("Updating profile image in ProfileViewController")
            profileImageView.image = newImage
        }

         */
        print("Profile updated: \(firstName), \(lastName), \(biography)")
    }
}
 */

/*
class ProfileViewController: UIViewController {
    
    private let userProfileLayout = UserProfileLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(userProfileLayout)
        setupConstraints()
    }
    
    private func setupConstraints() {
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
*/






//ALL BELOW GOOD







/*
extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String) {
        // Update the UI with the new data
        firstNameLabek.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Optionally, you can save the updated profile to the server or local storage
        print("Profile updated: \(firstName), \(lastName) \(biography)")
    }
}
 
 //biographyLabel.text = userResponseModel.data.biography
 //firstNameLabek.text = userResponseModel.data.firstName
 //lastNameLabel.text = userResponseModel.data.lastName
*/


/*
 //Original Uncroped Image
 if let originalImage = profileImageView.image,
           let croppedImage = originalImage.croppedToSquare() {
            profileImageView.image = croppedImage
        }
 
 //Use Image Fill
 profileImageView.contentMode = .scaleAspectFill
 profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
 profileImageView.clipsToBounds = true
 */


//print("Image URL \(userResponseModel.data.userImage)")
//print(userResponseModel)
//print("SUCCESS: Got the User Profile")

/*
if let image = await fetchImage(from: userResponseModel.data.userImage) {
    profileImageView.image = image
    //print("Loaded image")
} else {
    profileImageView.image = UIImage(named: "background_9")
    //print("Failed to load image")
}
 */



/*
Task {
    do {
        let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
        
        if userResponseModel.statusCode == 401 {
            AuthManager.shared.logoutCurrentUser()
            return
        }
        
        DispatchQueue.main.async {
            // Set Username
            self.userProfileLayout.userNameView.nameLabel.text = "@\(userResponseModel.data.userName)"
            
            
            // Set Image Directly from User Model
            
            //if let image = await fetchImage(from: userResponseModel.data.userImage) {
            if let profileImage = userResponseModel.data.userImage {
                if let croppedImage = profileImage.croppedToSquare() {
                    self.userProfileLayout.profileImageView.imageView.image = croppedImage
                } else {
                    self.userProfileLayout.profileImageView.imageView.image = profileImage
                }
            } else {
                self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
            }
             
            
            self.userProfileLayout.profileImageView.imageView.makeRounded()
        }
    } catch {
        print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
        print(error)
    }
}
 */



/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    
    private let userProfileLayout = UserProfileLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
 
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                //self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                /*
                 //I WANT IT TO BE LIKE THIS
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
            */
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
            }
        }
        
        //fetchUserProfile()
    }
    

    /*
     //THIS IS CONFUSING
    private func fetchUserProfile() {
        let currentUser = userDefaultManager.getLoggedInUser()
        
        Task {
            do {
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if userResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                DispatchQueue.main.async {
                    self.userProfileLayout.profileImageView.updateImage(with: self.fetchImage(from: userResponseModel.data.userImage))
                    self.userProfileLayout.userNameView.updateName("@\(userResponseModel.data.userName)")
                }
                
            } catch {
                print("Error fetching user profile:", error)
            }
        }
    }
    
    private func fetchImage(from urlString: String?) -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(named: "default_profile")
        }
        return image
    }
     */
     
}
*/



/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    
    private let userProfileLayout = UserProfileLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        Task {
            do {
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if userResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                //STEP 1: Fetch image asynchronously before updating UI
                let profileImage = await fetchImage(from: userResponseModel.data.userImage)

                DispatchQueue.main.async {
                    //STEP 2: Set UI Elements
                    //Step 2A: Set Username
                    self.userProfileLayout.userNameView.nameLabel.text = "@\(userResponseModel.data.userName)"
                    
                    //Step 2B: Set Image with fetched image
                    if let profileImage = profileImage {
                        if let croppedImage = profileImage.croppedToSquare() {
                            self.userProfileLayout.profileImageView.imageView.image = croppedImage
                        } else {
                            self.userProfileLayout.profileImageView.imageView.image = profileImage
                        }
                    } else {
                        self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
                    }

                    self.userProfileLayout.profileImageView.imageView.makeRounded()
                }
            } catch {
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
                print(error)
            }
        }

    }
}
*/



/*
 //FUNCTIONS
 //Function 1: Like Post
 func handleLike(post: Post, groupID: Int) async {
     do {
         let likePostResponseModel = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
         if likePostResponseModel.success == true {
             let likeModel = likePostResponseModel.data
             post.isLikedByCurrentUser = true
             post.postLikesArray?.append(likeModel)
             post.simpleLikesArray?.append(likeModel.likedByUserName)
             likePostDelegate?.userLikePost(currentPostID: post.postID, likeModel: likeModel)
         }
     } catch {
         print("Error liking post:", error)
     }
 }

 //Function 2: Unlike Post
 func handleUnlike(post: Post, groupID: Int) async {
     do {
         let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
         if unlikePostResponseModel.success == true {
             let likeModel = unlikePostResponseModel.data
             post.isLikedByCurrentUser = false
             post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeModel.postLikeID }
             post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != unlikePostResponseModel.currentUser }
             likePostDelegate?.userUnlikePost(currentPostID: post.postID, likeModel: likeModel)
         }
     } catch {
         print("Error unliking post:", error)
     }
 }


 //Function 3: Like Comment
 func handleLikeComment(comment: Comment, postID: Int, groupID: Int) async {
     print("LIKE COMMENT DELEGATE: handleLikeComment")
     do {
         let response = try await CommentsAPI.shared.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID
         )
         
         if response.success == true {
             let commentLikeModel = response.data
             print("LIKE A COMMENT")
             likeCommentDelegate?.userLikeComment(currentPostID: comment.postID ?? 0, currentCommentID: comment.commentID ?? 0, commentLikeModel: commentLikeModel)
         }
     } catch {
         print("Error liking comment:", error)
     }
 }

 //Function 4: Unlike Comment
 func handleUnLikeComment(comment: Comment, postID: Int, groupID: Int) async {
     print("LIKE COMMENT DELEGATE: handleUnLikeComment")
     do {
         let response = try await CommentsAPI.shared.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
         
         if response.success == true {
             let commentUnlikeModel = response.data
             print("UNLIKE A COMMENT")
             likeCommentDelegate?.userUnlikeComment(currentPostID: comment.postID ?? 0, currentCommentID: comment.commentID ?? 0, commentLikeModel: commentUnlikeModel)
         }
     } catch {
         print("Error unliking comment:", error)
     }
 }
 */


//WORKING
/*
class CommentCell: UITableViewCell {
    
    // MAIN: Views
    let userView = UIView()
    let commentView = UIView()
    let dividerView = UIView()
    
    // USER: Views
    let userImageView = UIImageView()
    
    // COMMENT: Views
    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()
    
    // Header, Body, Footer Content
    let userNameLabel = UILabel()
    let commentTextView = UITextView()
    let likesLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMainViews()
        setupUserViews()
        setupCommentViews()
        setupConstraints()
        setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainViews() {
        userView.backgroundColor = .white
        commentView.backgroundColor = .clear
        
        contentView.addSubview(userView)
        contentView.addSubview(commentView)
        
        [userView, commentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupUserViews() {
        userImageView.image = UIImage(named: "user")
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 30
        
        userView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 65),
            userImageView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setupCommentViews() {
        //headerView.backgroundColor = .systemPink
        bodyView.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        //footerView.backgroundColor = .white
        //footerView.backgroundColor = .blue
        
        [headerView, bodyView, footerView].forEach {
            commentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupHeaderView()
        setupBodyView()
        setupFooterView()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .systemPink

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(userNameLabel)

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }

    
    private func setupBodyView() {
        bodyView.backgroundColor = .systemPurple.withAlphaComponent(0.3)

        commentTextView.isScrollEnabled = false
        commentTextView.isEditable = false
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false

        bodyView.addSubview(commentTextView)

        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])
    }

    private func setupFooterView() {
        footerView.backgroundColor = .white

        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = .darkGray
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        footerView.addSubview(likesLabel)

        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: footerView.topAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
    }

    //Divider
    private func setupDividerView() {
        dividerView.backgroundColor = .lightGray
        contentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale) // 1px line
        ])
    }
    
    //Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MAIN: userView
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userView.widthAnchor.constraint(equalToConstant: 80),
            
            // MAIN: commentView
            commentView.leadingAnchor.constraint(equalTo: userView.trailingAnchor),
            commentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Header View: Contains user name
            headerView.topAnchor.constraint(equalTo: commentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 24),
            
            // Body View: Contains comment caption
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            
            // Footer View: Contains likes
            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 40),
            footerView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])
    }
    
    func configure(with comment: CommentModel) {
        userNameLabel.text = comment.commentFrom
        commentTextView.text = comment.commentCaption
        likesLabel.text = "\(comment.commentLikes?.count ?? 0) likes"
    }
}
*/

/*
extension IndividualPostViewController: CommentCellDelegate {
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        let commentIndex = indexPath.row - 1
        if let comment = currentPost.commentsArray?[commentIndex] {
            print("IndividualPostViewController: Current comment at index \(indexPath.row): \(comment.commentID)")
            
            if comment.commentLikedByCurrentUser == true {
                print("Should Unlike")
             
                //Call
                //handleUnLikeComment
                
            } else {
                print("Should Like")
                //Call
                //handleLikeComment
            }
            
        } else {
            print("IndividualPostViewController: No comment found at index \(indexPath.row)")
        }
    }
}
*/


/*
 extension IndividualPostViewController: CommentCellDelegate {
     func didTapLikeCommentButton(in cell: CommentCell) {
         guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

         let commentIndex = indexPath.row - 1
         guard var comment = currentPost.commentsArray?[commentIndex] else { return }

         // Simulate Like/Unlike toggle
         comment.commentLikedByCurrentUser = !(comment.commentLikedByCurrentUser ?? false)
         
         // Update the array so it's in sync
         currentPost.commentsArray?[commentIndex] = comment

         // Update the UI
         cell.configureComment(with: comment)
     }
 }
 */



/*
extension IndividualPostViewController: CommentCellDelegate {
    func didTapLikeCommentButton(in cell: CommentCell) {
        guard let indexPath = postTableView.indexPath(for: cell), indexPath.row > 0 else { return }

        cell.startLoading()

        let commentIndex = indexPath.row - 1
        var comment = currentPost.commentsArray?[commentIndex]

        guard let unwrappedComment = comment else { return }

        if unwrappedComment.commentLikedByCurrentUser == true {
            handleUnLikeComment(comment: unwrappedComment, postID: unwrappedComment.postID ?? 0, groupID: unwrappedComment.groupID ?? 0) {
                DispatchQueue.main.async {
                    // Update the local model and reload cell
                    self.currentPost.commentsArray?[commentIndex].commentLikedByCurrentUser = false
                    if let count = self.currentPost.commentsArray?[commentIndex].commentLikeCount, count > 0 {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = count - 1
                    }
                    cell.configureComment(with: self.currentPost.commentsArray![commentIndex])
                }
            }
        } else {
            handleLikeComment(comment: unwrappedComment, postID: unwrappedComment.postID ?? 0, groupID: unwrappedComment.groupID ?? 0) {
                DispatchQueue.main.async {
                    // Update the local model and reload cell
                    self.currentPost.commentsArray?[commentIndex].commentLikedByCurrentUser = true
                    if let count = self.currentPost.commentsArray?[commentIndex].commentLikeCount {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = count + 1
                    } else {
                        self.currentPost.commentsArray?[commentIndex].commentLikeCount = 1
                    }
                    cell.configureComment(with: self.currentPost.commentsArray![commentIndex])
                }
            }
        }
    }
}
*/


//Need an extension for comment liked
/*

 extension IndividualPostViewController: PostCellDelegate {
     func didTapLikeButton(in cell: PostCell) {
         guard let indexPath = postTableView.indexPath(for: cell) else { return }
         if indexPath.row == 0 {
             cell.startLoading()

             if currentPost.isLikedByCurrentUser == true {
                 handleUnlike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                     DispatchQueue.main.async {
                         cell.configure(with: self.currentPost)
                     }
                 }
             } else {
                 handleLike(post: currentPost, groupID: currentPost.groupID ?? 0) {
                     DispatchQueue.main.async {
                         cell.configure(with: self.currentPost)
                     }
                 }
             }
         }
     }
 }*/

/*
 Need this data
 {
     "currentUser": "frodo",
     "postID": 722,
     "commentID": 229,
     "groupID": 72
 }

 */

//WORKS: Above is animation
/*
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configure(with: currentPost)
        cell.delegate = self
        return cell
    } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = commentsArray[indexPath.row - 1] // 👈 Subtract 1 because first row is post
        cell.configure(with: comment.commentCaption ?? "")
        return cell
    }
}
 */


//print("heightForRowAt postImageHeight \(postImageHeight) postCaptionHeight \(postCaptionHeight)")
//print(" ")
//print("We need this for our Caption Height \(postCaptionHeight) \(currentPost.postID)")
//print(postCaption)

//footer + postImageHeight + captionTextHeight + 8 + comments
//return 10 + postImageHeight + captionTextHeight + 8 + 40

//Post User + Post Image + Post Socials + Post Caption + divider
/*
 
 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()

     @IBOutlet weak var postsTableView: UITableView!

     // Polling Manager
     private let pollingManager = PollingManager()

     override func viewDidLoad() {
         super.viewDidLoad()

         // Setup PollingManager callback
         pollingManager.onFetchPosts = { [weak self] in
             self?.fetchPosts()
         }

         // Initial data fetch
         fetchPosts()

         // Start polling
         pollingManager.startPolling()

         setupTableView()
     }

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         pollingManager.startPolling() // Restart polling if view reappears
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         pollingManager.stopPolling() // Stop polling when view goes away
     }

     // Fetch posts using the API
     func fetchPosts() {
         print("STEP 1: fetchPosts")
         Task {
             do {
                 print("STEP 2: postsResponseModel")
                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                 
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                 print("TOTAL POSTS \(postsArray.count)")

                 DispatchQueue.main.async {
                     self.postsTableView.reloadData()
                     self.pollingManager.resetFailureCount()
                 }
             } catch {
                 print("Error fetching posts: \(error)")
                 pollingManager.handlePollingFailure()
             }
         }
     }
     
     // TableView Setup
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }

     // Data Passing with Segue
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let postViewController = segue.destination as? SinglePostViewController,
            let selectedPost = sender as? Post {
             postViewController.currentPost = selectedPost
         }
     }
 }


 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
         let post = postsArray[indexPath.row]
         cell.updatePost(with: post)
         return cell
     }

      
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }
 }

 */

/*
//WORKS CURRENT
class HomeViewController: UIViewController {
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    let userDefaultManager = UserDefaultManager()

    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()

    @IBOutlet weak var postsTableView: UITableView!

    // Timer for polling
    var pollingTimer: Timer?
    var failureCount = 0
    var isPollingPaused = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial data fetch
        fetchPosts()

        // Start polling for updates
        startPolling()

        setupTableView()
    }

    // Function to fetch posts from API
    func fetchPosts() {
        guard !isPollingPaused else {
            print("Polling is paused, skipping fetch")
            return
        }

        print("STEP 1: fetchPosts")
        Task {
            do {
                print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
               
                // Process posts and add images from S3
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                // Reload table view with new posts
                postsTableView.reloadData()

                // Reset failure count on success
                failureCount = 0
            } catch {
                print("Error fetching posts: \(error)")
                handlePollingFailure()
            }
        }
    }
    
    
    //DATA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let postViewController = segue.destination as? PostViewController,
           let selectedPost = sender as? Post {
            postViewController.currentPost = selectedPost
        }
    }

    

    // Function to start polling
    func startPolling() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.fetchPosts()
        }
    }

    // Handle failures in polling
    func handlePollingFailure() {
        failureCount += 1
        print("Polling failure count: \(failureCount)")

        if failureCount >= 3 {
            pausePolling(for: 300) // Pause for 5 minutes
        }

        if failureCount >= 4 {
            stopPolling()
            print("Polling stopped after multiple failures.")
        }
    }

    // Pause polling for a specified time interval
    func pausePolling(for seconds: TimeInterval) {
        print("Pausing polling for \(seconds) seconds")
        isPollingPaused = true
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.isPollingPaused = false
            print("Resuming polling after pause")
        }
    }

    // Stop polling entirely
    func stopPolling() {
        pollingTimer?.invalidate()
        pollingTimer = nil
        print("Polling has been stopped permanently.")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingTimer?.invalidate()  // Stop polling when the view disappears
    }

    // TABLEVIEW
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.estimatedRowHeight = 250
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
        cell.setPost(post: post)

        return cell
    }

    // DATA SEND: Send Data to New Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
    }
}
 */






//WORKING: But polling does not ever stop
/*
class HomeViewController: UIViewController {
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    let userDefaultManager = UserDefaultManager()

    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()
    
    @IBOutlet weak var postsTableView: UITableView!
    
    // Timer for polling
    var pollingTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let groupID = 72

        // Initial data fetch
        fetchPosts()

        // Start polling for updates every 10 seconds
        startPolling()

        setupTableView()
    }

    // Function to fetch posts from API
    func fetchPosts() {
        print("STEP 1: fetchPosts")
        Task {
            do {
                print("STEP 2: postsResponseModel")
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                print(postsResponseModel)
                
                // Process posts and add images from S3
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                // Reload table view with new posts
                postsTableView.reloadData()
            } catch {
                print("Error fetching posts: \(error)")
            }
        }
    }

    // Function to start polling
    func startPolling() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.fetchPosts()  // Fetch new posts every 10 seconds
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingTimer?.invalidate()  // Stop polling when the view disappears
    }

    // TABLEVIEW
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.estimatedRowHeight = 250
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
    }
    
    // DATA SEND: Send Data to New Cell
    var currentPost: Post!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let destinationVC = segue.destination as? PostViewController,
           let postToSend = sender as? Post {
            destinationVC.currentPost = postToSend
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
        cell.setPost(post: post)

        return cell
    }

    // DATA SEND: Send Data to New Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsArray[indexPath.row]
        performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
    }
}
*/



//WITH LOGIC PULLED OUT and MOVED TO loginFunctions
/*
 class LoginViewController: UIViewController, LoginLayoutManagerDelegate {
     let layoutManager = LoginLayoutManager()
     let loginManager = LoginManager()
     let userDefaultManager = UserDefaultManager()
     var activityIndicator = UIActivityIndicatorView()
     var errrorMessage = ""
     
     override func viewDidLoad() {
         super.viewDidLoad()
         print("LoginViewController")
         
         layoutManager.delegate = self
         layoutManager.setupViews(in: view)
         layoutManager.setupConstraints(in: view)
         layoutManager.setupTextFields()
         layoutManager.setupButtons(in: view)
         setupElements()
     }
     
     func setupElements() {
         activityIndicator.center = self.view.center
         activityIndicator.hidesWhenStopped = true
         activityIndicator.style = UIActivityIndicatorView.Style.medium
         self.view.addSubview(activityIndicator)
     }
     
     func didTapLoginButton() {
         print("Login Button Tapped")
         
         let logInUser = layoutManager.usernameTextField.text ?? ""
         let logInPassword = layoutManager.passwordTextField.text ?? ""
         
         // Validate inputs
         let validUsername = validateUserName(userName: logInUser)
         let validPassword = validatePassword(password: logInPassword)
         
         if !validUsername || !validPassword {
             print("Invalid username or password.")
             return
         }
         
         let deviceID = KeychainHelper.shared.getOrCreateDeviceId()
         print("Device ID:", deviceID)
         
         activityIndicator.startAnimating()
         view.isUserInteractionEnabled = false
         
         loginManager.login(username: logInUser, password: logInPassword, deviceID: deviceID) { success, message in
             DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating()
                 self.view.isUserInteractionEnabled = true
                 print(message)
                 
                 if success {
                     PresenterManager.shared.showMainApp()
                 }
             }
         }
     }
     
     func didTapForgotPasswordButton() {
         print("Forgot Password")
     }
 }

 */



//CURRENT WORKS!!
/*
class LoginViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    let loginAPI = LoginAPI()
    
    var activityIndicator = UIActivityIndicatorView()
    var errrorMessage = ""
    
    
    //VIEWS
    let logoView = UIView()
    let loginView = UIView()
    let dividerView = UIView()
    let registerView = UIView()
    let footerView = UIView()
    
    //LABELS
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController")
        setupElements()
        setupViews()
        setupConstraints()
        setupLoginLabels()
    }
    
    func setupElements() {
        
        //LABELS
        //Style.styleUsernameLabel(usernameLabel)
        //Style.styleUsernameLabel(passwordLabel)
        
        //BUTTONS
        //Buttons.styleForgotPasswordButton(forgotPasswordButton)
        //Buttons.styleLoginButton(loginButton)
        
        //Error Label
        //loginMessageLabel.alpha = 0
        
        //Style Buttons and Fields
        //Temp.styleTextField(userNameTextField)
        //Temp.styleTextField(passwordTextField)
        
        //Buttons.styleLoginFilledButton(loginButtonStyle)
        
        //Set Up Spinner
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)

    }
    
    
    
    
    func setupViews() {
        logoView.backgroundColor = .systemBlue
        loginView.backgroundColor = .white
        dividerView.backgroundColor = .gray
        registerView.backgroundColor = .systemGreen
        footerView.backgroundColor = .lightGray
        
        [logoView, loginView, dividerView, registerView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
           NSLayoutConstraint.activate([
               // LogoView - 20%
               logoView.topAnchor.constraint(equalTo: view.topAnchor),
               logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               logoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

               // LoginView - 20%
               loginView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
               loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.375),
               
               // DividerView - 15%
               dividerView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
               dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               dividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),
               
               // RegisterView - 15%
               registerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
               registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               registerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

               // FooterView - Remaining 30%
               footerView.topAnchor.constraint(equalTo: registerView.bottomAnchor),
               footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }

    func setupLoginLabels() {
        // Configure text fields
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true // Hide password input
        
        Style.styleLoginTextField(usernameTextField)
        Style.styleLoginTextField(passwordTextField)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginView.addSubview(usernameTextField)
        loginView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            // Username TextField - 12 from top
            usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
            usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 320),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField - 20 below username
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

    
        //STEP 1: Get Login Information
        let logInUser = usernameTextField.text ?? ""
        let logInPassword = passwordTextField.text ?? ""
   
        
        //STEP 2: Validate Login Information
        let validUsername = validateUserName(userName: logInUser)
        let validPassword = validatePassword(password: logInPassword)
        
        //STEP 3: Login User
        if(validUsername == true && validPassword == true) {
            
            //let deviceID = getDeviceId()
            let deviceID = KeychainHelper.shared.getOrCreateDeviceId()

            print("Device ID:", deviceID)

            Task{
                do{
                    //Get Posts from the API
                    activityIndicator.startAnimating()
                    view.isUserInteractionEnabled = false
                    let loginResponseModel = try await loginAPI.loginUser(username: logInUser, password: logInPassword, deviceID: deviceID)
                    
                    activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                    
                    //API
                    if(loginResponseModel.data.loginSuccess == true) {
                        
                        //Local Storage
                        let loginOutcome = userDefaultManager.logUserIn(userName: logInUser)
                        
                        if(loginOutcome) {
                            print("You just logged \(logInUser) in")
                            print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                            
                            PresenterManager.shared.showMainApp()
                            
                        } else {
                            print("Was an error logging in!")
                        }
                    } else {
                        //Make this the error message
                        //loginMessageLabel.alpha = 1
                        //loginMessageLabel.text = "Username or Password was wrong!"
                        print("Username or Password was wrong!")
                    }
                } catch{
                    print("yo man error!")
                    print(error)
                }
            }
            
        //STEP 3: The user did not enter information
        } else {
            if(validUsername == false && validPassword == true) {
                errrorMessage = "STEP 2: Please enter a Valid username"
                print("STEP 2: Please enter a Valid username")
            } else if(validPassword == false && validUsername == true) {
                errrorMessage = "STEP 2: Please enter a Valid password"
                print("STEP 2: Please enter a Valid password")
            } else if (validPassword == false && validUsername == false){
                errrorMessage = "STEP 2: Please enter a Valid username and password"
                print("STEP 2:  Please enter a Valid username and password")
            }
            
            //Make this the error message
            //loginMessageLabel.alpha = 1
            //loginMessageLabel.text = errrorMessage
        
        }
         
    
    }

    
    @IBAction func registerButton(_ sender: UIButton) {
        print("Register")
    }
    
    
    func loginUser(username: String, password: String, deviceID: String) async throws -> String {
        var outcome = ""
        do {
            
            let loginResponseModel = try await loginAPI.loginUser(username: username, password: password, deviceID: deviceID)
            if loginResponseModel.data.loginSuccess {
                let loginOutcome = userDefaultManager.logUserIn(userName: username)
                if loginOutcome {
                    print("You just logged \(username) in successfully.")
                    
                    outcome = "You just logged \(username) in successfully."
                    return outcome
                    
                } else {
                    outcome = "There was an error logging in!"
                    print("There was an error logging in!")
                    return outcome
                }
            } else {
                print("API returned an error during login!")
                outcome = "API returned an error during login!"
                return outcome
            }
        } catch {
            print("An error occurred during login: \(error.localizedDescription)")
            outcome = "An error occurred during login: \(error.localizedDescription)"
            return outcome
        }
    }

    
}
 
 
 
 */



//FULL CODE
/*
 import UIKit

 class LoginViewController: UIViewController {
     
     private let forgotPasswordButton: UIButton = {
         let button = UIButton()
         button.setTitle("Forgot Password?", for: .normal)
         button.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = .clear
         return button
     }()
     
     private let loginButton: UIButton = {
         let button = UIButton()
         button.setTitle("Login", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
         button.backgroundColor = UIColor(hex: "#3797EF")
         button.layer.cornerRadius = 5
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.addSubview(forgotPasswordButton)
         view.addSubview(loginButton)
         
         setupConstraints()
     }
     
     private func setupConstraints() {
         forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
         loginButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             forgotPasswordButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             
             loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
             loginButton.widthAnchor.constraint(equalToConstant: 200),
             loginButton.heightAnchor.constraint(equalToConstant: 40)
         ])
     }
 }

 // UIColor Extension for Hex Colors
 extension UIColor {
     convenience init(hex: String) {
         var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
         hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

         var rgb: UInt64 = 0
         Scanner(string: hexSanitized).scanHexInt64(&rgb)

         let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
         let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
         let b = CGFloat(rgb & 0xFF) / 255.0

         self.init(red: r, green: g, blue: b, alpha: 1.0)
     }
 }

 */

/*
 @IBOutlet weak var startLabel: UILabel!
 
 var activityIndicator = UIActivityIndicatorView()

 
 override func viewDidLoad() {
     super.viewDidLoad()
     activityIndicator.center = self.view.center
     activityIndicator.hidesWhenStopped = true
     activityIndicator.style = UIActivityIndicatorView.Style.medium
     self.view.addSubview(activityIndicator)
     
 }


 @IBAction func startButton(_ sender: UIButton) {
     print("start")
     activityIndicator.startAnimating()
     startLabel.text = "Getting some posts man!"
     view.isUserInteractionEnabled = false
     
     Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
         self.activityIndicator.stopAnimating()
         self.view.isUserInteractionEnabled = true
         self.startLabel.text = "Got them posts dude!"
     }
 }
 

 // Optionally disable specific controls like buttons
 //actionButton.isEnabled = false


 @IBAction func stopButton(_ sender: UIButton) {
     print("stop")
     startLabel.text = "I am Stopped"
     activityIndicator.stopAnimating()

 }
 
 */


//WORKS
/*
func setupTextFields() {
    usernameTextField.placeholder = "Username"
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    
    Style.styleLoginTextField(usernameTextField)
    Style.styleLoginTextField(passwordTextField)
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    loginView.addSubview(usernameTextField)
    loginView.addSubview(passwordTextField)
    
    NSLayoutConstraint.activate([
        usernameTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 12),
        usernameTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
        usernameTextField.widthAnchor.constraint(equalToConstant: 320),
        usernameTextField.heightAnchor.constraint(equalToConstant: 40),
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
        passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
        passwordTextField.widthAnchor.constraint(equalToConstant: 320),
        passwordTextField.heightAnchor.constraint(equalToConstant: 40)
    ])
}
*/


/*
 HomeViewController
 //WORKING: But polling does not ever stop
 /*
 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()
     
     @IBOutlet weak var postsTableView: UITableView!
     
     // Timer for polling
     var pollingTimer: Timer?
     
     override func viewDidLoad() {
         super.viewDidLoad()
         let groupID = 72

         // Initial data fetch
         fetchPosts()

         // Start polling for updates every 10 seconds
         startPolling()

         setupTableView()
     }

     // Function to fetch posts from API
     func fetchPosts() {
         print("STEP 1: fetchPosts")
         Task {
             do {
                 print("STEP 2: postsResponseModel")
                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)
                 print(postsResponseModel)
                 
                 // Process posts and add images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)

                 // Reload table view with new posts
                 postsTableView.reloadData()
             } catch {
                 print("Error fetching posts: \(error)")
             }
         }
     }

     // Function to start polling
     func startPolling() {
         pollingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
             self?.fetchPosts()  // Fetch new posts every 10 seconds
         }
     }

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         pollingTimer?.invalidate()  // Stop polling when the view disappears
     }

     // TABLEVIEW
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }
     
     // DATA SEND: Send Data to New Cell
     var currentPost: Post!
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let destinationVC = segue.destination as? PostViewController,
            let postToSend = sender as? Post {
             destinationVC.currentPost = postToSend
         }
     }
 }

 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
         cell.setPost(post: post)

         return cell
     }

     // DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }
 }
 */



 
 //CHAT
 /*
  import UIKit

  class MakePostViewController: UIViewController {
      
      let userDefaultManager = UserDefaultManager()
      let postAPI = PostAPI()
      
      @IBOutlet weak var postImageView: UIImageView!
      @IBOutlet weak var captionTextField: UITextField!
      @IBOutlet weak var postButton: UIButton!
      
      var selectedImage: UIImage?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          postImageView.isUserInteractionEnabled = true
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
          postImageView.addGestureRecognizer(tapGesture)
      }
      
      @objc func selectImage() {
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          picker.allowsEditing = true
          present(picker, animated: true)
      }
      
      @IBAction func makePostButtonTapped(_ sender: UIButton) {
          guard let postImage = selectedImage, let caption = captionTextField.text, !caption.isEmpty else {
              print("Image and caption are required")
              return
          }
          
          Task {
              do {
                  let currentUser = userDefaultManager.getLoggedInUser()
                  let response = try await postAPI.makePhotoPost(postImage: postImage, postFrom: currentUser, postTo: "some_destination", postCaption: caption, groupID: 1, listID: 1)
                  print("Post successful: \(response)")
                  navigationController?.popViewController(animated: true)
              } catch {
                  print("Failed to make post: \(error)")
              }
          }
      }
  }

  extension MakePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[.editedImage] as? UIImage {
              postImageView.image = selectedImage
              self.selectedImage = selectedImage
          }
          picker.dismiss(animated: true)
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true)
      }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  */
 /*
  //
  //  EditProfileViewController.swift
  //  Kite
  //
  //  Created by David Vasquez on 1/12/25.
  //

  import UIKit


  protocol EditProfileViewControllerDelegate: AnyObject {
      //func didUpdateProfile(firstName: String, lastName: String, biography: String)
      func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?)

  }


  class EditProfileViewController: UIViewController {
      let profileAPI = ProfileAPI()
      let userDefaultManager = UserDefaultManager()

      @IBOutlet weak var userImageView: UIImageView!
      @IBOutlet weak var userNameField: UITextField!
      @IBOutlet weak var userFullNameField: UITextField!
      @IBOutlet weak var userBiographyTextArea: UITextView!
      
      //Incoming Data
      var inputFirstName: String! //First Name
      var inputLastName: String! //Last Name
      var inputBiography: String!
      var inputProfileImage: UIImage?
     
      // Delegate property
      weak var delegate: EditProfileViewControllerDelegate?
      
      var selectedProfileImage: UIImage?

      override func viewDidLoad() {
          super.viewDidLoad()
          let firstName: String = inputFirstName ?? ""
          let lastName : String = inputLastName ?? ""
          let biography : String = inputBiography ?? ""
          
          if let profileImage = inputProfileImage {
              userImageView.image = profileImage
          }
          
          userNameField.text = firstName
          userFullNameField.text = lastName
          userBiographyTextArea.text = biography
          
      }

      @IBAction func editPhotoButton(_ sender: UIButton) {
          let vc = UIImagePickerController()
          vc.sourceType = .photoLibrary
          vc.delegate = self
          vc.allowsEditing = true
          present(vc, animated: true)
      }
      
      
      
      @IBAction func saveButtonTapped(_ sender: UIButton) {
          let currentUser = userDefaultManager.getLoggedInUser()
          let updatedFirstName = userNameField.text ?? ""
          let updatedLastName = userFullNameField.text ?? ""
          let updatedBiography = userBiographyTextArea.text ?? ""

           //TYPE 1: Image Not Updated
           if selectedProfileImage == nil || selectedProfileImage == inputProfileImage {
               print("TYPE 1: Image is the same")
               
               Task {
                   do {
                       let updatedProfileResponse = try await profileAPI.updateUserProfileAPI(
                           currentUser: currentUser,
                           imageName: "currentUser",
                           firstName: updatedFirstName,
                           lastName: updatedLastName,
                           biography: updatedBiography
                       )

                       // Notify the delegate with the updated data
                       delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: nil)

                       // Go back to ProfileViewController
                       navigationController?.popViewController(animated: true)
                   
                   } catch {
                       print("Failed to update profile: \(error)")
                   }
               }
               
           //TYPE 2: Image Updated
           } else {
               print("TYPE 2: Image Changed")
               guard let newProfileImage = selectedProfileImage else {
                    print("No new image selected. Skipping image update.")
                    return
                }
               
               Task {
                   do {
                       let updatedProfileResponse = try await profileAPI.updateFullUserProfileAPI(currentUser: currentUser, profileImage: newProfileImage, firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)

                       // Notify the delegate with the updated data
                       //delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)
                       delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: newProfileImage)

                       // Go back to ProfileViewController
                       navigationController?.popViewController(animated: true)
                   
                   } catch {
                       print("Failed to update profile: \(error)")
                   }
               }
           }
       

      }

    
      
      // New function to handle full profile update when image is changed
      func fullProfileUpdate() {
          print("Updating full profile with new image...")
          // Mock function to handle full profile update
          // You can replace this with the actual API call
      }

  }


  extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
              print("You picked an image! dude!")
              userImageView.image = selectedImage
              selectedProfileImage = selectedImage
          }
          print("Here some info DUDE \(info)")
          picker.dismiss(animated: true)
      }
      
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          print("ah never mind dude!")
          picker.dismiss(animated: true)
      }
  }


  */
 /*
  //
  //  ViewController.swift
  //  sendFormDataToAPI
  //
  //  Created by David Vasquez on 8/11/24.
  //

  import UIKit


  class ViewController: UIViewController {

      let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
      let imageOne: UIImage = UIImage(named: "lake")!
      let imageTwo: UIImage = UIImage(named: "lake_png")!
      
      @IBOutlet weak var imageView: UIImageView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          
      }
      
      
      @IBAction func newPhotoPostButton(_ sender: UIButton) {
          print("hi")

          imageView.image = imageOne
          
          Task{
              do{
                  //Get Posts from the API
                  let newPostResponseModel = try await uploadPhotoPost(postImage: imageOne, postFrom: "davey", postTo: "sam", postCaption: "Hiya!!", groupID: 72, listID: 0)
       
                  print(" ")
                  print("RETURNED")
                  print(newPostResponseModel)
                  print("SUCCESS")
              } catch{
                  print("yo man error!")
                  print(error)
              }
          }
     
     
      }
      
      func uploadPhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
          let postType = "photo"
          let masterSite = "kite"
          let notificationMessage = "Posted a Photo"
          let notificationType = "new_post_photo"
          let notificationLink = "http://localhost:3003/posts/group/72"
          
              
          //STEP 1: Create the URL
          let endpoint = "http://localhost:3003/post/photo/local"
          
          guard let url = URL(string: endpoint) else {
              throw networkError.invalidURL
          }
          
          //STEP 2: Create the Request
          var request = URLRequest(url: url)
          let boundary = UUID().uuidString
          request.httpMethod = "POST"
          request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
          
          //STEP 3: Create the Form Data and Photo
          let body = NSMutableData()

      
          //Post Type
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postType\"\r\n\r\n")
          body.appendString("\(postType)\r\n")
              
          //Master Site
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"masterSite\"\r\n\r\n")
          body.appendString("\(masterSite)\r\n")

          //Post From
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postFrom\"\r\n\r\n")
          body.appendString("\(postFrom)\r\n")
          
          //Post To
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postTo\"\r\n\r\n")
          body.appendString("\(postTo)\r\n")
         
          //Group ID
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"groupID\"\r\n\r\n")
          body.appendString("\(groupID)\r\n")
          
          //List ID
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"listID\"\r\n\r\n")
          body.appendString("\(listID)\r\n")
          
          //Post Caption
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
          body.appendString("\(postCaption)\r\n")
          
          //Notification Message
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationMessage\"\r\n\r\n")
          body.appendString("\(notificationMessage)\r\n")
          
          //Notification Type
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationType\"\r\n\r\n")
          body.appendString("\(notificationType)\r\n")
          
          //Notification Link
          body.appendString("--\(boundary)\r\n")
          body.appendString("Content-Disposition: form-data; name=\"notificationLink\"\r\n\r\n")
          body.appendString("\(notificationLink)\r\n")
      
          if let imageData = postImage.jpegData(compressionQuality: 1.0) {
              body.appendString("--\(boundary)\r\n")
              body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
              body.appendString("Content-Type: image/jpeg\r\n\r\n")
              body.append(imageData)
              body.appendString("\r\n")
          }
          
          body.appendString("--\(boundary)--\r\n")
          
          request.httpBody = body as Data
          
          //STEP 4: Handle the Response
          let (data, response) = try await URLSession.shared.data(for: request)
                 
          guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
              throw networkError.invalidResponse
          }
          
          do {
              let decoder = JSONDecoder ()
              let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

              print("API")
              print(newPostResponseModel)
              print("API")
              return newPostResponseModel
              
          } catch {
              let newPostResponseModel = NewPostResponseModel()
              print("Error decoding data")
              print(newPostResponseModel)
              return newPostResponseModel
              
          }
      }

  }



  // Extension to NSMutableData for convenience
  extension NSMutableData {
      func appendString(_ string: String) {
          if let data = string.data(using: .utf8) {
              append(data)
          }
      }
  }



  enum networkError: Error {
      case invalidURL
      case invalidResponse
      case invalidData
  }

  */



 /*

 class HomeViewController: UIViewController {
     let loginAPI = LoginAPI()
     let postsAPI = PostsAPI()
     let userDefaultManager = UserDefaultManager()

     var postsArrayNoImage = [Post]()
     var postsArray = [Post]()

     
     @IBOutlet weak var postsTableView: UITableView!
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         let groupID = 72

         Task{

             do{

                 let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
                 //print(postsResponseModel)
                 
                 //Add Post Images from S3
                 postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                 postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
    
                 for post in postsArray {
                     //print("POST: \(post.postCaption) \(post.fileUrl)")
                 }
                 
                 postsTableView.reloadData()

             } catch{
                 print("yo man error!")
                 print(error)
             }
         }

         setupTableView()
         
     }

     //TABLEVIEW
     func setupTableView() {
         postsTableView.delegate = self
         postsTableView.dataSource = self
         postsTableView.estimatedRowHeight = 250
         postsTableView.rowHeight = UITableView.automaticDimension
         postsTableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
     }
     
     //DATA SEND: Send Data to New Cell
     var currentPost:Post!
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.Segue.showIndividualPost,
            let destinationVC = segue.destination as? PostViewController,
            let postToSend = sender as? Post {
             destinationVC.currentPost = postToSend
         }
     }
     
 }

 extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postsArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = postsArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell") as! IndividualPostCell
         cell.setPost(post: post)

         return cell
     }

     
     //DATA SEND: Send Data to New Cell
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postsArray[indexPath.row]
         performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
     }

 }


 */

 */


/*
 protocol InputDelegate {
     func userLikePost(currentPostID: Int)
     func userUnlikePost(currentPostID: Int)
 }


 class IndividualPostViewController: UIViewController {
     var myDelegate: InputDelegate? = nil
     let postAPI = PostsAPI()
     var selectedPost = Post(postID: 0)
     var currentUser = "davey"

     @IBOutlet weak var postImage: UIImageView!
     @IBOutlet weak var postCaptionLabel: UILabel!
     @IBOutlet weak var postLikeCountLabel: UILabel!
     @IBOutlet weak var postLikeButtonStyle: UIButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()

         setUpView(selectedPost: selectedPost)
         
         
     }
     

     //SETUP: Setup the view
     func setUpView(selectedPost: Post) {
         let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         postImage.image = selectedPost.postImageData
         postCaptionLabel.text = selectedPost.postCaption
         postLikeCountLabel.text = String(likeCount)

  
         //Like Button
         if simpleLikesArray.contains(currentUser) {
             //print("User has liked the post so text should be UNLIKE")
             let likedImage = UIImage(named: "liked")
             postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
             postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
           
         } else {
             print("User has NOT liked the post so text should be LIKE")
             let likedImage = UIImage(named: "like")
             postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
             postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
           
         }
         

     }


     @IBAction func postLikeButton(_ sender: UIButton) {
         let activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.center = view.center;
         view.addSubview(activityIndicator);
         
         
         //STEP 1: Determine if Post is Already Liked
         let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
         let groupID : Int = selectedPost.groupID ?? 0
         
         //STEP 2A: Make Call to API to Like a Post
         if !simpleLikesArray.contains(currentUser) {
             //print("Like Me")
             Task{
                 //activityIndicator.startAnimating()
                 do{
                     let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                     
                     //Success
                     if(likePostResponseModel.success == true) {
                         //flipButton(withString: "", on: sender)
                         postLikeCountLabel.text = String(simpleLikesArray.count + 1)
                         let likedImage = UIImage(named: "liked")
                         postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                         postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                       
                         
                         if (myDelegate != nil) {
                             print("DELEGATE: Individual Post VC You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                         }
                         
                         //Error: Handled by API
                     } else {
                         print("error dudee!")
                         
                     }
                     
                     //Error: Not expected
                 } catch{
                     print("yo man error!")
                     print(error)
                 }
             }
         
         //STEP 2B: Make Call to API to Unlike a Post
         } else {
             //print("Already Liked")
             Task{
                 do{
                     let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                     
                     //Success
                     if(unlikePostResponseModel.success == true) {
                         
                         postLikeCountLabel.text = String(simpleLikesArray.count - 1)
                         let likedImage = UIImage(named: "like")
                         postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                         postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
                       
                         if (myDelegate != nil) {
                             print("DELEGATE: Individual Post VC You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                             myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                         }
                         
                     //Error: Handled by API
                     } else {
                         print("error dudee!")
                         
                     }
          
                 //Error: Not expected
                 } catch {
                     
                     print("yo man error!")
                     print(error)
                 }
             }

         }
         
     }
     
    
 }

 /*
  @IBOutlet weak var startLabel: UILabel!
  var activityIndicator = UIActivityIndicatorView()

  
  override func viewDidLoad() {
      super.viewDidLoad()
      activityIndicator.center = self.view.center
      activityIndicator.hidesWhenStopped = true
      activityIndicator.style = UIActivityIndicatorView.Style.medium
      self.view.addSubview(activityIndicator)
      
      
  }


  @IBAction func startButton(_ sender: UIButton) {
      print("start")
      activityIndicator.startAnimating()
      startLabel.text = "Getting some posts man!"
      view.isUserInteractionEnabled = false
      
      Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
          self.activityIndicator.stopAnimating()
          self.view.isUserInteractionEnabled = true
          self.startLabel.text = "Got them posts dude!"
      }
  }
  

  // Optionally disable specific controls like buttons
  //actionButton.isEnabled = false


  @IBAction func stopButton(_ sender: UIButton) {
      print("stop")
      startLabel.text = "I am Stopped"
      activityIndicator.stopAnimating()

  }
  
  */


 /*

  import UIKit

  protocol InputDelegate {
      func userLikePost(currentPostID: Int)
      func userUnlikePost(currentPostID: Int)
  }


  class IndividualPostViewController: UIViewController {
      var myDelegate: InputDelegate? = nil
      
      let postAPI = PostsAPI()
      var selectedPost = Post(postID: 0)
      var currentUser = "davey"

      @IBOutlet weak var singlePostImageView: UIImageView!
      @IBOutlet weak var singlePostLabel: UILabel!
      @IBOutlet weak var likeCountLabel: UILabel!
      @IBOutlet weak var likeButtonTextOutlet: UIButton!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setUpView(selectedPost: selectedPost)
          
      }
      
      @IBAction func likePostButton(_ sender: UIButton) {
          
          //STEP 1: Determine if Post is Already Liked
          let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
          let groupID : Int = selectedPost.groupID ?? 0
          
          //STEP 2A: Make Call to API to Like a Post
          if !simpleLikesArray.contains(currentUser) {
              Task{
                  do{
                      let likePostResponseModel = try await postAPI.likePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
      
                      //Success
                      if(likePostResponseModel.success == true) {
                          flipButton(withString: "", on: sender)
                          likeCountLabel.text = String(simpleLikesArray.count + 1)
                          
                          if (myDelegate != nil) {
                              print("You liked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                              myDelegate!.userLikePost(currentPostID: selectedPost.postID)
                          }
                          
                      //Error: Handled by API
                      } else {
                          print("error dudee!")
                          
                      }
                  
                  //Error: Not expected
                  } catch{
                      print("yo man error!")
                      print(error)
                  }
              }
          
          //STEP 2B: Make Call to API to Unlike a Post
          } else {
              Task{
                  do{
                      let unlikePostResponseModel = try await postAPI.unlikePostAPI(currentUser: "davey", postID: selectedPost.postID, groupID: groupID)
                      
                      //Success
                      if(unlikePostResponseModel.success == true) {
                          
                          likeCountLabel.text = String(simpleLikesArray.count - 1)
        
                          if (myDelegate != nil) {
                              print("You unliked the Post with post ID \(selectedPost.postID) and group ID \(groupID)")
                              myDelegate!.userUnlikePost(currentPostID: selectedPost.postID)
                          }
                          
                      //Error: Handled by API
                      } else {
                          print("error dudee!")
                          
                      }
           
                  //Error: Not expected
                  } catch{
                      print("yo man error!")
                      print(error)
                  }
              }

          }
      }
      

      //BUTTON: Handle Button UI Change
      func flipButton(withString addFriend: String, on button: UIButton) {
          if button.currentTitle == "Like" {
              button.setTitle("UnLike", for: UIControl.State.normal)
          } else {
              button.setTitle("Like", for: UIControl.State.normal)
          }
      }
      

      //SETUP: Setup the view
      func setUpView(selectedPost: Post) {
          let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
          let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
          //print("LIKES \(simpleLikesArray.count)")
          
          //SETUP: Set Like Text on the Button for Like or Unlike
          if simpleLikesArray.contains(currentUser) {
              //print("User has liked the post so text should be UNLIKE")
              likeButtonTextOutlet.setTitle("Unlike", for: .normal)
          } else {
              //print("User has NOT liked the post so text should be LIKE")
              likeButtonTextOutlet.setTitle("Like", for: .normal)
          }
          
          singlePostImageView.image = selectedPost.postImageData
          singlePostLabel.text = selectedPost.postCaption
          likeCountLabel.text = String(likeCount)
      }
      
  }





//Get Posts
/*
Task{
    do{
        //Get Posts from the API
        let postResponseModel = try await postsAPI.getPostsAPI()
        print(postResponseModel.data[0].postCaption)
        
        
    } catch{
        print("yo man error!")
        print(error)
    }
}
 */

/*
 
 @IBAction func getLoginStatusTemp(_ sender: UIButton) {
     let loginStatus = userDefaultManager.getLoggedInUserStatus()
     print("User is Logged in \(loginStatus)")
 }
 
 
 @IBAction func logoutButton(_ sender: UIButton) {
     let loggedInUser = userDefaultManager.getLoggedInUser()
     AuthManager.shared.logoutCurrentUser()
  
 }
 */
/*
 Task{
     do{
         //Get Posts from the API
         let loginResponseModel = try await loginAPI.loginUser(username: "davey", password: "password")
        
         //API
         if(loginResponseModel.data.loginSuccess == true) {
             
             //Local Storage
             let loginOutcome = userDefaultManager.logUserIn(userName: loggedInUser)
             
             if(loginOutcome) {
                 print("You just logged \(loggedInUser) in")
                 print("API \(loginResponseModel.data.loggedInUser) \(loginResponseModel.data.loginSuccess)")
                 
             } else {
                 print("Was an error logging in!")
             }
             
             
         } else {
             print("API Was an error logging in!")
         }
         
     } catch{
         print("yo man error!")
         print(error)
     }
 }



//STEP 1: Set User Defaults
let loginOutcome = userDefaultManager.logUserOut()

if(loginOutcome) {
    print("You just logged out")
} else {
    print("Was an error logging out!")
}

//STEP 2: Call Logout API
Task{
    do{
        let logoutResponseModel = try await loginAPI.logoutUser(username: loggedInUser)
        
        print(logoutResponseModel)
       
        if(logoutResponseModel.success == true) {
            print("API Logout worked!")
   
        } else {
            print("API Was an error logging out!")
        }
        
    } catch{
        print("yo man error!")
        print(error)
    }
}

//STEP 3: Navigate to Login Screen
PresenterManager.shared.showOnboarding()
*/

  

//GROUPS
//New Group
/*
Task{
    do{
        let newGroupResponseModel = try await groupsAPI.newGroup(currentUser: "davey", groupName: "music", groupType: "kite", groupPrivate: 1, groupUsers: ["davey", "sam",  "merry", "Frodo", "frodo", " pippin"], notificationMessage: "Invited you to a new Group", notificationType: "group_invite", notificationLink: "http://localhost:3003/group/77")
        
        if(newGroupResponseModel.statusCode == 401) {
            AuthManager.shared.logoutCurrentUser()
        }
        
        print(newGroupResponseModel)
        
     
    } catch{
        print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
        print(error)
        //AuthManager.shared.logoutCurrentUser()
    }
}
 */*/*/

//Get Group
/*
Task{
    do{
        let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
        
        if(groupsResponseModel.statusCode == 401) {
            AuthManager.shared.logoutCurrentUser()
        }
        
        print(groupsResponseModel)
        
   
    } catch{
        print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
        print(error)
        //AuthManager.shared.logoutCurrentUser()
    }
}
*/
