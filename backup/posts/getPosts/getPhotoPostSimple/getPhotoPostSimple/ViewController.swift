//
//  ViewController.swift
//  getPhotoPostSimple
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaptionField: UILabel!
    @IBOutlet weak var postToField: UILabel!
    @IBOutlet weak var postFromField: UILabel!
    
    @IBOutlet weak var postIDField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getPostButton(_ sender: Any) {
        let postID = postIDField.text!
        print("The ID is \(postID)")
    }
    
}

