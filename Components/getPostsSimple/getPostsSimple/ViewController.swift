//
//  ViewController.swift
//  getPostsSimple
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getPostsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    @IBAction func getPostsButton(_ sender: UIButton) {
        getPosts(groupID: 77)
    }
    
    @IBAction func getPostsPOSTButton(_ sender: Any) {
        //getPostsPOST()
        print("to do")
    }
    
    @IBAction func getPostsAsyncButton(_ sender: Any) {
        getPostsASYNC(groupID: 77){ postModelArray, error in
            DispatchQueue.main.async {
                let postsArray = filterPostModelIntoPost(postModelArray: postModelArray)
                for post in postsArray {
                    print("\(post.postID) \(post.postFrom) \(post.postTo) \(post.postCaption) \(post.postType)")
                }
                //Reload Table: self.tableView.reloadData()
            }
        }
        
    }
}

