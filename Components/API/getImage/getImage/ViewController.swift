//
//  ViewController.swift
//  getImage
//
//  Created by David Vasquez on 8/17/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//


import UIKit

class Post {
    let postID: Int
    var postFrom = ""
    var postCaption = ""
    var imageURL = ""
    var postImage: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }

}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //let urlKey = "https://live.staticflickr.com/7506/26400112934_c548d6484a_b.jpg"
    let urlKey = "https://kite-post-photo-upload.s3.us-west-2.amazonaws.com/1637111930787hiya.jpg"

    @IBAction func getImage(_ sender: Any) {
        
        var currentPost = Post(postID: 1)
        currentPost.imageURL = urlKey
        
        //Load Image
        if let url = URL(string: currentPost.imageURL) {
            do {
                currentPost.postCaption = "hi"
                let data = try Data(contentsOf: url)
                currentPost.postImage = UIImage(data: data)
                //self.imageView.image = UIImage(data: data)
                self.imageView.image = currentPost.postImage
                print(currentPost.postCaption)
            } catch let err {
                print("error ", err)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

