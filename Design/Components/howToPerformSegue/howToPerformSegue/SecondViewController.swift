//
//  SecondViewController.swift
//  howToPerformSegue
//
//  Created by David on 7/3/24.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showNextStoryboard(_ sender: UIButton) {
        performSegue(withIdentifier: "showThree", sender: self)
    }
    

}
