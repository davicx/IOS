//
//  HomeViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//


import UIKit


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
        Task {
            do {
                let postsResponseModel = try await postsAPI.getPostsAPI(groupID: 72)

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
