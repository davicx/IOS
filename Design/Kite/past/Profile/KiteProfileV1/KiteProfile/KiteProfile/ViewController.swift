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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileImageView.image = UIImage(named: "background_10")
        userProfileImageView.makeRounded()
        
        userNameLabel.text = "@Frodo"
    }


}


//https://www.youtube.com/watch?v=WkZ5YumTz88
