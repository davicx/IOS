//
//  ViewController.swift
//  KiteV1
//
//  Created by Syngenta on 8/26/21.
//

import UIKit


class ViewController: UIViewController {

    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90;
 
        getPosts { postsArray, error in
            DispatchQueue.main.async {
                self.posts = createPostsArray(postsArray: postsArray)
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
