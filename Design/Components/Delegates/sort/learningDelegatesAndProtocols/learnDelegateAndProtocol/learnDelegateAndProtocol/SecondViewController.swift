//
//  SecondViewController.swift
//  learnDelegateAndProtocol
//
//  Created by David Vasquez on 7/26/24.
//

import UIKit

protocol InputDelegate {
    func userEnteredInformation(info: String)
}

class SecondViewController: UIViewController {
    
    //Can keep it an optional or not this is optional
    var myDelegate: InputDelegate? = nil
    
    var totalLoads = 0
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLoads = totalLoads + 1
        print("Second View Loaded \(totalLoads)")
        
    }


    @IBAction func sendInputButton(_ sender: UIButton) {
        if (myDelegate != nil) {
            let input:String = inputField.text!
            myDelegate!.userEnteredInformation(info: input)
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}


