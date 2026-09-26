//
//  SelectionScreen.swift
//  Delegates-Protocols
//
//  Created by Sean Allen on 5/20/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//THE BOSS (which one knows all the information)

//STOP 9 mins

import UIKit

//A list of commands to send to the intern (list of function names)
protocol SideSelectionDelegate {
    func didTapChoice(image: UIImage, name: String, color: UIColor, david: String)
}

class SelectionScreen: UIViewController {
    
    //This is of the type we just created and we know we have it so we can force unwrap!
    var selectionDelegate: SideSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        print("Imperial ")
        //Send to the Intern
        selectionDelegate.didTapChoice(image: UIImage(named: "vader")!, name: "Darth Vader", color: .red, david: "Hiya")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rebelButtonTapped(_ sender: UIButton) {
            print("Rebel ")
        //Send to the Intern 
        selectionDelegate.didTapChoice(image: UIImage(named: "luke")!, name: "Luke Skywalker", color: .cyan, david: "Hiya Rebel! ")
        dismiss(animated: true, completion: nil)
    }
}
