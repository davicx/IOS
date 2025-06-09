//
//  GrandparentViewController.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit


class GrandparentViewController: UIViewController, PlantDelegate {

    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "GrandparentVC"

        label.numberOfLines = 0
        label.frame = CGRect(x: 40, y: 200, width: 300, height: 200)
        view.addSubview(label)
        updateLabel()
    }

    func didAddPlant(_ plantName: String) {
        PlantModel.shared.plants[plantName, default: 0] += 1
        updateLabel()
    }

    func updateLabel() {
        let plants = PlantModel.shared.plants
        label.text = plants.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}
