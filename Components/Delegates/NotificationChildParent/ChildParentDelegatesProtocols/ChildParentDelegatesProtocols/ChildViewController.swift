//
//  ChildViewController.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit


protocol PlantDelegate: AnyObject {
    func didAddPlant(_ plantName: String)
}


class ChildViewController: UIViewController {

    weak var delegate: PlantDelegate?
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "ChildVC"

        NotificationCenter.default.addObserver(self, selector: #selector(handlePlantUpdated), name: .plantUpdated, object: nil)

        label.numberOfLines = 0
        label.frame = CGRect(x: 40, y: 120, width: 300, height: 100)
        view.addSubview(label)
        updateLabel()

        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Tree", for: .normal)
        addButton.frame = CGRect(x: 80, y: 240, width: 200, height: 40)
        addButton.addTarget(self, action: #selector(addTreeTapped), for: .touchUpInside)
        view.addSubview(addButton)

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("→ Go to ParentVC", for: .normal)
        nextButton.frame = CGRect(x: 80, y: 300, width: 200, height: 40)
        nextButton.addTarget(self, action: #selector(goToParent), for: .touchUpInside)
        view.addSubview(nextButton)
    }

    @objc func handlePlantUpdated() {
        updateLabel()
    }

    func updateLabel() {
        let plants = PlantModel.shared.plants
        label.text = "Tree: \(plants["Tree", default: 0])\nFlower: \(plants["Flower", default: 0])\nBush: \(plants["Bush", default: 0])"
    }

    @objc func addTreeTapped() {
        delegate?.didAddPlant("Tree")
    }

    @objc func goToParent() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let parentVC = storyboard.instantiateViewController(withIdentifier: "ParentVC") as? ParentViewController {
            parentVC.delegate = self.delegate  // Forward delegate (likely Grandparent)
            navigationController?.pushViewController(parentVC, animated: true)
        }
    }



}

