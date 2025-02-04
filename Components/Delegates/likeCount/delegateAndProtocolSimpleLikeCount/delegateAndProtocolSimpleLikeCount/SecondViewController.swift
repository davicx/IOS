//
//  SecondViewController.swift
//  delegateAndProtocolSimpleLikeCount
//
//  Created by David Vasquez on 12/28/24.
//

import UIKit


class SecondViewController: UIViewController {
    var myCountDelegate: IncrementDelegate? = nil
    var currentCount: Int = 0
    
    @IBOutlet weak var secondCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondCountLabel.text = String(currentCount)
    }


    @IBAction func addButton(_ sender: UIButton) {
        if (myCountDelegate != nil) {
            //let userInput : String = inputTextField.text ?? ""
            //myDelegate!.userEnteredInformation(newUser: userInput)
            currentCount = currentCount + 1
            secondCountLabel.text = String(currentCount)
            myCountDelegate!.incrementCount(updatedCount: currentCount)
        }
    }
    
}


/*

// Second ViewController
class SecondViewController: UIViewController {
    var myCountDelegate: IncrementDelegate? = nil
    var currentCount: Int = 0
    @IBOutlet weak var secondCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        secondCountLabel.text = String(currentCount)
    }

    @IBAction func addButton(_ sender: UIButton) {
        currentCount += 1
        secondCountLabel.text = String(currentCount)
        myCountDelegate?.incrementCount(updatedCount: currentCount)
    }
}

*/



/*
class SecondViewController: UIViewController {
    
    var myDelegate: InputDelegate? = nil
    
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func addUserButton(_ sender: UIButton) {

    }

}
 */

/*
protocol CountDelegate {
    func addOne(oneNumber: Int)
}
*/

/*
 
 import UIKit

 protocol InputDelegate {
     func userEnteredInformation(newUser: String)
 }

 class SecondViewController: UIViewController {
     
     var myDelegate: InputDelegate? = nil
     
     
     @IBOutlet weak var inputTextField: UITextField!
     
     override func viewDidLoad() {
         super.viewDidLoad()

     }
     

     @IBAction func addUserButton(_ sender: UIButton) {
         let userInput : String = inputTextField.text ?? ""
         
         print(userInput)
         
         if (myDelegate != nil) {
             let userInput : String = inputTextField.text ?? ""
             myDelegate!.userEnteredInformation(newUser: userInput)
             //self.navigationController?.popViewController(animated: true)
         }
     }

 }
 */



/*
class SecondViewController: UIViewController {
    
    
    // Counter label
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Count: 0"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Increment button
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increment", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: CounterDelegate?
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(counterLabel)
        view.addSubview(incrementButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            incrementButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            incrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Button action
        incrementButton.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
        
        // Set initial count
        updateCounterLabel()
    }
    
    @objc private func incrementCounter() {
        counter += 1
        updateCounterLabel()
    }
    
    private func updateCounterLabel() {
        counterLabel.text = "Count: \(counter)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateCounter(with: counter)
    }
}

*/

//SIMPLE 1: ONE WAY
/*
class SecondViewController: UIViewController {
    var currentCount: Int = 0
    
    @IBOutlet weak var secondCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondCountLabel.text = "the count is \(currentCount)"
       
    }


    @IBAction func addButton(_ sender: UIButton) {
        currentCount = currentCount + 1
        secondCountLabel.text = "the count is \(currentCount)"
    }
    
}

*/
