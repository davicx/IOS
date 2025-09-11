//
//  IndividualGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//

import UIKit


//LISTS: Wishlist

/*
class IndividualGroupViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    // MARK: - Table Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "IndividualPostCell")
        
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
        let headerHeight: CGFloat = 160
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))

        // List Name section
        let listNameView = UIView()
        listNameView.backgroundColor = .systemBlue
        listNameView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(listNameView)

        // List Members section
        let listMembersView = UIView()
        listMembersView.backgroundColor = .systemPink
        listMembersView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(listMembersView)

        NSLayoutConstraint.activate([
            listNameView.topAnchor.constraint(equalTo: headerView.topAnchor),
            listNameView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            listNameView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            listNameView.heightAnchor.constraint(equalToConstant: 80),

            listMembersView.topAnchor.constraint(equalTo: listNameView.bottomAnchor),
            listMembersView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            listMembersView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            listMembersView.heightAnchor.constraint(equalToConstant: 80)
        ])

        return headerView
    }
}

extension IndividualGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // example count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualPostCell", for: indexPath) as! IndividualPostCell
        return cell
    }
}
*/


class IndividualGroupViewController: UIViewController {

    var group: GroupModel?
    private let tableView = UITableView()
    
    let postDataController = PostDataController.shared
    private let pollingManager = PollingManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()

        let groupID = group?.groupID ?? 0
        let groupName = group?.groupName ?? "No Group Name"
        print("________________________")
        print("IndividualGroupViewController")
        print("LISTS: Wishlist")
        print("________________________")
        print(" ")
        

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
            //postViewController.commentsArray = selectedPost.commentsArray ?? []
        }
    }

    // MARK: - Fetch posts
    private func fetchPostsForGroup() {
        guard let groupID = group?.groupID else {
            print("No group ID available")
            return
        }

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

        //return StyleConstants.postHeader + postImageHeight + StyleConstants.postSocials + postCaptionHeight + StyleConstants.postDivider
        return 122
    }
}



/*
 /*******************/
 //GROUPS: Kite   //
/*******************/
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
        print("________________________")
        print("IndividualGroupViewController")
        print("________________________")
        

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
            //postViewController.commentsArray = selectedPost.commentsArray ?? []
        }
    }

    // MARK: - Fetch posts
    private func fetchPostsForGroup() {
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

*/
