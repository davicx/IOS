//
//  ViewController.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var users = ["sam", "merry", "frodo", "david"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }



}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualUserCell") as! IndividualPostViewCell
        
        cell.setUser(currentUser: currentUser)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser)!!")
    }
}


