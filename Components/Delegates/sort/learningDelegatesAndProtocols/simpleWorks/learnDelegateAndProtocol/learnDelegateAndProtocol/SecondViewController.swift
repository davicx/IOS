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
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func sendInputButton(_ sender: UIButton) {
        print("yay!")
        if (myDelegate != nil) {
            let input:String = inputField.text!
            myDelegate!.userEnteredInformation(info: input)
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}
