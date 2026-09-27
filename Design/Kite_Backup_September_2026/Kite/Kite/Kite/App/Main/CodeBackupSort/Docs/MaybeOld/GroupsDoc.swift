//
//  GroupsDoc.swift
//  Kite
//
//  Created by David Vasquez on 7/2/25.
//

import Foundation




//APPENDIX

/*
@objc private func userImageTapped(_ gesture: UITapGestureRecognizer) {
    guard let imageView = gesture.view as? UIImageView else { return }
    let userID = imageView.tag
    
    // Find the user by ID
    guard let user = groupMembers.first(where: { $0.userID == userID }) else { return }
    
    print("Go to Profile: \(user.userName)")
    
    // TODO: Add navigation to user profile
    // For now, just print the username
}

print("________________________")
print("FETCHING GROUP MEMBER PROFILES")
print("Total members to fetch: \(allMembers.count)")
print("Members: \(allMembers)")
print("________________________")


print("________________________")
print("FETCHED GROUP MEMBER PROFILES")
print("Successfully fetched \(groupMembers.count) profiles:")
for member in groupMembers {
    print("- \(member.userName): \(member.displayName)")
}
print("________________________")
*/
// Store groupMembers for use in UI



// TEMPORARY: Print group users
/*
if let group = group {
    print("________________________")
    print("GROUP USERS DEBUG")
    print("Group ID: \(group.groupID)")
    print("Group Name: \(group.groupName)")
    print("Active Members: \(group.activeGroupMembers)")
    print("Pending Members: \(group.pendingGroupMembers)")
    print("Created By: \(group.createdBy ?? "Unknown")")
    print("________________________")
    
    // Fetch group member profiles
    Task {
        await fetchGroupMemberProfiles()
    }
} else {
    print("No group data available")
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


/*
//GROUPS (Lists): Wishlist
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    // MARK: - NAVIGATION BAR
    private func setupNavigationBar() {
        // Title in the middle
        navigationItem.title = "Wishlist"

        // Right bar button: "+"
        let createGroupButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openCreateGroup)
        )
        navigationItem.rightBarButtonItem = createGroupButton

        // Left bar button: profile (circular)
        if let image = UIImage(named: "user") {
            // Resize + crop circle
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

    // Helper: resize + circular crop
    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()   // circular mask
            image.draw(in: rect)
        }
    }

    // Helper function to resize
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
        // push profile screen here if you want
    }
    
    // MARK: - TABLE VIEW
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Header with segmented control
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground

        let segmentedControl = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        headerView.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.8)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // My Lists → show groups
            fetchGroups()
        } else {
            // Shared With Me → placeholder
            groups = [] // clear existing data
            tableView.reloadData()
            
            // Show a single "Coming Soon" cell
            let placeholderLabel = UILabel()
            placeholderLabel.text = "Coming Soon..."
            placeholderLabel.textAlignment = .center
            placeholderLabel.font = .italicSystemFont(ofSize: 16)
            placeholderLabel.textColor = .secondaryLabel
            tableView.backgroundView = placeholderLabel
        }
    }


    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups.isEmpty && (tableView.backgroundView != nil) {
            return 0
        }
        tableView.backgroundView = nil
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
*/



