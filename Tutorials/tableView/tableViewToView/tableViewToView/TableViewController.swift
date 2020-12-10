//
//  TableViewController.swift
//  tableViewToView
//
//  Created by David Vasquez on 12/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

let pets = ["dog", "cat", "rabbit"]
let petDesc = ["dog likes walking", "cat has four legs", "rabbit likes grass"]
var myIndex = 0

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pets.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pets[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
        
    }


}
