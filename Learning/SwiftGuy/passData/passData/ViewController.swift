//
//  ViewController.swift
//  passData
//
//  Created by David Vasquez on 5/23/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func enter(_ sender: UIButton) {
        if textField.text != "" {
            performSegue(withIdentifier: "segue", sender: self)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var secondController = segue.destination as! SecondViewController
        secondController.myString = textField.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

