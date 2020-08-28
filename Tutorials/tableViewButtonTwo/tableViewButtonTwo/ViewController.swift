//
//  ViewController.swift
//  tableViewButtonTwo
//
//  Created by David Vasquez on 8/22/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }


    @IBAction func helloButton(_ sender: UIButton) {
        print("hello One")
        touchAButton(withTitle: "Hello", on: sender)
    }
    

    @IBAction func helloTwoButton(_ sender: UIButton) {
        print("hello Two")
        touchAButton(withTitle: "hello", on: sender)
    }
    
    @IBAction func hiyaButton(_ sender: UIButton) {
        print("hiya!")
        touchAButton(withTitle: "hello", on: sender)
    }
    
    
    func touchAButton(withTitle title: String, on button: UIButton) {
        if button.currentTitle == "hello" {
            button.setTitle("touched", for: UIControl.State.normal)
        } else {
            button.setTitle("hello", for: UIControl.State.normal)
        }
    }
    
    //https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-button-to-a-uitableviewcell
    
}

