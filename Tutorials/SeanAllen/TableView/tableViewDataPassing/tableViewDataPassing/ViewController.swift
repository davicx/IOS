//
//  ViewController.swift
//  tableViewDataPassing
//
//  Created by David Vasquez on 5/23/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //let video1 = Video(image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost")
    //let dataSource = ["David", "Frodo", "Bilbo"]
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func createArray() -> [User] {
        let userOne = User(userName: "davey", firstName: "David", lastName: "V")
        let userTwo = User(userName: "frodo", firstName: "Frodo", lastName: "B")
        let userThree = User(userName: "bilbo", firstName: "Bilbo", lastName: "B")
        
        return [userOne, userTwo, userThree]
    }
    
}


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
        print("you clicked \(users[indexPath.row].userName)")
        
        let userPageVC  = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //print(users[indexPath.row])
        //detailVC.detailText = dataSource[indexPath.row]
        userPageVC.currentUser = users[indexPath.row]
        
        navigationController?.pushViewController(userPageVC, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 120
    }
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.cellLabel.text = users[indexPath.row].userName
        
        return cell
    }
}
