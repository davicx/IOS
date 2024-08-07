//
//  BaseScreen.swift
//  Delegates-Protocols
//
//  Created by Sean Allen on 5/20/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
// This is the Intern Just Gets the Information

import UIKit

class BaseScreen: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = chooseButton.frame.size.height/2
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        //Self is the Base Screen s
        selectionVC.selectionDelegate = self
        present(selectionVC, animated: true, completion: nil)
    }
}


extension BaseScreen: SideSelectionDelegate {
    
    //This is actually getting called from another Screen (SelectionScreen) 
    func didTapChoice(image: UIImage, name: String, color: UIColor, david: String) {
        mainImageView.image = image
        nameLabel.text = name
        print("davey! \(david)")
        
        view.backgroundColor = color
    }
    
}
