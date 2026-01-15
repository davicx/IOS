//
//  IndividualGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

import UIKit


//CHAT
class IndividualGroupViewController: UIViewController {

    //GROUPS
    var groupID: Int?
    var currentUserOwnsGroup: Bool = false
    let postDataController = PostDataController.shared
    let usersDataController = UsersDataController.shared
    
    //GROUP USERS
    private var groupMembers: [User] = []
    
    //VIEWS SETUP
    private let tableView = UITableView()
    private let pollingManager = PollingManager()
    let imageFunctions = ImageFunctions()
    
    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        getGroupPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printPageInfo(vcName: "IndividualGroupViewController")
        
        // Print the passed data
        print("________________________")
        print("IndividualGroupViewController Data:")
        print("groupID: \(groupID ?? -1)")
        print("currentUserOwnsGroup: \(currentUserOwnsGroup)")
        print("________________________")
 
    }
    
    func getGroupPosts() {
        // Fetch posts for this group
        if let groupID = groupID {
            Task {
                await GroupLogic.shared.fetchGroupPosts(groupID: groupID)
                
                // Print post IDs and captions
                DispatchQueue.main.async {
                    let posts = self.postDataController.getPostsForGroup(groupID: groupID)
                    print("________________________")
                    print("IndividualGroupViewController: Posts for groupID \(groupID)")
                    print("Total posts: \(posts.count)")
                    for post in posts {
                        print("Post ID: \(post.postID), Caption: \(post.postCaption ?? "No caption")")
                    }
                    print("________________________")
                }
            }
        }
    }
    
    //LAYOUT
    private func setupNavigationBar() {
        navigationItem.title = "Wishlist"

        let newGroupPostButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newGroupPostButton)
        )
        navigationItem.rightBarButtonItem = newGroupPostButton

        if let image = UIImage(named: "user") {
            let circularImage = imageFunctions
                .makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
                .withRenderingMode(.alwaysOriginal)

            let button = UIButton(type: .custom)
            button.setImage(circularImage, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
            button.layer.cornerRadius = 14
            button.clipsToBounds = true
            button.contentEdgeInsets = .zero
            button.imageEdgeInsets = .zero
            button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)

            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
    //ACTIONS
    @objc private func newGroupPostButton() {
        print("New Post")
    }
    
    @objc private func openProfile() {
        print("Profile tapped")
    }
}


/*
class IndividualGroupViewController: UIViewController {

    //GROUPS
    var groupID: Int?
    var currentUserOwnsGroup: Bool = false
    let postDataController = PostDataController.shared
    let usersDataController = UsersDataController.shared
    
    //GROUP USERS
    private var groupMembers: [User] = []
    
    //VIEWS SETUP
    private let tableView = UITableView()
    private let pollingManager = PollingManager()
    let imageFunctions = ImageFunctions()
    
    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        getGroupPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printPageInfo(vcName: "IndividualGroupViewController")
        
        // Print the passed data
        print("________________________")
        print("IndividualGroupViewController Data:")
        print("groupID: \(groupID ?? -1)")
        print("currentUserOwnsGroup: \(currentUserOwnsGroup)")
        print("________________________")
 
    }
    
    func getGroupPosts() {
        // Fetch posts for this group
        if let groupID = groupID {
            Task {
                await GroupLogic.shared.fetchGroupPosts(groupID: groupID)
                
                // Print post IDs and captions
                DispatchQueue.main.async {
                    let posts = self.postDataController.getPostsForGroup(groupID: groupID)
                    print("________________________")
                    print("IndividualGroupViewController: Posts for groupID \(groupID)")
                    print("Total posts: \(posts.count)")
                    for post in posts {
                        print("Post ID: \(post.postID), Caption: \(post.postCaption ?? "No caption")")
                    }
                    print("________________________")
                }
            }
        }
    }
    
    //LAYOUT
    private func setupNavigationBar() {
        navigationItem.title = "Wishlist"

        let newGroupPostButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newGroupPostButton)
        )
        navigationItem.rightBarButtonItem = newGroupPostButton

        if let image = UIImage(named: "user") {
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
    
    //ACTIONS
    @objc private func newGroupPostButton() {
        print("New Post")
    }
    
    @objc private func openProfile() {
        print("Profile tapped")
    }


}

 */

