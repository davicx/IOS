//
//  TableViewController.swift
//  tableViewButton
//
//  Created by David Vasquez on 8/20/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

var pets = ["dog", "cat", "rabbit" ]
var petDesc = ["dog has four legs","eats fish","jumps around"]
var myIndex = 0

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pets[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        print(myIndex)
        performSegue(withIdentifier: "segue", sender: self)
    }
 

}
