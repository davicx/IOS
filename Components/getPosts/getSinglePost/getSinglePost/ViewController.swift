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
        posts = createArray()
    }

    func createArray() -> [Post] {
        let post1 = Post(postID: 1, postCaption: "hiya")
        let post2 = Post(postID: 2, postCaption: "hiya again!")
        let post3 = Post(postID: 3, postCaption: "hiya three")

        post1.postImage = UIImage(named: "clouds")
        post2.postImage = UIImage(named: "hello")
        post3.postImage = UIImage(named: "plane")
        return [post1, post2, post3]
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