//WORKING
//LISTS: Wishlist
/*
class IndividualGroupViewController: UIViewController {

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
                print("IndividualGroupViewController \(groupID)")
            }
        } else {
            print("No group data available")
        }
         
        // Observe item updates (not post updates)
        postDataController.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsForGroup()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "IndividualGroupViewController")
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
        tableView.register(IndividualGroupPostCell.self, forCellReuseIdentifier: "IndividualGroupPostCell")
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
            await postDataController.fetchPostItems(groupID: groupID)
            
            // Print out item names to verify it's working
            DispatchQueue.main.async {
                print("________________________")
                print("IndividualGroupViewController: fetchItemsForGroup \(groupID)")
                print("Total items fetched: \(self.postDataController.items.count)")
                for item in self.postDataController.items {
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
        let membersVC = IndividualGroupMembersVC()
        //group.groupName
        let groupName: String = group?.groupName ?? "Group Members"
        membersVC.title = groupName
        membersVC.groupMembers = self.groupMembers
        navigationController?.pushViewController(membersVC, animated: true)
    }
    
    @objc private func newPostButtonTapped() {
        let storyboard = UIStoryboard(name: "Groups", bundle: nil) // change "Main" if you put it in another storyboard
        if let newPostVC = storyboard.instantiateViewController(withIdentifier: "MakePostViewController") as? MakePostViewController {
            // Pass the current group ID to the MakePostViewController
            newPostVC.groupID = group?.groupID ?? 0
            newPostVC.modalPresentationStyle = .fullScreen  // makes it fill screen
            present(newPostVC, animated: true, completion: nil)
        }
    }

    //VIEWS: Navigate to an Individual Post
    
}


extension IndividualGroupViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return postDataController.posts.count
        return postDataController.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postDataController.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualGroupPostCell", for: indexPath) as! IndividualGroupPostCell
        cell.configurePost(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the post at the tapped index (items are posts with postType == "item")
        let post = postDataController.items[indexPath.row]

        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        if let postViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualPostViewControllerID) as? IndividualPostViewController {
            // Pass the post as currentPost (it's an item if postType == "item")
            //postViewController.currentPost = post
            postViewController.postID = post.postID
            navigationController?.pushViewController(postViewController, animated: true)
        }
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
 */



/*
 /***************/
 //GROUPS: Kite //
/****************/
class IndividualGroupViewController: UIViewController {

    var group: GroupModel?
    private let tableView = UITableView()
    
    // Shared Data Controller
    let postDataController = PostDataController.shared
    private let pollingManager = PollingManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()

        let groupID = group?.groupID ?? 0
        let groupName = group?.groupName ?? "No Group Name"
        printPageInfo(vcName: "IndividualGroupViewController")
        

        // Observe post updates
        postDataController.onPostsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        // Start polling
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchItemsForGroup()
        }
        pollingManager.startPolling()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsForGroup()
        tableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pollingManager.stopPolling()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showIndividualPost,
           let postViewController = segue.destination as? IndividualPostViewController,
           let selectedPost = sender as? Post {
            postViewController.currentPost = selectedPost
            //postViewController.commentsArray = selectedPost.commentsArray ?? []
        }
    }

    // MARK: - Fetch posts
    private func fetchItemsForGroup() {
        guard let groupID = group?.groupID else {
            print("No group ID available")
            return
        }

        print("IndividualGroupViewController: Fetching posts for group ID \(groupID)")

        Task {
            await postDataController.fetchPosts(groupID: groupID)
        }
    }

    // MARK: - Table Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableHeaderView = createTableHeader()
        tableView.tableFooterView = UIView()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Custom Header View
    private func createTableHeader() -> UIView {
        let headerHeight: CGFloat = 100
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))

        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(blueView)

        let pinkView = UIView()
        pinkView.backgroundColor = .systemPink
        pinkView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(pinkView)

        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: headerView.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 60),

            pinkView.topAnchor.constraint(equalTo: blueView.bottomAnchor),
            pinkView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            pinkView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            pinkView.heightAnchor.constraint(equalToConstant: 40)
        ])

        return headerView
    }
}

extension IndividualGroupViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataController.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postDataController.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
        cell.configurePost(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = postDataController.posts[indexPath.row]

        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        if let postViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualPostViewControllerID) as? IndividualPostViewController {
            postViewController.currentPost = post
            navigationController?.pushViewController(postViewController, animated: true)
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPost = postDataController.posts[indexPath.row]
        let currentPostImage = currentPost.postImageData

        // Get Image Height
        let defaultImage = UIImage(named: "background_1") ?? UIImage()
        let currentImage = currentPostImage ?? defaultImage
        let postImageHeight = round(getImageHeight(image: currentImage))

        // Get Caption Height
        let postCaption = currentPost.postCaption ?? "no caption"
        let postCaptionHeight = round(calculateLabelHeight(text: postCaption))

        return StyleConstants.postHeader + postImageHeight + StyleConstants.postSocials + postCaptionHeight + StyleConstants.postDivider
    }
}

*/

