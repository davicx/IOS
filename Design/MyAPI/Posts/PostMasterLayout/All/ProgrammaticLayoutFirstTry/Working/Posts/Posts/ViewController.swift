//
//  ViewController.swift
//  Posts
//
//  Created by David Vasquez on 9/24/24.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private var imageHeights: [UIImage] = [] // Store your images

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        imageHeights = fetchData() // Load your images
        tableView.reloadData()
    }

    func fetchData() -> [UIImage] {
        imageHeights = [
            UIImage(named: "background_1")!,
            UIImage(named: "background_2")!,
            UIImage(named: "background_3")!,
            UIImage(named: "tall")!,
            UIImage(named: "long")!
        ]
        
        //tableView.reloadData()
        
        return imageHeights
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageHeights.count // Use the count of images
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! IndividualPostCell
        let image = imageHeights[indexPath.row]
        
        // Example text for each cell; you can customize this
        let text = "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.\(indexPath.row + 1)"
        
        cell.configure(with: image, text: text)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = imageHeights[indexPath.row]
        let aspectRatio = image.size.height / image.size.width
        let blueHeight = UIScreen.main.bounds.width * aspectRatio
        print("blueHeight \(blueHeight)")
        return 40 + blueHeight + 12 + 40// Total height calculation
    }
}



/*
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

 */


