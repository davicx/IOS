//
//  SecondViewController.swift
//  simpleDelegateAndProtocol
//
//  Created by David Vasquez on 8/1/24.
//

import UIKit

protocol InputDelegate {
    func userEnteredInformation(newUser: User)
}

class SecondViewController: UIViewController {
    
    var myDelegate: InputDelegate? = nil
    
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func addUserButton(_ sender: UIButton) {
        let userInput : String = inputTextField.text ?? ""
        let randomInt = Int.random(in: 0..<10)
  
        if (myDelegate != nil) {
            let newUser = User(userID: randomInt, userName: userInput)
          
            myDelegate!.userEnteredInformation(newUser: newUser)
            //self.navigationController?.popViewController(animated: true)
            print("new user added!")
            inputTextField.text = ""
        }
        
        
    }
    

}

