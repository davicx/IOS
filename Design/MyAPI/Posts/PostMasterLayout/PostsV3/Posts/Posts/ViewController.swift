//
//  ViewController.swift
//  Posts
//
//  Created by David Vasquez on 9/24/24.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    private var imageHeights: [UIImage] = [] // Store your images

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        
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
        //return 40 + blueHeight + 12 + 40// Total height calculation
        return blueHeight + 80
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




/*
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var postsArray: [Post] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        postsArray = fetchData()
        tableView.reloadData()
    }
    
    //SETUP: Setup for table view
    func configureTableView() {
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //FUNCTIONS: API A mock API for our data
    func fetchData() -> [Post] {
        let post1 = Post(postImage: UIImage(named: "background_1")!, postCaption: "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things. Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.")
        let post2 = Post(postImage: UIImage(named: "tall")!, postCaption: "Elvish singing is not a thing to miss, in June")
        let post3 = Post(postImage: UIImage(named: "background_3")!, postCaption: "Hiya Sam!")
        let post4 = Post(postImage: UIImage(named: "long")!, postCaption: "Hiya Sam! wanna garden today!!!!!")
        let post5 = Post(postImage: UIImage(named: "background_2")!, postCaption: "Yes lets do it!!!")

        return [post1, post2, post3, post4, post5]
    }

}


//TABLE VIEW: Code to add table view information
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! IndividualPostCell

        let image = currentPost.postImage
        let postCaption = currentPost.postCaption

        cell.setPost(with: image, postCaption: postCaption)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostImage = postsArray[indexPath.row].postImage
        let aspectRatio = currentPostImage.size.height / currentPostImage.size.width
        let imageHeight = UIScreen.main.bounds.width * aspectRatio
        
        //return 40 + blueHeight + 12 + 40// Total height calculation
        print("imageHeight \(imageHeight)")
        return imageHeight
    }
    
}
*/

