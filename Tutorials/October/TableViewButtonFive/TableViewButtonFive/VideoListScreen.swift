//
//  VideoListScreen.swift
//  TableViewButtonFive
//
//  Created by David Vasquez on 8/31/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class VideoListScreen: UIViewController {

    var videos: [Video] = []
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = createArray()
        tableView.delegate = self
        tableView.dataSource = self 
        
    }
    
    func createArray() -> [Video] {
        let video1 = Video(image: #imageLiteral(resourceName: "whale"), username: "david", friendStatus: 1)
        let video2 = Video(image: #imageLiteral(resourceName: "lake"), username: "bilbo", friendStatus: 1)
        let video3 = Video(image: #imageLiteral(resourceName: "whale"), username: "frodo", friendStatus: 1)
        let video4 = Video(image: #imageLiteral(resourceName: "river"), username: "sam", friendStatus: 1)
        let video5 = Video(image: #imageLiteral(resourceName: "river"), username: "pippin", friendStatus: 1)

        return [video1, video2, video3, video4, video5]
    }

}


extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.setVideo(video: video)
        cell.configure(with: "hiya")
        return cell
    }
}




