//
//  ViewController.swift
//  getImage
//
//  Created by David on 6/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    
    //Create Classes
    var currentPost = Post(postID: 1)
    let networker = Networker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create New Class
        let currentPost = Post(postID: 1)
        print(currentPost.postCaption)
        
        //Set from Assets
        postImage.image = UIImage(named: "city")

    }
    
    
    
    //BUTTONS
    @IBAction func getImageButton(_ sender: UIButton) {
        getImage()
    }
    
    @IBAction func getImageNetworker(_ sender: UIButton) {
        networker.getImage(from: currentPost.fileUrl) { (data, error)  in
          if let error = error {
            print(error)
            return
          }

            //Set Directly
            self.postImage.image = UIImage(data: data!)

            //Set from Classs
            //self.currentPost.postImage = UIImage(data: data!)
            //self.postImage.image = self.currentPost.postImage
        }
    }
    
    
    //Function: Get Simple Image
    func getImage() {
        if let url = URL(string: currentPost.fileUrl) {
            do {
       
                let data = try Data(contentsOf: url)
                currentPost.postImage = UIImage(data: data)
                self.postImage.image = currentPost.postImage
            } catch let err {
                print("error ", err)
                
            }
        }
    }
    
 
    
}


/*
 @IBOutlet weak var label: UILabel!
 @IBOutlet weak var imageView: UIImageView!


 let groupAPI = GroupAPI()
 
 networker.getImage { (data, error)  in
   if let error = error {
     print(error)
     return
   }
   
   self.imageView.image = UIImage(data: data!)
 }
 */



