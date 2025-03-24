//
//  PostViewController.swift
//  Kite
//
//  Created by David Vasquez on 2/27/25.
//

import UIKit


class SinglePostViewController: UIViewController {
    
    var currentPost: Post!  // This should receive data from HomeViewController

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = currentPost {
            postImage.image = post.postImageData ?? UIImage(named: "background_10")
            postCaptionLabel.text = post.postCaption
        } else {
            print("Error: currentPost is nil")
        }
    }
    
}

/*
class PostViewController: UIViewController {
    
    //var selectedPost = TempPost(image: UIImage(named: "background_10"), caption: "Need to load")
    var currentPost:TempPost!

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postImage : UIImage = currentPost.image ?? UIImage(named: "background_10")!
        let postCaptionLabel : String = currentPost.caption

        
    }

}
 */

/*

import UIKit

class IndividualPostViewController: UIViewController {
    
    var selectedVideoTitle: String = ""
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedVideoTitle)
        postTextLabel.text = selectedVideoTitle
    }

}
*/
