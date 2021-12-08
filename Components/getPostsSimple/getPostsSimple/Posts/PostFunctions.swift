//
//  PostFunctions.swift
//  getPostsSimple
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/2/21.
//

import Foundation


//Function A1: Get Posts to a group (GET)
func getPosts(groupID: Int) {
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

//Function A2: Get Posts to a group async (GET)
//func getPostsASYNC(groupID: Int, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
func getPostsASYNC(groupID: Int, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
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


//Function A3: Get Posts to a group (POST) (Need to set this route up)
func getPostsPOST() {
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts/group/77"
    let parameters = ["user_name": "vasquezd", "user_key": "vasquezd"]
    
    guard let url = URL(string: urlString) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                let postArray = try JSONDecoder().decode([PostModel].self, from: data)
                for post in postArray {
                    print("\(post.postID) \(post.postFrom) \(post.postTo) \(post.postCaption) \(post.postType)")
                }
            } catch {
                print(error)
            }
        }
        
    }.resume()
}


//Function B1: Filter PostModel into Post Class
func filterPostModelIntoPost(postModelArray: [PostModel]) -> Array<Post> {
    var postsArrayInternal: [Post] = []
    
    for post in postModelArray {
        let currentPost = Post(postID: post.postID)
        currentPost.postFrom = post.postFrom
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
        currentPost.postType = post.postType
        postsArrayInternal.append(currentPost)

    }
    return postsArrayInternal
}






/*
 //Function 1: Get Posts to a group (GET)
 //Function 2: Get Posts to a group (POST)
 
//CLEAN BELOW
 /*
 //This is to check if the Post is missing the Photo (no photo on server, etc)
 if currentPost.postType == "video" {
     postsArrayInternal.append(currentPost)
 } else {
     if currentPost.imageMissing != 1 {
         postsArrayInternal.append(currentPost)
     }
 }
 */
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



*/


//JSON GET

/*

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Parse JSON
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    //let postList = try decoder.decode(PostModel.self, from: data!)
                    let postList = try JSONDecoder().decode([PostModel].self, from: data!)
                    print(postList[0])
                    print(postList[1])

                } catch {
                    print("Error Parsing JSON")
                    
                }
                

            }
            
        }
        dataTask.resume()
    }
}

*/
