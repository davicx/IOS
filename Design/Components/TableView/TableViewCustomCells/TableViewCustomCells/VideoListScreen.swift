//
//  VideoListScreen.swift
//  TableViewCustomCells
//
//  Created by David Vasquez on 5/20/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

import UIKit

class VideoListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90;
        videos = createArray()
        
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    
    func createArray() -> [Video] {
        let video1 = Video(image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost")
        let video2 = Video(image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky")
        let video3 = Video(image: #imageLiteral(resourceName: "night"), title: "Southern Charm")
        let video4 = Video(image: #imageLiteral(resourceName: "river"), title: "Northern Lights")
        let video5 = Video(image: #imageLiteral(resourceName: "night"), title: "From below the twilight")
        let video6 = Video(image: #imageLiteral(resourceName: "river"), title: "From a Well Beside the Ocean")
        
        return [video1, video2, video3, video4, video5, video6]
    }
    
}

extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentVideo = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        //We could configure the cell here but instead we are going to do it in the VideoCell itself
        //cell.setVideo(video: video)
        cell.setVideo(video: currentVideo)
        
        return cell
    }
}
