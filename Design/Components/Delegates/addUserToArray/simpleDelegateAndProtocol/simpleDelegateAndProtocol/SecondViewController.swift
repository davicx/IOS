//
//  SecondViewController.swift
//  simpleDelegateAndProtocol
//
//  Created by David Vasquez on 8/1/24.
//

import UIKit

protocol InputDelegate {
    func userEnteredInformation(newUser: String)
}

class SecondViewController: UIViewController {
    
    var myDelegate: InputDelegate? = nil
    
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func addUserButton(_ sender: UIButton) {
        let userInput : String = inputTextField.text ?? ""
        
        print(userInput)
        
        if (myDelegate != nil) {
            let userInput : String = inputTextField.text ?? ""
            myDelegate!.userEnteredInformation(newUser: userInput)
            //self.navigationController?.popViewController(animated: true)
        }
    }

}
