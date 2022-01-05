//
//  ViewController.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/14/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    @IBOutlet weak var postToLabel: UILabel!
    @IBOutlet weak var postFromLabel: UILabel!
    
    @IBOutlet weak var postInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func getPostButton(_ sender: Any) {
        let postID = postInputField.text!
        print(postID)
        
        getPost(postID: 72){ postModelArray, error in
            DispatchQueue.main.async {
                let postsArray = filterPostModelIntoPost(postModelArray: postModelArray)
                for post in postsArray {
                    print("\(post.postID) \(post.postFrom) \(post.postTo) \(post.postCaption) \(post.postType)")
                }
                let post = postsArray[0]
                let currentPost = Post(postID: post.postID, postCaption: post.postCaption)
                currentPost.postType = post.postType
                currentPost.postFrom = post.postFrom
                currentPost.postTo = post.postTo
                
                self.postCaptionLabel.text = currentPost.postCaption
                self.postFromLabel.text = currentPost.postFrom
                self.postToLabel.text = currentPost.postTo
                
                //let postOne = Post(postID: 1, postCaption: "So Cool here!", postImage: #imageLiteral(resourceName: "forever"), postLikeStatus: 0, postShareStatus: 0)
                //Reload Table: self.tableView.reloadData()
            }
        }
    }
}

/*
 0
 postID    4
 postType    "photo"
 groupID    70
 listID    0
 postFrom    "davey"
 postTo    "70"
 postCaption    "Hiya Sam!! "
 fileName    ""
 fileNameServer    ""
 fileUrl    ""
 videoURL    ""
 videoCode    ""
 created    "2021-11-17T01:17:29.000Z"
 1
 postID    5
 postType    "photo"
 groupID    70
 listID    0
 postFrom    "davey"
 postTo    "70"
 postCaption    "Hiya Sam!! "
 fileName    ""
 fileNameServer    ""
 fileUrl    ""
 videoURL    ""
 videoCode    ""
 created    "2021-11-17T01:18:50.000Z"
 */
