//
//  ThirdViewController.swift
//  howToPerformSegue
//
//  Created by David on 7/3/24.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func showThirdStoryboard(_ sender: UIButton) {
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier:
        "finalViewController") as! FinalViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    

}
