//
//  ViewController.swift
//  Posts
//
//  Created by David Vasquez on 9/24/24.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var postsArray: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(IndividualPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        
        postsArray = fetchData() // Load your images
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count // Use the count of images
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! IndividualPostCell
        let image = postsArray[indexPath.row].postImage
        
        // Example text for each cell; you can customize this
        let text = "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.\(indexPath.row + 1)"
        
        cell.configure(with: image, text: text)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostImage = postsArray[indexPath.row].postImage
        let aspectRatio = currentPostImage.size.height / currentPostImage.size.width
        let currentPostImageHeight = UIScreen.main.bounds.width * aspectRatio
        print("currentPostImageHeight \(currentPostImageHeight)")
        //return 40 + blueHeight + 12 + 40// Total height calculation
        return currentPostImageHeight + 44
    }
}

