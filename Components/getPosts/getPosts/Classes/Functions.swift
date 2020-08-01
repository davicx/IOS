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
