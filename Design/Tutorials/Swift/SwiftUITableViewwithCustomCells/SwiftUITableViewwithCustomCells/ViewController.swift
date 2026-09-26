//
//  ViewController.swift
//  SwiftUITableViewwithCustomCells
//
//  Created by David on 7/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var friendTableView: UITableView!
    
    let friends = ["david", "frodo", "sam", "merry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendTableView.delegate = self
        friendTableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let friend = friends[indexPath.row]
        cell.friendImageView.image = UIImage(named: friend)
        cell.friendLabel.text = friend
  
        return cell
    }
    
    
}
