//
//  ViewController.swift
//  IntroToUIKitandUIViews
//
//  Created by David Vasquez on 9/7/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(named: "blue")
        
        //New View
        let myView = UIView()
        myView.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
        myView.backgroundColor = .magenta
        
        myView.alpha = 0.5
        print(myView.frame)
        print(myView.bounds)
        print(myView.center)
        
        //Make it stay inside its parent view
        //myView.clipsToBounds = true
        view.addSubview(myView)
        
        let myView2 = UIView()
        myView2.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
        myView2.backgroundColor = .blue
        myView.addSubview(myView2)
        
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 100))
        label.text = "Hiya!"
        label.textAlignment = .center
        label.backgroundColor = .red
        view.addSubview(label)

        let imageView = UIImageView(frame: CGRect(x: 50, y: 400, width: 200, height: 200))
        imageView.image = UIImage(named: "background_1")
        view.addSubview(imageView)
        
        let button = UIButton
        
    
    }


}

