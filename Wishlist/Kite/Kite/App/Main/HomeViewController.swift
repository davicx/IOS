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

        //topNavigationLogoImageView.image = UIImage(named: "pink_logo")

        NSLayoutConstraint.activate([
            topNavigationProfileImageView.leadingAnchor.constraint(equalTo: topNavigationView.leadingAnchor),
            topNavigationProfileImageView.centerYAnchor.constraint(equalTo: topNavigationView.centerYAnchor),
            topNavigationProfileImageView.widthAnchor.constraint(equalToConstant: 32),
            topNavigationProfileImageView.heightAnchor.constraint(equalToConstant: 32),

            topNavigationProfileButton.leadingAnchor.constraint(equalTo: topNavigationView.leadingAnchor),
            topNavigationProfileButton.centerYAnchor.constraint(equalTo: topNavigationView.centerYAnchor),
            topNavigationProfileButton.widthAnchor.constraint(equalToConstant: 40),
            topNavigationProfileButton.heightAnchor.constraint(equalToConstant: 44)
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
        postsTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.separatorStyle = .none
        postsTableView.backgroundColor = Colors.feedBackground
    }


    //FUNCTIONS
    func fetchPosts() {
        Task {
            await getHomePostsWishlist()
        }
    }

    // Wishlist Home items — GET /items (global, limit 12)
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
         let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
         return cell
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
     
}
