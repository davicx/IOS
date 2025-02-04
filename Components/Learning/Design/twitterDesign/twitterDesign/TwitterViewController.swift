//
//  TwitterViewController.swift
//  twitterDesign
//
//  Created by Vasquez, Charles Geoffrey David [C] on 3/21/22.
//

import UIKit

class TwitterViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeRounded()
        
        
    }
    
    

    

}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
