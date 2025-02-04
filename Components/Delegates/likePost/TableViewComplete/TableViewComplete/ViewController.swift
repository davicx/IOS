//
//  ViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/29/24.
//  Copyright © 2024 David Vasquez. All rights reserved.
//

import UIKit


protocol IncrementDelegate {
    func likePost(postID: Int, arrayPosition: Int)
}

class ViewController: UIViewController, IncrementDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    func likePost(postID: Int, arrayPosition: Int) {
        let currentLikeCount = posts[arrayPosition].likeCount
        posts[arrayPosition].likeCount = currentLikeCount + 1
        
        for post in posts {
            //print("postID \(post.postID) post likes \(post.likeCount)")
        }
        tableView.reloadData()
        //masterCount = updatedCount
        //countLabel.text = String(masterCount)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = createArray()
    }
    

    func createArray() -> [Post] {
        let post1 = Post(postID: 1, image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost", likeCount: 7)
        let post2 = Post(postID: 2, image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky", likeCount: 2)
        let post3 = Post(postID: 3, image: #imageLiteral(resourceName: "night"), title: "Southern Charm", likeCount: 12)
        let post4 = Post(postID: 4, image: #imageLiteral(resourceName: "river"), title: "Northern Lights", likeCount: 8)

        return [post1, post2, post3, post4]
    }
    
    //DATA SEND: Send Data to New Cell
    var postToPass:Post!
    var postArrayPositionToPass:Int!
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        
        //We could configure the cell here but instead we are going to do it in the VideoCell itself
        cell.setPost(post: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    

    //DATA SEND: Send Data to New Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        postArrayPositionToPass = indexPath.row
        postToPass = post

        self.performSegue(withIdentifier: "showIndividualVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIndividualVideo" {
            let secondController = segue.destination as! IndividualPostViewController
            secondController.selectedPost = postToPass
            secondController.postArrayPosition = postArrayPositionToPass
            secondController.myLikePostDelegate = self
        }
    }
}

/*

protocol IncrementDelegate {
    func incrementCount(updatedCount: Int)
}

class ViewController: UIViewController, IncrementDelegate {
    var masterCount = 20

    @IBOutlet weak var countLabel: UILabel!
    
    func incrementCount(updatedCount: Int) {
        masterCount = updatedCount
        countLabel.text = String(masterCount)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(masterCount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let controller = segue.destination as! SecondViewController
            controller.currentCount = masterCount
            controller.myCountDelegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countLabel.text = String(masterCount)
    }
    
    
}
*/
