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
        print("share")
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


/*
import UIKit

protocol addFriendProtocol {
    //func addFriendClick(index: Int, friendName: String, friendObject: Friend)
    func addFriendClick(index: Int, friendObject: Friend)
}

class FriendCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    //Cell Delegates
    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var currentFriend: Friend?
    //var selectedFriendName: String?
    //var selectedFriendStatus: Int?
 cell.cellDelegate = self
 cell.index = indexPath
 cell.postObject = currentPost
 
    @IBAction func addFriendButton(_ sender: UIButton) {
        //Unwrap Optional
        
        
        print("addFriendButton \(currentFriend?.userName)")
        
        
        //cellDelegate?.addFriendClick(index: i ndex!.row, friendName: selectedFriendName!, friendObject: currentFriend!)
        cellDelegate?.addFriendClick(index: index!.row, friendObject: currentFriend!)
        
        //print("addFriendButton \(friend.userName)")
        flipButton(withString: "", on: sender)
    }
    
    
    //SETUP Methods that Run on Setup the friend information (This is called when the app is loaded)
    func setupFriendCell(friend: Friend){
        friendImage.image = friend.friendImage
        friendName.text = friend.userName
        
        //Set Up the Button Title
        if friend.friendStatus == 1 {
            addFriendButtonOutlet.setTitle("Remove", for: .normal)
        } else {
            addFriendButtonOutlet.setTitle("Add", for: .normal)
        }
    }
    
    
    //BUTTON: Changes to Button
    //Configure Button on Cell Flip
    func flipButton(withString addFriend: String, on button: UIButton) {
        if button.currentTitle == "Add" {
            button.setTitle("Remove", for: UIControl.State.normal)
        } else {
            button.setTitle("Add", for: UIControl.State.normal)
        }
        
    }
}
*/
