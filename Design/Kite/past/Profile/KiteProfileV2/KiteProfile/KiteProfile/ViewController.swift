//
//  ViewController.swift
//  KiteProfile
//
//  Created by David Vasquez on 12/13/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    //SECTION: Followers
    //Following
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    //Followers
    
    //Likes
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileImageView.image = UIImage(named: "background_10")
        userProfileImageView.makeRounded()
        
        userNameLabel.text = "@Frodo"
        
        //Followers
        followingCountLabel.text = "21"
        followingLabel.text = "Following"
        
        
    }


}


//https://www.youtube.com/watch?v=WkZ5YumTz88