//WISHLIST: working backup
/*
 
 
 class GroupsViewController: UIViewController {

     let groupsAPI = GroupsAPI()
     let userDefaultManager = UserDefaultManager()

     private var groups: [GroupModel] = []
     private let tableView = UITableView()

     override func viewDidLoad() {
         super.viewDidLoad()
         print("________________________")
         print("GroupsViewController")
         print("LISTS: Wishlist")
         print("________________________")
         print(" ")
         
         setupNavigationBar()   // ✅ add navigation bar setup
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
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         GroupDataController.shared.onGroupsUpdated = nil
     }
     
     // MARK: - NAVIGATION BAR
     private func setupNavigationBar() {
         // Title in the middle
         navigationItem.title = "Wishlist"

         // Right bar button: "+"
         let createGroupButton = UIBarButtonItem(
             barButtonSystemItem: .add,
             target: self,
             action: #selector(openCreateGroup)
         )
         navigationItem.rightBarButtonItem = createGroupButton

         // Left bar button: profile (circular)
         if let image = UIImage(named: "user") {
             // Resize + crop circle
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

     // Helper: resize + circular crop
     private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
         let renderer = UIGraphicsImageRenderer(size: size)
         return renderer.image { _ in
             let rect = CGRect(origin: .zero, size: size)
             UIBezierPath(ovalIn: rect).addClip()   // circular mask
             image.draw(in: rect)
         }
     }

     // Helper function to resize
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
         // push profile screen here if you want
     }
     
     // MARK: - TABLE VIEW
     private func setupTableView() {
         view.addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
         tableView.rowHeight = 220
         tableView.tableFooterView = UIView()

         // ✅ Keep your custom table header
         let headerView = UIView()
         headerView.backgroundColor = .lightGray

         let headerLabel = UILabel()
         headerLabel.text = "Table Header Placeholder"
         headerLabel.font = .boldSystemFont(ofSize: 18)
         headerLabel.translatesAutoresizingMaskIntoConstraints = false

         headerView.addSubview(headerLabel)
         NSLayoutConstraint.activate([
             headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
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

 
 */


/*
//WORKING
//GROUPS: Kite
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("________________________")
        print("GroupsViewController")
        print("________________________")
        
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
        print("________________________")
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
*/




//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

//August 29
/*
import UIKit


//GROUPS (Lists): Wishlist
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    // MARK: - NAVIGATION BAR
    private func setupNavigationBar() {
        // Title in the middle
        navigationItem.title = "Wishlist"

        // Right bar button: "+"
        let createGroupButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openCreateGroup)
        )
        navigationItem.rightBarButtonItem = createGroupButton

        // Left bar button: profile (circular)
        if let image = UIImage(named: "user") {
            // Resize + crop circle
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

    // Helper: resize + circular crop
    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()   // circular mask
            image.draw(in: rect)
        }
    }

    // Helper function to resize
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
        // push profile screen here if you want
    }
    
    // MARK: - TABLE VIEW
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Header with segmented control
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground

        let segmentedControl = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        headerView.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.8)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // My Lists → show groups
            fetchGroups()
        } else {
            // Shared With Me → placeholder
            groups = [] // clear existing data
            tableView.reloadData()
            
            // Show a single "Coming Soon" cell
            let placeholderLabel = UILabel()
            placeholderLabel.text = "Coming Soon..."
            placeholderLabel.textAlignment = .center
            placeholderLabel.font = .italicSystemFont(ofSize: 16)
            placeholderLabel.textColor = .secondaryLabel
            tableView.backgroundView = placeholderLabel
        }
    }

     
    
    //WORKING
    /*
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        //  Keep your custom table header
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let headerLabel = UILabel()
        headerLabel.text = "Table Header Placeholder"
        headerLabel.font = .boldSystemFont(ofSize: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
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
    */
    
    
    
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    //WORKING
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupDataController.shared.groups.count
    }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups.isEmpty && (tableView.backgroundView != nil) {
            return 0
        }
        tableView.backgroundView = nil
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

*/


//WISHLIST: working backup
/*
 
 
 class GroupsViewController: UIViewController {

     let groupsAPI = GroupsAPI()
     let userDefaultManager = UserDefaultManager()

     private var groups: [GroupModel] = []
     private let tableView = UITableView()

     override func viewDidLoad() {
         super.viewDidLoad()
         print("________________________")
         print("GroupsViewController")
         print("LISTS: Wishlist")
         print("________________________")
         print(" ")
         
         setupNavigationBar()   // ✅ add navigation bar setup
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
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         GroupDataController.shared.onGroupsUpdated = nil
     }
     
     // MARK: - NAVIGATION BAR
     private func setupNavigationBar() {
         // Title in the middle
         navigationItem.title = "Wishlist"

         // Right bar button: "+"
         let createGroupButton = UIBarButtonItem(
             barButtonSystemItem: .add,
             target: self,
             action: #selector(openCreateGroup)
         )
         navigationItem.rightBarButtonItem = createGroupButton

         // Left bar button: profile (circular)
         if let image = UIImage(named: "user") {
             // Resize + crop circle
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

     // Helper: resize + circular crop
     private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
         let renderer = UIGraphicsImageRenderer(size: size)
         return renderer.image { _ in
             let rect = CGRect(origin: .zero, size: size)
             UIBezierPath(ovalIn: rect).addClip()   // circular mask
             image.draw(in: rect)
         }
     }

     // Helper function to resize
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
         // push profile screen here if you want
     }
     
     // MARK: - TABLE VIEW
     private func setupTableView() {
         view.addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
         tableView.rowHeight = 220
         tableView.tableFooterView = UIView()

         // ✅ Keep your custom table header
         let headerView = UIView()
         headerView.backgroundColor = .lightGray

         let headerLabel = UILabel()
         headerLabel.text = "Table Header Placeholder"
         headerLabel.font = .boldSystemFont(ofSize: 18)
         headerLabel.translatesAutoresizingMaskIntoConstraints = false

         headerView.addSubview(headerLabel)
         NSLayoutConstraint.activate([
             headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
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

 
 */


