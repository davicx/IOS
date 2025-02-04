//
//  ViewController.swift
//  simpleTableView
//
//  Created by David Vasquez on 7/26/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = ["sam", "frodo", "davey"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Row Click
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you picked me! \(users[indexPath.row])")
        users[indexPath.row] = users[indexPath.row] + "!"
        tableView.reloadData()
    }
    */
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Change Name", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submit = UIAlertAction(title: "Change", style: .default) { (alert) in
            if let textField = alertController.textFields?.first {
                self.users[indexPath.row] = textField.text ?? "No name"
                self.tableView.reloadData()
            }
        }
        alertController.addAction(submit)
        self.present(alertController, animated: true, completion: nil)

    }
    

    //Table Set up
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }

}

