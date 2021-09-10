//
//  PostFunctions.swift
//  KiteV1
//
//  Created by Syngenta on 8/31/21.
//

import Foundation


func getPosts(completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts"
    let url = URL(string: urlString)

    guard url != nil else { return }
    
    let session = URLSession.shared
    session.dataTask(with: url!) { (data, response, error) in
        if let data = data {
            do {
                
                let posts = try JSONDecoder().decode([PostModel].self, from: data)
                print("TOTAL \(posts.count)" )
                print("getPosts")
                print(posts[0].postID)
                print(posts[0].postFrom)
                print(posts[0].postCaption)
                print("_________")
                completionHandler(posts, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
}

func createPostsArray(postsArray: [PostModel]) -> [Post] {
    var postsArrayInternal: [Post] = []

    for post in postsArray {
        let currentPost = Post(caption: post.postCaption, postFrom: post.postFrom, postTo: post.postTo)
        postsArrayInternal.append(currentPost)
    }
    print(postsArrayInternal.count)
    
    return postsArrayInternal

}







//APPENDIX
/*
 var postID:Int = 0
 var postFrom:String = ""
 var postTo:String = ""
 var postCaption:String = ""

 func createPostsArrayManual(postsArray: [PostModel]) -> [Post] {
     let post1 = Post(caption: postsArray[0].postCaption)
     let post2 = Post(caption: postsArray[1].postCaption)
     let post3 = Post(caption: "Catch the Sky")
     print(postsArray.count)
     
     return [post1, post2, post3]
 }


func filterPostsIntoArrayOriginal(tempPostArray: [PostModel]) -> Array<Post> {
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
*/


func getPostsPrint() {
    let urlString = "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/posts"
    let url = URL(string: urlString)

    guard url != nil else { return }

    let session = URLSession.shared
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
        
        if error == nil && data != nil {
            
            //Parse JSON
            let decoder = JSONDecoder()
            do {
                
                let posts = try decoder.decode([PostModel].self, from: data!)
                
                print(posts[0].postID)
                print(posts[0].postFrom)
                print(posts[0].postTo)
                print(posts[0].postCaption)
                print("_____________")
                print(posts[1].postID)
                print(posts[1].postFrom)
                print(posts[1].postTo)
                print(posts[1].postCaption)
                

            } catch {
                print("Error parsing JSON")
            }
        }
    }

    dataTask.resume()
    
}


/*
//Get All Posts
getPosts { tempPostArray, error in
    DispatchQueue.main.async {
        self.postsArray = filterPostsIntoArray(tempPostArray: tempPostArray)
        self.tableView.reloadData()
        
    }
}

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
