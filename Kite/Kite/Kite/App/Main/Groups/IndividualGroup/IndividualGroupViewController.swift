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
    //Function 1A: Get Posts
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

