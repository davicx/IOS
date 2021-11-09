//
//  ViewController.swift
//  LearningAsync
//
//  Created by Syngenta on 11/8/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

/*

//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Kyle Lee on 10/3/17.
//  Copyright © 2017 Kilo Loco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let groupA = ["user 1", "user 2"]
    let groupB = ["user 3", "user 4"]
    let groupC = ["user 5", "user 6"]
    
    var users = [String]()
    
    let dispatchGroup = DispatchGroup()
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
        
    }
    
    func getGroupA() {
        dispatchGroup.enter()
        run(after: 2) {
            print("got A")
            self.users.append(contentsOf: self.groupA)
            self.dispatchGroup.leave()
        }
    }
    
    func getGroupB() {
        dispatchGroup.enter()
        run(after: 4) {
            print("got B")
            self.users.append(contentsOf: self.groupB)
            self.dispatchGroup.leave()
        }
    }
    
    func getGroupC() {
        dispatchGroup.enter()
        run(after: 6) {
            print("got C")
            self.users.append(contentsOf: self.groupC)
            self.dispatchGroup.leave()
        }
    }
    
    func displayUsers() {
        print("reloading data")
        tableView.reloadData()
    }
    
    @IBAction func onDownloadTapped() {
        print("downloading")
        getGroupA()
        getGroupB()
        getGroupC()
        
        dispatchGroup.notify(queue: .main) {
            self.displayUsers()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
}

 
 */
