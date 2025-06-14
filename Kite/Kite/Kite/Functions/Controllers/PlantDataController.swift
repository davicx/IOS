//
//  PlantDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit


class PlantDataController {
    static let shared = PlantDataController()

    private(set) var plants: [String: Int] = [
        "Tree": 1,
        "Flower": 1,
        "Bush": 1
    ]

    func addPlant(_ name: String) {
        plants[name, default: 0] += 1
        NotificationCenter.default.post(name: .plantUpdated, object: nil)
    }

    func getPlantCount(_ name: String) -> Int {
        return plants[name, default: 0]
    }

    func getAllPlantsText() -> String {
        return plants.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}

extension Notification.Name {
    static let plantUpdated = Notification.Name("plantUpdated")
}




/*

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


 //
 //  ParentViewController.swift
 //  ChildParentDelegatesProtocols
 //
 //  Created by David Vasquez on 6/7/25.
 //

 import UIKit


 class ParentViewController: UIViewController {

     let label = UILabel()

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemGreen
         title = "ParentVC"

         NotificationCenter.default.addObserver(self, selector: #selector(handlePlantUpdated), name: .plantUpdated, object: nil)
         setUpStyle()
     }

     @objc func addFlowerTapped() {
         PlantDataController.shared.addPlant("Flower")
     }

     @objc func goToChild() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let childVC = storyboard.instantiateViewController(withIdentifier: "ChildVC") as? ChildViewController {
             navigationController?.pushViewController(childVC, animated: true)
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
         nextButton.addTarget(self, action: #selector(goToChild), for: .touchUpInside)
         view.addSubview(nextButton)
     }
 }


 //
 //  ChildViewController.swift
 //  ChildParentDelegatesProtocols
 //
 //  Created by David Vasquez on 6/7/25.
 //

 import UIKit


 class ChildViewController: UIViewController {

     let label = UILabel()

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         title = "ChildVC"

         NotificationCenter.default.addObserver(self, selector: #selector(handlePlantUpdated), name: .plantUpdated, object: nil)

         setUpStyle()

     }

     @objc func addTreeTapped() {
         PlantDataController.shared.addPlant("Tree")
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

 }

 
 */
