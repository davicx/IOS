//
//  ViewController.swift
//  learnDelegateAndProtocol
//
//  Created by David Vasquez on 7/26/24.
//

import UIKit

class ViewController: UIViewController, InputDelegate {

    @IBOutlet weak var userEnteredInputLabel: UILabel!
    
    var arrayOfValues = ["start"]
    var totalLoads = 0

    func userEnteredInformation(info: String) {
        userEnteredInputLabel.text = info
        arrayOfValues.append(info)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let car = Car()
        //car.travel(distance: 100)
        //commute(distance: 800, using: car)
                    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalLoads = totalLoads + 1
    
        print("First View Loaded \(totalLoads)")
        print("Looping over items")
        for item in arrayOfValues {
            print("Items!!, \(item)!")
        }
        print("___________")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let secondVC: SecondViewController = segue.destination as! SecondViewController
            secondVC.myDelegate = self
        }
    }
    
}



protocol Vehicle {
    func estimateTime (for distance: Int) -> Int
    func travel (distance: Int)
}

struct Car: Vehicle {
    func estimateTime (for distance: Int) -> Int {
        distance / 50
    }
    func travel (distance: Int) {
        print ("I'm driving \(distance)km")
    }
    func openSunroof () {
        print ("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    func estimateTime (for distance: Int) -> Int {
        distance / 10
    }
    func travel (distance: Int) {
        print("I'm cycling \(distance) km")
    }
}

func commute (distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime (for: distance) > 10 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

