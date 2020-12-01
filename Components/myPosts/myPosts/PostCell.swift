//
//  PostCell.swift
//  myPosts
//
//  Created by David Vasquez on 11/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit


protocol postProtocol {
    func likePost(index: Int, postObject: Post)
    func sharePost(index: Int, postObject: Post)
}


class PostCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
        
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    //Delegates
    var cellDelegate: postProtocol?
    var index: IndexPath?
    var postSelected: Post?
  
    //Set Cell on Load
    func setupPost(post: Post) {
        postImage.image = post.postImage
        postCaptionLabel.text = post.postCaption
        
        //Set the Title for the Two Buttons
        if post.postLikeStatus == 1 {
            likeButtonOutlet.setTitle("Liked", for: .normal)
        } else {
            likeButtonOutlet.setTitle("Like", for: .normal)
        }
        
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        cellDelegate?.likePost(index: index!.row, postObject: postSelected!)
        
        flipButton(withString: "", on: sender)
       
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        cellDelegate?.sharePost(index: index!.row, postObject: postSelected!)
        //print("share")
    }
    
    //Change Button Text on Share
    func flipButton(withString likeButton: String, on button: UIButton) {
        if button.currentTitle == "Liked" {
            button.setTitle("Like", for: UIControl.State.normal)
        } else {
            button.setTitle("Liked", for: UIControl.State.normal)
        }
    }
    
}
