//
//  ViewController.swift
//  TableViewProgrammatic
//
//  Created by David Vasquez on 8/25/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        addButton()
        //addLabel()
        

    }
    
    func addLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "Hello"
        self.view.addSubview(label)
    }
    
    func addButton() {
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    

    func configureTableView() {
        view.addSubview(tableView)
        //Set Delegates
        
        //Set Row Height
        
        //Register Cells
        
        //Set Constraints
        
    }
    
    func setTableViewDelegates() {
        
    }

    
}


