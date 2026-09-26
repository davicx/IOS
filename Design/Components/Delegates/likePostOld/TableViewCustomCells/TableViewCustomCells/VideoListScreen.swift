//
//  VideoListScreen.swift
//  TableViewCustomCells
//
//  Created by David Vasquez on 5/20/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import UIKit

class VideoListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 320;
        posts = createArray()
        
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    
    func createArray() -> [Post] {
        let post1 = Post(image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost", likeCount: 7)
        let post2 = Post(image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky", likeCount: 2)
        let post3 = Post(image: #imageLiteral(resourceName: "night"), title: "Southern Charm", likeCount: 12)
        let post4 = Post(image: #imageLiteral(resourceName: "river"), title: "Northern Lights", likeCount: 8)

        return [post1, post2, post3, post4]
    }
    
}

extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        //We could configure the cell here but instead we are going to do it in the VideoCell itself
        //cell.setVideo(video: video)
        cell.setPost(post: currentPost)
        
        return cell
    }
}
