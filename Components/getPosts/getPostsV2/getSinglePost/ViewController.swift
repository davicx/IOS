//
//  ViewController.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/16/21.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 420;

        getGroupPosts(groupID: 72){ postModelArray, error in
            DispatchQueue.main.async {
                self.posts = createPostsArray(postModelArray: postModelArray)
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
         
        cell.setPost(post: currentPost)
        
        return cell
    }
}

