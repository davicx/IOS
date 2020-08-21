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
    
    let urlKey = "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/images/background_2.png"
    
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

