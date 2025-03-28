//
//  ViewController.swift
//  TableViewComplete
//
//  Created by David Vasquez on 12/29/24.
//  Copyright © 2024 David Vasquez. All rights reserved.
//

import UIKit


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
