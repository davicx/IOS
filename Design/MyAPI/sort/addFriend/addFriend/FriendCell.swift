//
//  FriendCell.swift
//  addFriend
//
//  Created by David Vasquez on 10/13/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
// Boss

//CELL

import UIKit

protocol addFriendProtocol {
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
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        //Unwrap Optional
        print("addFriendButton \(currentFriend?.userName)")
        
        cellDelegate?.addFriendClick(index: index!.row, friendObject: currentFriend!)
        
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


/*
//SETUP: Setup the view
func setUpView(selectedPost: Post) {
    let likeCount : Int = selectedPost.simpleLikesArray?.count ?? 0
    let simpleLikesArray : Array = selectedPost.simpleLikesArray ?? []
    postImage.image = selectedPost.postImageData
    postCaptionLabel.text = selectedPost.postCaption
    postLikeCountLabel.text = String(likeCount)


    //Like Button
    if simpleLikesArray.contains(currentUser) {
        //print("User has liked the post so text should be UNLIKE")
        let likedImage = UIImage(named: "liked")
        postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
      
    } else {
        print("User has NOT liked the post so text should be LIKE")
        let likedImage = UIImage(named: "like")
        postLikeButtonStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        postLikeButtonStyle.imageView?.contentMode = .scaleAspectFit
      
    }
    

}


@IBAction func postLikeButton(_ sender: UIButton) {
    print("liked!")
    if (myDelegate != nil) {
        print("You Clicked Delegate!")
        myDelegate!.userLikePost(currentUser: "davey")
    }
}

*/
