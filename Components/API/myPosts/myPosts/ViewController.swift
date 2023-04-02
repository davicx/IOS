//
//  ViewController.swift
//  myPosts
//
//  Created by David Vasquez on 11/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, postProtocol {

    @IBOutlet weak var postTableVie: UITableView!
    
    var postsArray: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        postsArray = getPostsArray()
        self.postTableVie.rowHeight = 340
    }
    
    
    func getPostsArray() -> [Post] {
        let postOne = Post(postID: 1, postCaption: "So Cool here!", postImage: #imageLiteral(resourceName: "forever"), postLikeStatus: 0, postShareStatus: 0)
        let postTwo = Post(postID: 2, postCaption: "Clouds the moon", postImage: #imageLiteral(resourceName: "clouds"), postLikeStatus: 0, postShareStatus: 0)
        let postThree = Post(postID: 3, postCaption: "Forever here", postImage: #imageLiteral(resourceName: "night"), postLikeStatus: 1, postShareStatus: 1)
        let postFour = Post(postID: 4, postCaption: "In the Green", postImage: #imageLiteral(resourceName: "whale"), postLikeStatus: 1, postShareStatus: 1)
        
        return [postOne, postTwo, postThree, postFour]
        
    }
    
    //Like a Post
    func likePost(index: Int, postObject: Post) {
        //print("Current Post ID: \(index)")
        print("Current Post ID: \(postObject.postID) Caption \(postObject.postCaption) ")
    }
    
    //Share a Post
    func sharePost(index: Int, postObject: Post) {
        //print("Current Post ID: \(index)")
        print("Share Post ID: \(postObject.postID) Caption \(postObject.postCaption) ")
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Get Total Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    //Configure Each Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

        //Configure Cell (in PostCell)
        cell.setupPost(post: currentPost)
        
        //Configure the Delegate and Protocol
        cell.index = indexPath
        cell.cellDelegate = self
        cell.postSelected = currentPost
        
        return cell
    }
    
}


/*

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    //CELL: This is where each cell is configured
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //CELL SET UP
        //Get the Friend we are going to Load into the Cell
        let friend = friendsArray[indexPath.row]
        
        //Create a cell variable so we can configure it
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        
        //Methods in Friend Cell Called when we set the Cell Up

        cell?.cellDelegate = self
        cell?.index = indexPath
        cell?.currentFriend = friend
        
        return cell!
        
    }
    
}

*/
