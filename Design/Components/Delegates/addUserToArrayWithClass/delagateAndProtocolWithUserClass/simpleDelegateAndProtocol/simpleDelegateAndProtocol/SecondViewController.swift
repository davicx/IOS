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


/*

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
 */