/*
//WORKING
//GROUPS: Kite
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("________________________")
        print("GroupsViewController")
        print("________________________")
        
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
        print("________________________")
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
*/



/*
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let post = postDataController.posts[indexPath.row]
    performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
}
*/

//WORKING
/*
class IndividualGroupViewController: UIViewController {
    var group: GroupModel?
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()

        let groupID = group?.groupID ?? 0
        let groupName = group?.groupName ?? "No Group Name"
        print("IndividualGroupViewController \(groupName)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPostsForGroup()
    }
    
    //LAYOUT
    //Table View Header
    private func createTableHeader() -> UIView {
        let headerHeight: CGFloat = 100 // 60 + 40
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
    
    // Setup Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(IndividualPostTableViewCell.self, forCellReuseIdentifier: "IndividualPostTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()

        // Setup tableHeaderView
        tableView.tableHeaderView = createTableHeader()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    //ACTIONS
    //Function A1: Get Posts
    private func fetchPostsForGroup() {
        guard let groupID = group?.groupID else {
            print("No group ID available")
            return
        }
        
        print("Fetching posts for group ID: \(groupID)")
        
        Task {
            await PostDataController.shared.fetchPosts(groupID: groupID)
            
            DispatchQueue.main.async {
                self.printPostCaptions()
            }
        }
    }

    //Function A2: Print Posts
    private func printPostCaptions() {
        let posts = PostDataController.shared.posts
        print("=== POST CAPTIONS FOR GROUP: \(group?.groupName ?? "Unknown") ===")
        
        if posts.isEmpty {
            print("No posts found for this group")
        } else {
            for (index, post) in posts.enumerated() {
                let caption = post.postCaption ?? "No caption"
                print("Post \(index + 1): \(caption)")
            }
        }
        print("=== END POST CAPTIONS ===")
        
        tableView.reloadData()
    }
}


extension IndividualGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostDataController.shared.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = PostDataController.shared.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostTableViewCell", for: indexPath) as! IndividualPostTableViewCell
        cell.configure(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = PostDataController.shared.posts[indexPath.row]
        print("Selected post ID: \(post.postID)")
    }
}

*/


/*
class GroupsViewController: UIViewController {
    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

 
    override func viewDidLoad() {
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
   
        super.viewDidLoad()
       
        getGroup(currentUser: currentUser)

         

      

    
            
    }

    func getGroup(currentUser: String) {
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
    }
}

*/

/*
getGroup(currentUser: currentUser)

 
 


 func createGroup(){
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
 }
 */

//WORKS
/*
class GroupsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let topView = SimpleTopView()
        let bottomStackView = SimpleBottomStackView()
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 220),
            
            bottomStackView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
*/


//WORKS
/*
class GroupsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }

    private func setupStackView() {
        let stackView = UserProfileFollowers()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
    }
    
}
*/




//TASK: Get a Group
/*
let groupsAPI = GroupsAPI()
let userDefaultManager = UserDefaultManager()

override func viewDidLoad() {
    super.viewDidLoad()
    let currentUser = userDefaultManager.getLoggedInUser()
    let deviceId = getDeviceId()
 
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
    

}



 */



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
