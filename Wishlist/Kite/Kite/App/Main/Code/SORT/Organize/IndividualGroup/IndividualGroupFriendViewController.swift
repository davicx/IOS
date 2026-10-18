//
//  IndividualGroupFriendViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

import UIKit


//LISTS: Wishlist - Shared With Me
class IndividualGroupFriendViewController: UIViewController {

    //GROUPS
    var group: GroupModel?
    let postDataController = PostDataController.shared
    let usersDataController = UsersDataController.shared
    
    //GROUP USERS
    private var groupMembers: [User] = []
    
    //VIEWS SETUP
    private let tableView = UITableView()
    private let pollingManager = PollingManager()
    
    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //VIEWS SETUP
        setupTableView()

        // Start polling
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchItemsForGroup()
        }
        pollingManager.startPolling()
        
        //GROUPS
        let groupID = group?.groupID ?? 0
        let groupName = group?.groupName ?? "No Group Name"
        
        if let group = group {
            Task {
                await fetchGroupMemberProfiles()
                print("IndividualGroupFriendViewController \(groupID)")
            }
        } else {
            print("No group data available")
        }
         
        // Observe item updates (not post updates)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(itemsUpdated),
            name: .itemsFetched,
            object: nil
        )
    }
    
    @objc private func itemsUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsForGroup()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "IndividualGroupFriendViewController")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pollingManager.stopPolling()
    }
    

    //LAYOUT
    //Header Layout
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupItemFriendCell.self, forCellReuseIdentifier: "GroupItemFriendCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.tableHeaderView = createTableHeader()
        tableView.tableFooterView = UIView()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    private func createTableHeader() -> UIView {
        let headerHeight: CGFloat = 160
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        // Create the scroll view for group members
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        headerView.addSubview(scrollView)

        // Create stack view inside scroll view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        let groupHeaderView = UIView()
        groupHeaderView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(groupHeaderView)
        
        // Create subviews for groupHeaderView
        let groupHeaderNameView = UIView()
        groupHeaderNameView.translatesAutoresizingMaskIntoConstraints = false
        groupHeaderView.addSubview(groupHeaderNameView)
        
        let groupHeaderNewPostView = UIView()
        groupHeaderNewPostView.translatesAutoresizingMaskIntoConstraints = false
        groupHeaderView.addSubview(groupHeaderNewPostView)
        
        // Add new post button to groupHeaderNewPostView
        let newPostButton = UIButton(type: .system)
        newPostButton.setTitle("+", for: .normal)
        newPostButton.setTitleColor(.systemBlue, for: .normal)
        newPostButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        newPostButton.translatesAutoresizingMaskIntoConstraints = false
        newPostButton.addTarget(self, action: #selector(newPostButtonTapped), for: .touchUpInside)
        groupHeaderNewPostView.addSubview(newPostButton)

        NSLayoutConstraint.activate([
            // Header view constraints
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            headerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            // Group header view constraints (at the top)
            groupHeaderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            groupHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            groupHeaderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            groupHeaderView.heightAnchor.constraint(equalToConstant: 40),
            
            // Group header name view constraints (left, centered, fill all space)
            groupHeaderNameView.topAnchor.constraint(equalTo: groupHeaderView.topAnchor),
            groupHeaderNameView.leadingAnchor.constraint(equalTo: groupHeaderView.leadingAnchor),
            groupHeaderNameView.bottomAnchor.constraint(equalTo: groupHeaderView.bottomAnchor),
            groupHeaderNameView.trailingAnchor.constraint(equalTo: groupHeaderNewPostView.leadingAnchor),
            
            // Group header new post view constraints (60 wide, right centered)
            groupHeaderNewPostView.topAnchor.constraint(equalTo: groupHeaderView.topAnchor),
            groupHeaderNewPostView.trailingAnchor.constraint(equalTo: groupHeaderView.trailingAnchor),
            groupHeaderNewPostView.bottomAnchor.constraint(equalTo: groupHeaderView.bottomAnchor),
            groupHeaderNewPostView.widthAnchor.constraint(equalToConstant: 60),
            
            // New post button constraints (centered in groupHeaderNewPostView)
            newPostButton.centerXAnchor.constraint(equalTo: groupHeaderNewPostView.centerXAnchor),
            newPostButton.centerYAnchor.constraint(equalTo: groupHeaderNewPostView.centerYAnchor),

            // Scroll view constraints (below group header view)
            scrollView.topAnchor.constraint(equalTo: groupHeaderView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 120),
            scrollView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            // Stack view constraints
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        // Add group members to the scroll view
        setupGroupMembersInScrollView(stackView)

        // Force layout to ensure proper sizing
        headerView.layoutIfNeeded()
        
        return headerView
    }
    
    

    //FUNCTIONS
    private func fetchItemsForGroup() {
        guard let groupID = group?.groupID else {
            print("No group ID available")
            return
        }

        Task {
            // Fetch items (items are posts with additional item-specific data)
            await postDataController.fetchWishlistItems(groupID: groupID)
            
            // Print out item names to verify it's working
            DispatchQueue.main.async {
                print("________________________")
                print("IndividualGroupFriendViewController: fetchItemsForGroup \(groupID)")
                let items = self.postDataController.getPostsForGroup(groupID: groupID).filter { $0.postType == "item" }
                print("Total items fetched: \(items.count)")
                for item in items {
                    print("- Item Name: \(item.itemName ?? "No Name"), PostID: \(item.postID)")
                }
                print("________________________")
            }
        }
    }
    
    private func fetchGroupMemberProfiles() async {
        guard let group = group else {
            print("No group data available for fetching member profiles")
            return
        }
        
        let allMembers = group.activeGroupMembers + group.pendingGroupMembers
     
        // Fetch all member profiles with images using UsersDataController
        // refreshFriendshipStatus: true ensures we get fresh friendship data (friends, pending, etc.)
        // while still caching profile data (name, image, bio) for performance
        let groupMembers = await usersDataController.fetchUsersWithImages(usernames: allMembers, refreshFriendshipStatus: true)
        
        self.groupMembers = groupMembers
        
        // Refresh the table header to show the group members
        DispatchQueue.main.async {
            self.tableView.tableHeaderView = self.createTableHeader()
        }
    }
    
    private func setupGroupMembersInScrollView(_ stackView: UIStackView) {
        // Clear any existing arranged subviews
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for member in groupMembers {
            let memberView = createGroupMemberView(for: member)
            stackView.addArrangedSubview(memberView)
        }
    }
    
    private func createGroupMemberView(for member: User) -> UIView {
        // Container view for the member (120x120)
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Enable user interaction for tap gestures on the entire container
        containerView.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to the container view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userImageTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        
        // Store the userID as a tag on the container view for later use
        containerView.tag = member.userID
        
        // Profile image view (92x92)
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 42 // Half of 84
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemGray5
        
        // Set the profile image
        if let profileImage = member.profileImage {
            imageView.image = profileImage
        } else {
            // Fallback to default image
            imageView.image = UIImage(named: "background_1")
        }
        
        // Username label (20 tall, 120 wide)
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "@\(member.userName)"
        usernameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        usernameLabel.textColor = .label
        usernameLabel.textAlignment = .center
        usernameLabel.numberOfLines = 1
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.minimumScaleFactor = 0.8
        
        containerView.addSubview(imageView)
        containerView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            // Container view constraints (120x120)
            containerView.widthAnchor.constraint(equalToConstant: 120),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            // Image view constraints (84x84, centered horizontally)
            imageView.widthAnchor.constraint(equalToConstant: 84),
            imageView.heightAnchor.constraint(equalToConstant: 84),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // Username label constraints (16 tall, 120 wide, at bottom)
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 16),
            usernameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
        
        return containerView
    }
    
    //ACTIONS
    @objc private func userImageTapped(_ gesture: UITapGestureRecognizer) {
        guard let containerView = gesture.view else { return }
        let userID = containerView.tag
        
        // Find the user by ID
        guard let user = groupMembers.first(where: { $0.userID == userID }) else { return }
        
        print("Go to Profile: \(user.userName)")
        
        // Navigate to IndividualGroupMembersVC
        let membersVC = GroupMembersViewController()
        //group.groupName
        let groupName: String = group?.groupName ?? "Group Members"
        membersVC.title = groupName
        membersVC.groupMembers = self.groupMembers
        navigationController?.pushViewController(membersVC, animated: true)
    }
    
    @objc private func newPostButtonTapped() {
        let storyboard = UIStoryboard(name: "Groups", bundle: nil) // change "Main" if you put it in another storyboard
        if let newPostVC = storyboard.instantiateViewController(withIdentifier: "MakePostViewController") as? NewPostViewController {
            // Pass the current group ID to the MakePostViewController
            newPostVC.groupID = group?.groupID ?? 0
            newPostVC.modalPresentationStyle = .fullScreen  // makes it fill screen
            present(newPostVC, animated: true, completion: nil)
        }
    }

}


extension IndividualGroupFriendViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groupID = group?.groupID else { return 0 }
        // return postDataController.posts.count
        let items = postDataController.getPostsForGroup(groupID: groupID).filter { $0.postType == "item" }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupID = group?.groupID else {
            return UITableViewCell()
        }
        let items = postDataController.getPostsForGroup(groupID: groupID).filter { $0.postType == "item" }
        let post = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupItemFriendCell", for: indexPath) as! GroupItemFriendCell
        cell.configurePost(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let groupID = group?.groupID else { return }
        // Get the post at the tapped index (items are posts with postType == "item")
        let items = postDataController.getPostsForGroup(groupID: groupID).filter { $0.postType == "item" }
        let post = items[indexPath.row]
        
        print("Right now cant navigate to new item")


        /*
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        if let postViewController = storyboard.instantiateViewController(withIdentifier: "IndividualPostViewController") as? IndividualPostViewController {
            // Pass the post as currentPost (it's an item if postType == "item")
            postViewController.currentPost = post
            navigationController?.pushViewController(postViewController, animated: true)
        }
        */
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Auto-sizing for dynamic content
        return UITableView.automaticDimension
        
        // Original manual height calculation (commented out for auto-sizing)
        /*
        let currentPost = postDataController.posts[indexPath.row]
        let currentPostImage = currentPost.postImageData

        // Get Image Height
        let defaultImage = UIImage(named: "background_1") ?? UIImage()
        let currentImage = currentPostImage ?? defaultImage
        let postImageHeight = round(getImageHeight(image: currentImage))

        // Get Caption Height
        let postCaption = currentPost.postCaption ?? "no caption"
        let postCaptionHeight = round(calculateLabelHeight(text: postCaption))

        //return StyleConstants.postHeader + postImageHeight + StyleConstants.postSocials + postCaptionHeight + StyleConstants.postDivider
        return 122
        */
    }
}
