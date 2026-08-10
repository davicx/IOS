//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


class HomeViewController: UIViewController {

    //HOME: API and data
    let postDataController = PostDataController.shared
    
    let loginAPI = LoginAPI()
    let postsAPI = PostsAPI()
    
    let userDefaultManager = UserDefaultManager()
    
    lazy var currentUser: String = {
        return userDefaultManager.getLoggedInUser()
    }()
    
    
    @IBOutlet weak var postsTableView: UITableView!

    // Polling Manager
    private let pollingManager = PollingManager()


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

    
    //TABLE VIEW: Setup
    func setupTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.postCell)
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.separatorStyle = .none
        //postsTableView.register(HomePostCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifier.homePostCell)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    //FUNCTIONS
    func fetchPosts() {
        Task {
            //Kite
            await postDataController.fetchKitePosts(groupID: 70)

            //Wishlist
            //await postDataController.fetchWishlistItems(groupID: 72)
        }
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
        //return 200 // Estimated height like IndividualPostViewController (HomePostCell)
    }
     
}

