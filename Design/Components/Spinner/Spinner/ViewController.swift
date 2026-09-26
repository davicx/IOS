//
//  ViewController.swift
//  Spinner
//
//  Created by David Vasquez on 8/27/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startLabel: UILabel!
    
    var activityIndicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityIndicator)
        
    }


    @IBAction func startButton(_ sender: UIButton) {
        print("start")
        activityIndicator.startAnimating()
        startLabel.text = "Getting some posts man!"
        view.isUserInteractionEnabled = false
        
        Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.startLabel.text = "Got them posts dude!"
        }
    }
    

    // Optionally disable specific controls like buttons
    //actionButton.isEnabled = false


    @IBAction func stopButton(_ sender: UIButton) {
        print("stop")
        startLabel.text = "I am Stopped"
        activityIndicator.stopAnimating()

    }
    
}


/*
 var activityIndicator = UIActivityIndicatorView()
 override func viewDidLoad() {
 super.viewDidLoad ( )
 activityIndicator.center = self.view.center
 activityIndicator.hidesWhenStopped = true
 activityIndicator.activityIndicatorViewStyle=.gray self.view.addSubview(activityIndicator)
 }
 @IBAction func startPressed (_
 sender: UIButton) {
 activityIndicator.startAnimating()
 displayLbl.text = "Firing up server and generating UI"
 UIApplication.shared.beginIgnoringInteractionEvents()
 Timer.scheduledTimer (withTimeInterval: 5, repeats: false) { (timer) in
 UIApplication.shared.endIgnoringInteractionEvents()
 self.displayLb1.text = "Goood to GO"I
 }
 }
 @IBAction func stopPressed_
 sender: UIButton) {
 displayLbl.text = "I am Stopped
 activityIndicator.stopAnimating()
 }
 */
