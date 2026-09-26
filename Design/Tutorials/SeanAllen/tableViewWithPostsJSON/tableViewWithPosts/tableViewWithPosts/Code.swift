//
//  Code.swift
//  tableViewWithPosts
//
//  Created by David Vasquez on 5/21/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//

//
//  PostCell.swift
//  getPosts
//
//  Created by David Vasquez on 6/7/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
/*
import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView?
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postFromLabel: UILabel!
    
    func setPost(post: Post) {
        self.postTitleLabel.text = post.postCaption
        self.postImageView?.image = post.image
        self.postFromLabel.text = post.postFrom
    }
}

//
//  Functions.swift
//  getPosts
//
//  Created by David Vasquez on 6/10/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

//func getCurrentUser(completionHandler:@escaping (User, Error?)->Void ) {
func getPosts(completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    //func getPosts(tempInput: String, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let parameters = ["user_name": "vasquezd", "user_key": "vasquezd"]
    
    guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/post/get_user_posts.php") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                
                let postModelArray = try JSONDecoder().decode([PostModel].self, from: data)
                completionHandler(postModelArray, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
}


func filterPostsIntoArray(tempPostArray: [PostModel]) -> Array<Post> {
    //postModelArray = tempPostArray
    var postsArrayInternal: [Post] = []
    
    for post in tempPostArray {
        let currentPost = Post(imageURL: post.image_url, postCaption: post.post_caption)
        currentPost.postFrom = post.post_from
        currentPost.postType = post.post_type
        
        //This is to check if the Post is missing the Photo (no photo on server, etc)
        if currentPost.postType == "video" {
            postsArrayInternal.append(currentPost)
        } else {
            if currentPost.imageMissing != 1 {
                postsArrayInternal.append(currentPost)
            }
        }
        
    }
    return postsArrayInternal
}


//
//  ViewController.swift
//  getPosts
//
//  Created by David Vasquez on 6/7/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
//Image Literal type name of file

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //This Array holds all the data returned from the JSON Call
    var postModelArray: [PostModel] = []
    
    //This Array is a smaller array of our Post Class
    var postsArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get All Posts
        getPosts { tempPostArray, error in
            DispatchQueue.main.async {
                self.postsArray = filterPostsIntoArray(tempPostArray: tempPostArray)
                self.tableView.reloadData()
                
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        cell.setPost(post: post)
        
        return cell
    }
    
}

//
//  Post.swift
//  getPosts
//
//  Created by David Vasquez on 6/8/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var postCaption: String
    var postFrom = ""
    var postFromImage: UIImage?
    var imageURL: String
    var imageMissing = 1
    var image: UIImage?
    var postType: String = ""
    
    init(imageURL: String, postCaption: String) {
        self.imageURL = imageURL
        self.postCaption = postCaption
        
        //Set the Post Image
        let urlKey = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/post_images/\(self.imageURL)"
        
        if let url = URL(string: urlKey) {
            do {
                let returnedImage = try Data(contentsOf: url)
                self.image = UIImage(data: returnedImage)
                self.imageMissing = 0
            } catch let err {
                self.imageMissing = 1
                
            }
        }
        
    }
}
*/

