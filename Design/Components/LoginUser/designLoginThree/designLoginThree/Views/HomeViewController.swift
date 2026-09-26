//
//  HomeViewController.swift
//  designLoginThree
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/30/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func getPostsButton(_ sender: UIButton) {
        print("____________________________")
        print("Get Posts")
        getPosts()
        print("____________________________")
    }
    
    
    
}

func getPosts() {
    let urlString = "http://localhost:3003/posts/group/72"
    //let urlString = "http://localhost:3003/posts/group/80"
    //let token = "myToken!!"
    
    guard let url = URL(string: urlString) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
   
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                    
                    if(response.statusCode == 200) {
                        
                        let decoder = JSONDecoder()
                        
                        let postsResponse = try decoder.decode(PostResponseModel.self, from: data)
                        //print(postsResponse)
                        
                        let postArray = postsResponse.posts
                        
                        //POSTS
                        for post in postArray {
                            print("The POST ")
                            print("\(post.postID) \(post.postCaption)")
                            print("")
                            
                            //COMMENTS
                            let commentsArray = post.commentsArray
                            print("The Comments ")
                            for comment in commentsArray {
                                print("\(comment.commentID) \(comment.commentCaption)")
                            }
                            
                            //POST LIKES
                            let postLikesArray = post.postLikesArray
                            print("The Likes ")
                            for postLike in postLikesArray {
                                print("\(postLike.postLikeID) \(postLike.likedByUserName)")
                            }
                            
                        }
                    } else {
                        print("gotta log in!")
                    }
                    
                }
            
                
     
                 
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }.resume()
}
