//
//  TimelineViewController.swift
//  twitterDesign
//
//  Created by Vasquez, Charles Geoffrey David [C] on 2/2/22.
//

import UIKit

class TimelineViewController: UIViewController {
    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 320;
        posts = createArray()
    }
    
    
    func createArray() -> [Post] {
        let post1 = Post(userImage: #imageLiteral(resourceName: "ocean"), userName: "davey", firstName: "davey", postTime: "1 hour ago", postMessage: "Forever we are Lost")
        let post2 = Post(userImage: #imageLiteral(resourceName: "tower"), userName: "davey", firstName: "davey", postTime: "15 minutes ago", postMessage: "Catch the Sky")
        let post3 = Post(userImage: #imageLiteral(resourceName: "train"), userName: "frodo", firstName: "frodo", postTime: "1 hour ago",postMessage: "Southern Charm")
        let post4 = Post(userImage: #imageLiteral(resourceName: "snow"), userName: "davey", firstName: "davey", postTime: "1 hour ago",postMessage: "Northern Lights")
        let post5 = Post(userImage: #imageLiteral(resourceName: "alley"), userName: "sam", firstName: "sam", postTime: "yesterday",postMessage: "From below the twilight")
        let post6 = Post(userImage: #imageLiteral(resourceName: "trail"), userName: "davey", firstName: "davey", postTime: "1 hour ago",postMessage: "From a Well Beside the Ocean")
        
        return [post1, post2, post3, post4, post5, post6]
    }

}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
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


