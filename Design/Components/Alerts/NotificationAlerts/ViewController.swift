//
//  ViewController.swift
//  NotificationAlerts
//
//  Created by David Vasquez on 1/6/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushMeButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "You sucesfully Registered", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
}
