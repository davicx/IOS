//
//  ViewController.swift
//  delegateAndProtocolSimpleLikeCount
//
//  Created by David Vasquez on 12/28/24.
//



import UIKit


protocol IncrementDelegate {
    func incrementCount(updatedCount: Int)
}

class ViewController: UIViewController, IncrementDelegate {
    var masterCount = 20

    @IBOutlet weak var countLabel: UILabel!
    
    func incrementCount(updatedCount: Int) {
        masterCount = updatedCount
        countLabel.text = String(masterCount)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(masterCount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let controller = segue.destination as! SecondViewController
            controller.currentCount = masterCount
            controller.myCountDelegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countLabel.text = String(masterCount)
    }
    
    
}


/*
// First ViewController
class ViewController: UIViewController, IncrementDelegate {
    var masterCount = 20
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(masterCount)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let controller = segue.destination as! SecondViewController
            controller.currentCount = masterCount
            controller.myCountDelegate = self
        }
    }
}

*/


//APPENDIX

/*
class ViewController: UIViewController, InputDelegate {
    var users = ["sam", "davey"]
    
    func userEnteredInformation(newUser: String) {
        users.append(newUser)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func printUsersArrayButton(_ sender: UIButton) {
        print("Printing Users")
        printDate()
        for user in users {
            print(user)
        }
        print("__________")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let secondVC: SecondViewController = segue.destination as! SecondViewController
            secondVC.myDelegate = self
        }
    }
    
    func printDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: Date())

        print("Formatted date: \(formattedDate)")
    }
    
}
*/




/*
import UIKit

class ViewController: UIViewController, InputDelegate {
    var users = ["sam", "davey"]
    
    func userEnteredInformation(newUser: String) {
        users.append(newUser)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func printUsersArrayButton(_ sender: UIButton) {
        print("Printing Users")
        printDate()
        for user in users {
            print(user)
        }
        print("__________")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let secondVC: SecondViewController = segue.destination as! SecondViewController
            secondVC.myDelegate = self
        }
    }
    
    func printDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: Date())

        print("Formatted date: \(formattedDate)")
    }
    
}
*/


/*
 
import UIKit


// Define the protocol for communication
protocol CounterDelegate: AnyObject {
    func updateCounter(with value: Int)
}

class ViewController: UIViewController, CounterDelegate {
    
    // Counter label
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Count: 0"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Button to navigate to SecondViewController
    private let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to SecondViewController", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(counterLabel)
        view.addSubview(navigateButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            navigateButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Button action
        navigateButton.addTarget(self, action: #selector(goToSecondViewController), for: .touchUpInside)
    }
    
    @objc private func goToSecondViewController() {
        let secondViewController = SecondViewController()
        secondViewController.counter = counter
        secondViewController.delegate = self
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // CounterDelegate method
    func updateCounter(with value: Int) {
        counter = value
        counterLabel.text = "Count: \(counter)"
    }
}

*/



//SIMPLE 1: ONE WAY
/*
class ViewController: UIViewController {
    var masterCount = 20

    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondVC" {
            let controller = segue.destination as! SecondViewController
            controller.currentCount = masterCount
        }
    }
    
    //PUSHING DATA
    //Type 1:
     let viewControllerB = ViewControllerB()
     viewControllerB.selectedName = "Taylor Swift"
     navigationController?.pushViewController(viewControllerB, animated: true)
     
    
    //Type 2:

     showSecondVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! ViewControllerB
                controller.selectedName = objects[indexPath.row]
            }
        }
    }
     
}


*/

//PUSHING DATA
//Type 1:
/*
 let viewControllerB = ViewControllerB()
 viewControllerB.selectedName = "Taylor Swift"
 navigationController?.pushViewController(viewControllerB, animated: true)
 */

//Type 2:
/*
 showSecondVC
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = segue.destination as! ViewControllerB
            controller.selectedName = objects[indexPath.row]
        }
    }
}
 */
