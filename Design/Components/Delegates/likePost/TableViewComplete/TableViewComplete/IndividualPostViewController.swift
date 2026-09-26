//
//  IndividualPostViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit


class IndividualPostViewController: UIViewController {
    var myLikePostDelegate: IncrementDelegate? = nil
    var postID = 0
    var selectedPost: Post!
    var postArrayPosition: Int!
    var currentLikeCount: Int!

    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var likePostButtonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCaption.text = selectedPost.title
        postLikes.text = String(selectedPost.likeCount)
        postID = selectedPost.postID
        currentLikeCount = selectedPost.likeCount

   
    }
    
    
    @IBAction func likePostButton(_ sender: UIButton) {
        let currentPostPositionInArray : Int = postArrayPosition ?? 0
        
        //print("hi postID \(postID) postArrayPosition \(currentPostPositionInArray)")
        
        if (myLikePostDelegate != nil) {
            //print("You clicked IndividualPostViewController myLikePostDelegate")
            print("Current Count \(currentLikeCount!)")
            currentLikeCount = currentLikeCount + 1
            postLikes.text = String(currentLikeCount)
            
            myLikePostDelegate!.likePost(postID: postID, arrayPosition: currentPostPositionInArray)
        }
    }
    

    
}


/*
 
 class SecondViewController: UIViewController {
     var myCountDelegate: IncrementDelegate? = nil
     var currentCount: Int = 0
     
     @IBOutlet weak var secondCountLabel: UILabel!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         secondCountLabel.text = String(currentCount)
     }


     @IBAction func addButton(_ sender: UIButton) {
         if (myCountDelegate != nil) {
             //let userInput : String = inputTextField.text ?? ""
             //myDelegate!.userEnteredInformation(newUser: userInput)
             currentCount = currentCount + 1
             secondCountLabel.text = String(currentCount)
             myCountDelegate!.incrementCount(updatedCount: currentCount)
         }
     }
     
 }


 */
