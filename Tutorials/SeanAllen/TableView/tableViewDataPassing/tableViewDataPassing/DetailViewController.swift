//
//  DetailViewController.swift
//  tableViewDataPassing
//
//  Created by David Vasquez on 5/23/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
   
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var firstName: UILabel!

    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //detailLabel.text = detailText
        detailLabel.text = currentUser?.userName
        firstName.text = currentUser?.
        
        print("You Picked: \(currentUser?.firstName)")
        
    }
    

}
