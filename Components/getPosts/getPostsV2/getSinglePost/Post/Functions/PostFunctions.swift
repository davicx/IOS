//
//  PostFunctions.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/16/21.
//

import Foundation
import UIKit


//Function A1: Get Posts to a group (GET)
func getGroupPosts(groupID: Int, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts/group/\(groupID)"
    let url = URL(string: urlString)
    
    guard url != nil else {
        return
    }
   
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url!) { (data, response, error) in

        if error == nil && data != nil {
            do {
                let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
                completionHandler(postArray, nil)
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }
    dataTask.resume()
}


//Function B1: Filter PostModel into Post Class
func createPostsArray(postModelArray: [PostModel]) -> Array<Post> {
    var postsArrayInternal: [Post] = []
    
    for post in postModelArray {
        let currentPost = Post(postID: post.postID, postCaption: post.postCaption)
        currentPost.postFrom = post.postFrom
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
        currentPost.postType = post.postType
        currentPost.fileUrl = "https://kite-post-photo-upload.s3.us-west-2.amazonaws.com/1637111930787hiya.jpg"
        
        //Load Image
        //currentPost.postImage = UIImage(named: "clouds")
        if let url = URL(string: currentPost.fileUrl) {
            do {
                let data = try Data(contentsOf: url)
                currentPost.postImage = UIImage(data: data)
            } catch let err {
                currentPost.postImage = UIImage(named: "clouds")
                print("we couldn't load the image")
                //print("error ", err)
            }
        }
        //Load Image End
        
        postsArrayInternal.append(currentPost)

    }
    return postsArrayInternal
}


func getPostImage() {
    
}

/*
import UIKit

class Post {
    let postID: Int
    var postFrom = ""
    var postCaption = ""
    var imageURL = ""
    var postImage: UIImage?
    
    init(postID: Int) {
        self.postID = postID
    }

}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //let urlKey = "https://live.staticflickr.com/7506/26400112934_c548d6484a_b.jpg"
    let urlKey = "https://kite-post-photo-upload.s3.us-west-2.amazonaws.com/1637111930787hiya.jpg"

    @IBAction func getImage(_ sender: Any) {
        
        var currentPost = Post(postID: 1)
        currentPost.imageURL = urlKey
        
        //Load Image
        if let url = URL(string: currentPost.imageURL) {
            do {
                currentPost.postCaption = "hi"
                let data = try Data(contentsOf: url)
                currentPost.postImage = UIImage(data: data)
                //self.imageView.image = UIImage(data: data)
                self.imageView.image = currentPost.postImage
                print(currentPost.postCaption)
            } catch let err {
                print("error ", err)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

*/



//APPENDiX

/*

//Function A1: Get Single Post
func getPost(postID: Int, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let groupID = 70
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts/group/\(groupID)"
    let url = URL(string: urlString)
    
    guard url != nil else {
        return
    }
   
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url!) { (data, response, error) in

        if error == nil && data != nil {
            do {
                let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
                completionHandler(postArray, nil)
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }
    dataTask.resume()
}


func getGroupPostsPrint(groupID: Int) {
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts/group/\(groupID)"
    let url = URL(string: urlString)
    
    guard url != nil else {
        return
    }
   
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url!) { (data, response, error) in

        if error == nil && data != nil {
            do {
                let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
                for post in postArray {
                    print("\(post.postID) \(post.postFrom) \(post.postTo) \(post.postCaption) \(post.postType)")
                }
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }
    dataTask.resume()
}

*/
