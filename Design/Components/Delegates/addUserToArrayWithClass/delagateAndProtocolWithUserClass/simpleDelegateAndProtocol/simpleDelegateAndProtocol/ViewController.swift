//
//  ViewController.swift
//  simpleDelegateAndProtocol
//
//  Created by David Vasquez on 8/1/24.
//

import UIKit

//First View Controller
class ViewController: UIViewController, InputDelegate {
    
    var users = [User(userID: 1, userName: "merry")]

    func userEnteredInformation(newUser: User) {
        users.append(newUser)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(users[0].userName)
    }


    @IBAction func printUsersArrayButton(_ sender: UIButton) {
        print("Printing Users")
        printDate()
        for user in users {
            print("User: \(user.userName) \(user.userID)")
        }
        print("__________")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let secondVC: SecondViewController = segue.destination as! SecondViewController
            secondVC.myDelegate = self
        }
    }
    
    func printDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: Date())

        print("Formatted date: \(formattedDate)")
    }
    
}
