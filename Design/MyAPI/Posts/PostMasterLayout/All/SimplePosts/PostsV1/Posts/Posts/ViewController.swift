//
//  ViewController.swift
//  Posts
//
//  Created by David Vasquez on 9/24/24.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var postsArray: [Post] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        postsArray = fetchData()
        tableView.reloadData()
    }
    
    //SETUP
    func configureTableView() {
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //FUNCTIONS: API
    func fetchData() -> [Post] {
        let post1 = Post(postImage: UIImage(named: "background_1")!, postCaption: "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things. Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.")
        let post2 = Post(postImage: UIImage(named: "background_2")!, postCaption: "Elvish singing is not a thing to miss, in June")
        let post3 = Post(postImage: UIImage(named: "background_3")!, postCaption: "Hiya Sam!")
        let post4 = Post(postImage: UIImage(named: "tall")!, postCaption: "Hiya Sam! wanna garden today!!!!!")
        let post5 = Post(postImage: UIImage(named: "long")!, postCaption: "Yes lets do it!!!")

        return [post1, post2, post3, post4, post5]
    }

}


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


    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = postsArray[indexPath.row].postImage
        let aspectRatio = image.size.height / image.size.width
        let blueHeight = UIScreen.main.bounds.width * aspectRatio
        
        return 40 + blueHeight + 12 + 40// Total height calculation
    }
     */
}








/*
 //
 //  ViewController.swift
 //  UITableViewTutorialCustomCellsProgrammatic
 //
 //  Created by David Vasquez on 9/15/24.
 //

 import UIKit


 class ViewController: UIViewController {

     var tableView = UITableView()
     var videos: [Video] = []
     
     struct Cells {
         static let videoCell = "VideoCell"
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         videos = fetchData()
         configureTableView()
         title = "Hiya!"
     }
     
     func configureTableView() {
         view.addSubview(tableView)
         //set delegates
         setTableViewDelegates()

         //set row height
         tableView.rowHeight = 120
         
         //register cells
         tableView.register(VideoCell.self, forCellReuseIdentifier: Cells.videoCell)

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
         print("numberOfRowsInSection")
         return videos.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print("cellForRowAt")
         let currentVideo = videos[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: Cells.videoCell) as! VideoCell
         cell.setVideo(video: currentVideo)
         
         return cell
     }
 }

 extension ViewController {
     func fetchData() -> [Video] {
         print("Get Videos!")
         let video1 = Video(image: Images.background_1, title: "Forever we are Lost")
         let video2 = Video(image: #imageLiteral(resourceName: "background_2"), title: "Catch the Sky")
         let video3 = Video(image: Images.background_2, title: "Southern Charm")
         let video4 = Video(image: #imageLiteral(resourceName: "background_4"), title: "Northern Lights")
         let video5 = Video(image: #imageLiteral(resourceName: "background_5"), title: "From below the twilight")
         let video6 = Video(image: #imageLiteral(resourceName: "background_1"), title: "From a Well Beside the Ocean")
         
         return [video1, video2, video3, video4, video5, video6]
     }
 }



 */
