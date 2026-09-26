//
//  ViewController.swift
//  TableViewButtonAction
//
//  Created by David Vasquez on 8/31/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    let data = ["First", "Second", "Third", "Fourth", "five"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //table.register(UITableViewCell.self, forCellR)
        table.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        table.dataSource = self
        
        // Do any additional setup after loading the view.
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        //cell.configure(with: data[indexPath.row])
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
        
    }

}

extension ViewController: MyTableViewCellDelegate {

    func didTapButton(with title: String) {
        print(title)
    }
    
}



