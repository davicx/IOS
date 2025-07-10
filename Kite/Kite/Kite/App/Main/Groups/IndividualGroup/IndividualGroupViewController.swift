//
//  IndividualGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

import UIKit


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
        print("IndividualGroupViewController \(groupName)")

        // Observe post updates
        postDataController.onPostsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        // Start polling
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchPostsForGroup()
        }
        pollingManager.startPolling()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPostsForGroup()
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
            postViewController.commentsArray = selectedPost.commentsArray ?? []
        }
    }

    // MARK: - Fetch posts
    private func fetchPostsForGroup() {
        guard let groupID = group?.groupID else {
            print("No group ID available")
            return
        }

        print("Fetching posts for group ID: \(groupID)")

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
        cell.updatePost(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = postDataController.posts[indexPath.row]

        if canPerformSegue(withIdentifier: Constants.Segue.showIndividualPost) {
            performSegue(withIdentifier: Constants.Segue.showIndividualPost, sender: post)
        } else {
            print("Segue 'showIndividualPost' is not connected in storyboard for this view controller.")
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
