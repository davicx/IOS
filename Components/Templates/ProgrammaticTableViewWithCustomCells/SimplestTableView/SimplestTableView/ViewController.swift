//
//  ViewController.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    struct Cells {
        static let postCell = "individualPostCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = fetchData()
        configureTableView()

    }
    
    func configureTableView() {
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()

        //set row height
        tableView.rowHeight = 120
        //tableView.rowHeight = UITableView.automaticDimension
        
        //register cells
        tableView.register(IndividualPostViewCell.self, forCellReuseIdentifier: Cells.postCell)

        //set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualPostCell") as! IndividualPostViewCell

        cell.setUser(currentUser: currentUser)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser.userName)!!")
    }

    
}

extension ViewController {
    func fetchData() -> [User] {
        let userOne = User(userImage: UIImage(named: "background_1")!, userName: "davey")
        let userTwo = User(userImage: UIImage(named: "background_8")!, userName: "sam")
        let userThree = User(userImage: UIImage(named: "background_3")!, userName: "HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures")
        let userFour = User(userImage: UIImage(named: "background_4")!, userName: "merry")

        return [userOne, userTwo, userThree, userFour]
    }
}


