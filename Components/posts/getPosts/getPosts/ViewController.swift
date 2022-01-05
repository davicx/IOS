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




/*
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
    var uncleanedPostsArray: [Post] = []
    var postsArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get All Posts
        getPosts { tempPostArray, error in
            DispatchQueue.main.async {
                self.postModelArray = tempPostArray
                
                
                
                //Create our Post Objects from the Returned JSON (PostModel)
                //Rather then creating two arrays just filter in this top array with the print variables
                for post in self.postModelArray {
                    let currentPost = Post(imageURL: post.image_url, postCaption: post.post_caption)
                    currentPost.postFrom = post.post_from
                    currentPost.postType = post.post_type
                    
                    print("image missing: \(currentPost.imageMissing)")
                    print("post type: \(currentPost.postType)")
                    
                    self.uncleanedPostsArray.append(currentPost)
                }
                
                //Filter out Any Posts that Do not have an image that works
                for post in self.uncleanedPostsArray {
                    print(post.postType)
                    if post.imageMissing != 1 {
                        self.postsArray.append(post)
                    }
                    
                }
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


*/


/*
 
 
 
 /*
 //Create our Post Objects from the Returned JSON (PostModel)
 //Rather then creating two arrays just filter in this top array with the print variables
 for post in self.postModelArray {
 let currentPost = Post(imageURL: post.image_url, postCaption: post.post_caption)
 currentPost.postFrom = post.post_from
 currentPost.postType = post.post_type
 
 print("image missing: \(currentPost.imageMissing)")
 print("post type: \(currentPost.postType)")
 
 self.uncleanedPostsArray.append(currentPost)
 }
 
 //Filter out Any Posts that Do not have an image that works
 for post in self.uncleanedPostsArray {
 print(post.postType)
 if post.imageMissing != 1 {
 self.postsArray.append(post)
 }
 
 }
 */

 */
