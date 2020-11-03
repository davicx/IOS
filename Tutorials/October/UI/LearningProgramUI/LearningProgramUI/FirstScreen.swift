//
//  FirstScreen.swift
//  LearningProgramUI
//
//  Created by David Vasquez on 8/28/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 300, y: 200, width: 80, height: 40))
        button.backgroundColor = .blue
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        //setupNextButton()
        view.backgroundColor = .red
        
        
    }
    

    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    
    //Button
    func setupNextButton() {
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.red, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        
        setNextButtonConstraints()
        
        view.addSubview(nextButton)
        
        //nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    
    }
    
    
    func setNextButtonConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
 
}

/*

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextButton()
        view.backgroundColor = .red
    }
    
    

    
    
    @objc func nextButtonTapped() {
        let nextScreen = SecondScreen()
        nextScreen.title = "Ahhhh yeah"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    

}
*/

/*

import UIKit

class SecondScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}
*/
