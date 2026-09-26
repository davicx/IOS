//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

class HomeViewController: UIViewController {

    //LOGIC: API and data
    let postDataController = PostDataController.shared
    
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    
    let userDefaultManager = UserDefaultManager()
    
    lazy var currentUser: String = {
        return userDefaultManager.getLoggedInUser()
    }()
    
    // Polling Manager
    private let pollingManager = PollingManager()


    //UI COMPONENTS
    @IBOutlet weak var postsTableView: UITableView!
    let topNavigationView = UIView()
    let topNavigationProfileImageView = UIImageView()
    let topNavigationProfileButton = UIButton(type: .custom)
    let topNavigationLogoImageView = UIImageView()

    //MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup PollingManager callback
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchPosts()
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostsFetched),
            name: .postsFetched,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostsFetched),
            name: .itemsFetched,
            object: nil
        )

        //LISTENER: Post Updated
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePostUpdated),
            name: .postUpdated,
            object: nil
        )
         
        // Initial data fetch
        fetchPosts()

        // Start polling
        pollingManager.startPolling()

        setupTopNavigationView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh table view to ensure cells show latest data from PostDataController
        // This is important when returning from other screens where likes may have changed
        postsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printPageInfo(vcName: "HomeViewController")

        pollingManager.startPolling() // Restart polling if view reappears
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingManager.stopPolling() // Stop polling when view goes away
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //LAYOUT and UI
    //Top Navigation View: Setup
    func setupTopNavigationView() {
        topNavigationView.translatesAutoresizingMaskIntoConstraints = false
        topNavigationView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32).isActive = true
        topNavigationView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        topNavigationProfileImageView.image = UIImage(named: "user")
        topNavigationProfileImageView.contentMode = .scaleAspectFill
        topNavigationProfileImageView.clipsToBounds = true
        topNavigationProfileImageView.layer.cornerRadius = 16
        topNavigationProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        topNavigationView.addSubview(topNavigationProfileImageView)

        topNavigationProfileButton.translatesAutoresizingMaskIntoConstraints = false
        topNavigationProfileButton.accessibilityLabel = "Profile"
        topNavigationProfileButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        topNavigationView.addSubview(topNavigationProfileButton)

        topNavigationLogoImageView.image = UIImage(named: "blue_logo")
        //topNavigationLogoImageView.image = UIImage(named: "pink_logo")
        topNavigationLogoImageView.contentMode = .scaleAspectFit
        topNavigationLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        topNavigationView.addSubview(topNavigationLogoImageView)

        NSLayoutConstraint.activate([
            topNavigationProfileImageView.leadingAnchor.constraint(equalTo: topNavigationView.leadingAnchor),
            topNavigationProfileImageView.centerYAnchor.constraint(equalTo: topNavigationView.centerYAnchor),
            topNavigationProfileImageView.widthAnchor.constraint(equalToConstant: 32),
            topNavigationProfileImageView.heightAnchor.constraint(equalToConstant: 32),

            topNavigationProfileButton.leadingAnchor.constraint(equalTo: topNavigationView.leadingAnchor),
            topNavigationProfileButton.centerYAnchor.constraint(equalTo: topNavigationView.centerYAnchor),
            topNavigationProfileButton.widthAnchor.constraint(equalToConstant: 40),
            topNavigationProfileButton.heightAnchor.constraint(equalToConstant: 44),

            topNavigationLogoImageView.centerXAnchor.constraint(equalTo: topNavigationView.centerXAnchor),
            topNavigationLogoImageView.centerYAnchor.constraint(equalTo: topNavigationView.centerYAnchor),
            topNavigationLogoImageView.widthAnchor.constraint(equalToConstant: 38),
            topNavigationLogoImageView.heightAnchor.constraint(equalToConstant: 38)
        ])

        navigationItem.titleView = topNavigationView

        Task {
            if let user = await UsersDataController.shared.getOrFetchUserWithImage(username: currentUser),
               let profileImage = user.profileImage {
                await MainActor.run {
                    self.topNavigationProfileImageView.image = profileImage
                }
            }
        }
    }

    //Table View: Setup
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.postCell)
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.separatorStyle = .none
        postsTableView.backgroundColor = Colors.feedBackground
        //postsTableView.register(HomePostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.homePostCell)
    }


    //FUNCTIONS
    func fetchPosts() {
        Task {
            await getHomePostsWishlist()
        }
    }

    /// Kite Home posts — wire later to GET /posts
    func getHomePosts() {
        // await postDataController.fetchAllKitePosts() when GET /posts is cleaned up
    }

    /// Wishlist Home items — GET /items (global, limit 12)
    func getHomePostsWishlist() async {
        await postDataController.fetchAllWishlistItems()
    }


    //ACTIONS
    @objc private func profileImageTapped() {
        print("Logo Tapped")
        guard let tabBarController,
              let profileTabIndex = tabBarController.viewControllers?.firstIndex(where: { viewController in
                  let navigationController = viewController as? UINavigationController
                  return navigationController?.viewControllers.first is ProfileViewController
              }) else { return }

        let profileNavigationController = tabBarController.viewControllers?[profileTabIndex] as? UINavigationController
        profileNavigationController?.popToRootViewController(animated: false)
        tabBarController.selectedIndex = profileTabIndex
    }

    @objc private func handlePostsFetched() {
        postsTableView.reloadData()
    }

    @objc private func handlePostUpdated(_ notification: Notification) {
        // Simple pattern: just reload the table (matches DataController example)
        postsTableView.reloadData()
    }
}

//TABLE VIEW: For Individual Posts in Home Feed
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postDataController.getHomeFeedPosts().count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.postCell, for: indexPath) as! PostCell
         let post = postDataController.getHomeFeedPosts()[indexPath.row]
         cell.updatePost(with: post)
         return cell
         /*
         let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.homePostCell, for: indexPath) as! HomePostCell
         let post = postDataController.getHomeFeedPosts()[indexPath.row]
         cell.updatePost(with: post)
         return cell
         */
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = postDataController.getHomeFeedPosts()[indexPath.row]
         
         let storyboard = UIStoryboard(name: "Post", bundle: nil)
         if let postViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualPostViewControllerID) as? IndividualPostViewController {
             //postViewController.currentPost = post
             postViewController.postID = post.postID
             navigationController?.pushViewController(postViewController, animated: true)
         }
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // PostCell sizes via Auto Layout (same as IndividualPostViewController)
        return UITableView.automaticDimension
        /*
        // HomePostCell: hand-rolled height
        let currentPost = postDataController.getHomeFeedPosts()[indexPath.row]
        
        //STEP 1: Get Image Height
        let postImageHeight = sizeFunctions.calculatePostImageHeight(from: currentPost.postImageData)

        //STEP 2: Get Caption Height (now includes 40pt fixed user info + dynamic text height)
        let postCaptionTextHeight = sizeFunctions.calculatePostCaptionHeight(from: currentPost.postCaption)
        //let postCaptionUserInfoHeight: CGFloat = 40 // Fixed height for user info section
        //let totalCaptionHeight = postCaptionUserInfoHeight + postCaptionTextHeight
        
        //STEP 3: Calculate total height (matching actual cell layout)
        // Fixed heights: header (52) + image (dynamic) + caption user info (28) + caption text (dynamic) + socials (32) + divider (2)
        let fixedHeights: CGFloat = 52 + 22 + 32 + 2
        
        // Total height = fixed heights + dynamic image height + dynamic caption text height
        let totalHeight = fixedHeights + postImageHeight + postCaptionTextHeight
        
        return totalHeight
        */
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
     
}
