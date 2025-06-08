//
//  GrandparentViewController.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit


class GrandparentViewController: UIViewController {

    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "GrandparentVC"

        NotificationCenter.default.addObserver(self, selector: #selector(handlePlantUpdated), name: .plantUpdated, object: nil)
        
        setUpStyle()
    }

    @objc func goToParent() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let parentVC = storyboard.instantiateViewController(withIdentifier: "ParentVC") as? ParentViewController {
            navigationController?.pushViewController(parentVC, animated: true)
        }
    }

    func updateLabel() {
        label.text = PlantDataController.shared.getAllPlantsText()
    }

    @objc func handlePlantUpdated() {
        updateLabel()
    }
    
    
    //STYLE
    func setUpStyle() {
        label.numberOfLines = 0
        label.frame = CGRect(x: 40, y: 200, width: 300, height: 200)
        view.addSubview(label)
        updateLabel()

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("→ Go to ParentVC", for: .normal)
        nextButton.frame = CGRect(x: 80, y: 420, width: 240, height: 40)
        nextButton.addTarget(self, action: #selector(goToParent), for: .touchUpInside)
        view.addSubview(nextButton)
    }
}


