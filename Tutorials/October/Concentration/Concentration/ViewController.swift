//
//  ViewController.swift
//  Concentration
//
//  Created by David Vasquez on 8/21/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//Stop: L1 45

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addFriend(_ sender: UIButton) {
        flipButton(withString: "Add Friend", on: sender)
    }
    
    func flipButton(withString addFriend: String, on button: UIButton) {
        if button.currentTitle == addFriend {
            button.setTitle("Remove Friend", for: UIControl.State.normal)
        } else {
            button.setTitle("Add Friend", for: UIControl.State.normal)
        }
        
    }
    

}

