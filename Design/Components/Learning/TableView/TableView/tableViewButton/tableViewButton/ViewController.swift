//
//  ViewController.swift
//  tableViewButton
//
//  Created by David Vasquez on 8/20/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = pets[myIndex]
        descLabel.text = petDesc[myIndex]
        
        
    }


}

