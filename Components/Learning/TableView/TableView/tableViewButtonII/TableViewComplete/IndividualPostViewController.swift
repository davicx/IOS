//
//  IndividualPostViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 5/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class IndividualPostViewController: UIViewController {
    
    var selectedVideoTitle: String = ""
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedVideoTitle)
        postTextLabel.text = selectedVideoTitle
    }

}
