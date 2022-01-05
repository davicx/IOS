//
//  PostFunctions.swift
//  getSinglePost
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/16/21.
//

import Foundation


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

//Function A2: Get Posts to a group (GET)
func getGroupPosts(groupID: Int) {
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


//Function B1: Filter PostModel into Post Class
func filterPostModelIntoPost(postModelArray: [PostModel]) -> Array<Post> {
    var postsArrayInternal: [Post] = []
    
    for post in postModelArray {
        let currentPost = Post(postID: post.postID, postCaption: post.postCaption)
        currentPost.postFrom = post.postFrom
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
        currentPost.postType = post.postType
        postsArrayInternal.append(currentPost)

    }
    return postsArrayInternal
}


