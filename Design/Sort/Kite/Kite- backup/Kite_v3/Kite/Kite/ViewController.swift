//
//  ViewController.swift
//  Kite
//
//  Created by Syngenta on 11/6/21.
//

import UIKit

class ViewController: UIViewController {
    //Stop 15:25 kite-f5de5

    @IBOutlet weak var loginStyle: UIButton!
    @IBOutlet weak var signUpStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    func setUpElements() {
        Style.styleHollowButton(loginStyle)
        Style.styleFilledButton(signUpStyle)

    }

}

