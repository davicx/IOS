//
//  LoadingViewController.swift
//  CheckLoginStatus
//
//  Created by David on 4/11/23.
//

import Foundation
import UIKit


class LoadingViewController: UIViewController {
    
    private let isUserLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("logged in")
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialView()
    }
    
    
    private func setupView() {
        view.backgroundColor = .orange
    }
    
    private func showInitialView() {
        if isUserLoggedIn {
            

        } else {
            performSegue(withIdentifier: "showOnboarding", sender: nil)
        }
        
    }
    
}
