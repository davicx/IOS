//
//  TableViewController.swift
//  tableViewButtonOne
//
//  Created by David Vasquez on 10/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

var pets = ["dog","cat","rabbit",]
var petsDesc = ["dog has four legs ","oh ya a cat","rabbit's like to eat grass",]
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
