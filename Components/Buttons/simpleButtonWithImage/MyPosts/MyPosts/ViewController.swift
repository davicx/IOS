//
//  ViewController.swift
//  MyPosts
//
//  Created by David Vasquez on 8/20/24.
//

import UIKit

class ViewController: UIViewController {

    let liked = false

    
    @IBOutlet weak var likePostStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let likedImage = UIImage(named: "like")
        likePostStyle.setImage(likedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
 
        likePostStyle.imageView?.contentMode = .scaleAspectFit
    }
    
    
    
    @IBAction func likePostButton(_ sender: UIButton) {
        print("Hi")
    }

}

