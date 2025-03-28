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
        
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        postsArray = fetchData() // Load your images
        tableView.reloadData()
    }

    //FUNCTIONS: API A mock API for our data
    func fetchData() -> [Post] {
        let post1 = Post(postImage: UIImage(named: "background_1")!, postCaption: "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things. Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.")
        let post2 = Post(postImage: UIImage(named: "tall")!, postCaption: "Elvish singing is not a thing to miss, in June")
        let post3 = Post(postImage: UIImage(named: "background_3")!, postCaption: "Hiya Sam! Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!!")
        let post4 = Post(postImage: UIImage(named: "long")!, postCaption: "Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!! Hiya Sam! wanna garden today!!!!!")
        let post5 = Post(postImage: UIImage(named: "background_2")!, postCaption: "Yes lets do it!!!")

        return [post1, post2, post3, post4, post5]
    }
    

}


//TABLE VIEW: Code to add table view information
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count // Use the count of images
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! IndividualPostCell
        let currentImage = postsArray[indexPath.row].postImage
        let postCaption = postsArray[indexPath.row].postCaption
        
        cell.updatePost(with: currentImage, text: postCaption)
        
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostImage = postsArray[indexPath.row].postImage
        let postCaption = postsArray[indexPath.row].postCaption
        
        //STEP 1: Get Image Height
        let postImageHeight = round(getImageHeight(image: currentPostImage))
        
        //STEP 2: Get Caption Height
        let captionTextHeight = round(calculateLabelHeight(text: postCaption))
        
        
        print("POST \(indexPath.row)")
        print("postImageHeight \(postImageHeight)")
        print("captionTextHeight \(captionTextHeight)")
        print("Row Height \(postImageHeight  + captionTextHeight + 40 + 2)")
        print(" ")
        //return postImageHeight + 84
        return 110 + postImageHeight
    }
}



