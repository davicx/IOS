//
//  ViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/29/24.
//  Copyright © 2024 David Vasquez. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var tableView: UITableView!
    //var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNotifications()

        //Get Data from API
        Task {
            await UserDataController.shared.fetchUsers()
        }
    }
    
    //DATA: User Data
    @objc private func usersUpdated() {
        tableView.reloadData()
    }
    
    @objc private func userUpdated(_ notification: Notification) {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(usersUpdated),
            name: .usersUpdated,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userUpdated(_:)),
            name: .userUpdated,
            object: nil
        )
    }

    //TABLE VIEW
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataController.shared.getAllUsers().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let users = UserDataController.shared.getAllUsers()
        let currentUser = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell

        cell.setUser(user: currentUser)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = UserDataController.shared.getAllUsers()[indexPath.row]
        performSegue(withIdentifier: "showIndividualUser", sender: user.userName)
        
    }

    //Send Just the username
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIndividualUser",
           let destination = segue.destination as? IndividualPostViewController,
           let username = sender as? String {
            destination.selectedUsername = username
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


//NEW

//ORIGINAL
/*
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showIndividualUser",
       let destination = segue.destination as? IndividualPostViewController,
       let user = sender as? User {
            destination.selectedUser = user
        }
}
 */



/*
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = createArray()
   
    }
    

    func createArray() -> [Video] {
        let video1 = Video(image: #imageLiteral(resourceName: "lake"), title: "Forever we are Lost")
        let video2 = Video(image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky")
        let video3 = Video(image: #imageLiteral(resourceName: "night"), title: "Southern Charm")
        let video4 = Video(image: #imageLiteral(resourceName: "river"), title: "Northern Lights")
        let video5 = Video(image: #imageLiteral(resourceName: "night"), title: "From below the twilight")
        let video6 = Video(image: #imageLiteral(resourceName: "river"), title: "From a Well Beside the Ocean")
        
        return [video1, video2, video3, video4, video5, video6]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        //We could configure the cell here but instead we are going to do it in the VideoCell itself
        cell.setVideo(video: video)
        
        return cell
    }
    
    
    //DATA SEND: Send Data to New Cell
    var videoTitle:String!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath)
        let video = videos[indexPath.row]
        //var videoTitleToPass = video.title
        videoTitle = video.title
        //print(videoTitleToPass)
        
        self.performSegue(withIdentifier: "showIndividualVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! IndividualPostViewController
        secondController.selectedVideoTitle = videoTitle
        
    }
    
}
*/
