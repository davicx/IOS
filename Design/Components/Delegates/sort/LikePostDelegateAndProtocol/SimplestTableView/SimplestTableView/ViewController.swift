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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser)!!")
    }
    
}


/*


 //
 //  VideoListScreen.swift
 //  TableViewComplete
 //
 //  Created by David Vasquez on 5/5/20.
 //  Copyright © 2020 David Vasquez. All rights reserved.
 //

 import UIKit

 class VideoListScreen: UIViewController, UITableViewDataSource, UITableViewDelegate  {
     
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

 /*
  
  */

 */

