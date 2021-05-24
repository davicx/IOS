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
    //var detailText : String?
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //detailLabel.text = detailText
        detailLabel.text = currentUser?.userName
        
        print("You Picked: \(currentUser?.firstName)")
        
    }
    

}
