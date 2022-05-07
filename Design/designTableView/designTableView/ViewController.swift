//
//  ViewController.swift
//  designTableView
//
//  Created by Vasquez, Charles Geoffrey David [C] on 1/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 200;
        posts = createArray()
    
    }
    
    func createArray() -> [Post] {
        let video1 = Post(image: #imageLiteral(resourceName: "alley"), title: "Forever we are Lost")
        let video2 = Post(image: #imageLiteral(resourceName: "crossing"), title: "Catch the Sky")
        let video3 = Post(image: #imageLiteral(resourceName: "city"), title: "Southern Charm")
        let video4 = Post(image: #imageLiteral(resourceName: "crossing"), title: "Northern Lights")
        let video5 = Post(image: #imageLiteral(resourceName: "city"), title: "From below the twilight")
        let video6 = Post(image: #imageLiteral(resourceName: "city"), title: "From a Well Beside the Ocean")
        
        return [video1, video2, video3, video4, video5, video6]
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
    
        cell.setPost(post: currentPost)
        
        return cell
    }
}

/*

import UIKit

class VideoListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90;
        videos = createArray()
        
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    
    func createArray() -> [Video] {
        let video1 = Video(image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost")
        let video2 = Video(image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky")
        let video3 = Video(image: #imageLiteral(resourceName: "night"), title: "Southern Charm")
        let video4 = Video(image: #imageLiteral(resourceName: "river"), title: "Northern Lights")
        let video5 = Video(image: #imageLiteral(resourceName: "night"), title: "From below the twilight")
        let video6 = Video(image: #imageLiteral(resourceName: "river"), title: "From a Well Beside the Ocean")
        
        return [video1, video2, video3, video4, video5, video6]
    }
    
}


*/
