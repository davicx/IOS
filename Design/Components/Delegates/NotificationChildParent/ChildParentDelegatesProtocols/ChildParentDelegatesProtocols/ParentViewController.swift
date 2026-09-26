//
//  ParentViewController.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit



class ParentViewController: UIViewController, PlantDelegate {

    weak var delegate: PlantDelegate?
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "ParentVC"

        NotificationCenter.default.addObserver(self, selector: #selector(handlePlantUpdated), name: .plantUpdated, object: nil)

        label.numberOfLines = 0
        label.frame = CGRect(x: 40, y: 120, width: 300, height: 100)
        view.addSubview(label)
        updateLabel()

        let flowerButton = UIButton(type: .system)
        flowerButton.setTitle("Add Flower", for: .normal)
        flowerButton.frame = CGRect(x: 80, y: 240, width: 200, height: 40)
        flowerButton.addTarget(self, action: #selector(addFlowerTapped), for: .touchUpInside)
        view.addSubview(flowerButton)

        let nextButton = UIButton(type: .system)
        nextButton.setTitle("→ Go to ChildVC", for: .normal)
        nextButton.frame = CGRect(x: 80, y: 300, width: 240, height: 40)
        nextButton.addTarget(self, action: #selector(goToGrandparent), for: .touchUpInside)
        view.addSubview(nextButton)
    }

    func didAddPlant(_ plantName: String) {
        delegate?.didAddPlant(plantName)
        NotificationCenter.default.post(name: .plantUpdated, object: nil)
        updateLabel()
    }

    @objc func handlePlantUpdated() {
        updateLabel()
    }

    @objc func addFlowerTapped() {
        didAddPlant("Flower")
    }

    @objc func goToGrandparent() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let childVC = storyboard.instantiateViewController(withIdentifier: "ChildVC") as? ChildViewController {
            childVC.delegate = self
            navigationController?.pushViewController(childVC, animated: true)
        }
    }


    func updateLabel() {
        let plants = PlantModel.shared.plants
        label.text = plants.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}

