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
        let post1 = Post(postImage: UIImage(named: "background_1")!, postCaption: "Elvish singing is not a thing to miss, in June under the stars, not if you care for such things.")
        let post2 = Post(postImage: UIImage(named: "tall")!, postCaption: "Good Morning! said Bilbo, and he meant it. The sun was shining, and the grass was very green. But Gandalf looked at him from under long bushy eyebrows that stuck out further than the brim of his shady hat.")
        let post3 = Post(postImage: UIImage(named: "background_3")!, postCaption: "Farewell they cried, Wherever you fare till your eyries receive you at the journey's end! That is the polite thing to say among eagles.")
        let post4 = Post(postImage: UIImage(named: "long")!, postCaption: "Surely you don’t disbelieve the prophecies, because you had a hand in bringing them about yourself? You don’t really suppose, do you, that all your adventures and escapes were managed by mere luck, just for your sole benefit? You are a very fine person, Mr. Baggins, and I am very fond of you; but you are only quite a little fellow in a wide world after all")
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
        
        cell.updatePost(with: currentImage, postCaption: postCaption)
        
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostImage = postsArray[indexPath.row].postImage
        let postCaption = postsArray[indexPath.row].postCaption
        
        //STEP 1: Get Image Height
        let postImageHeight = round(getImageHeight(image: currentPostImage))
        
        //STEP 2: Get Caption Height
        let captionTextHeight = round(calculateLabelHeight(text: postCaption))
      
        //footer + postImageHeight + captionTextHeight + 8 + comments
        return 10 + postImageHeight + captionTextHeight + 8 + 40

    }
}




/*
 
 
 print("POST \(indexPath.row)")
 print("postImageHeight \(postImageHeight)")
 print("captionTextHeight \(captionTextHeight)")
 print("Row Height \(postImageHeight  + captionTextHeight + 2)")
 print(" ")
 */
