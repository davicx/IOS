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
        nextButton.setTitle("→ Go to GrandparentVC", for: .normal)
        nextButton.frame = CGRect(x: 80, y: 300, width: 240, height: 40)
        nextButton.addTarget(self, action: #selector(goToGrandparent), for: .touchUpInside)
        view.addSubview(nextButton)
    }

    func didAddPlant(_ plantName: String) {
        PlantModel.shared.plants[plantName, default: 0] += 1
        delegate?.didAddPlant(plantName)
        updateLabel()
    }

    @objc func addFlowerTapped() {
        didAddPlant("Flower")
    }

    @objc func goToGrandparent() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let grandparentVC = storyboard.instantiateViewController(withIdentifier: "GrandparentVC") as? GrandparentViewController {
            navigationController?.pushViewController(grandparentVC, animated: true)
        }
    }

    func updateLabel() {
        let plants = PlantModel.shared.plants
        label.text = plants.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}
