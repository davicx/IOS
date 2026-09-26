//
//  ViewController.swift
//  learningJSON
//
//  Created by David Vasquez on 5/16/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//
//https://jsonplaceholder.typicode.com/posts

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var postsArray: [Post] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getPosts { posts, error in
            DispatchQueue.main.async {
                //self.postsArray = filterPostsIntoArray(tempPostArray: tempPostArray)
                posts?.forEach({ (post) in
                    print(post.title)
                    let currentPost = Post(caption: post.title)
                    self.postsArray.append(currentPost)
                    //print(self.postsArray.count)
                })
                self.tableView.reloadData()
                
            }
        }
        
        /*
        getPosts{(posts, err) in
            if let err = err {
                print(err)
                return
            }
            
            posts?.forEach({ (post) in
                print(post.title)
                let currentPost = Post(caption: post.title)
                self.postsArray.append(currentPost)
                print(self.postsArray.count)
            })
            self.tableView.reloadData()
 
        }
 */
    }
    
    //FUNCTIONS
    func getPosts(completion: @escaping ([PostModel]?, Error?) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
       
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let posts = try JSONDecoder().decode([PostModel].self, from: data!)
                completion(posts, nil)
                
            } catch let jsonError {
                completion(nil, jsonError)
            }

            
        }.resume()
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
 getPosts { returnedPosts, error in
 DispatchQueue.main.async {
 self.postsArray = filterPostsIntoArray(tempPostArray: tempPostArray)
 self.tableView.reloadData()
 
 }
 }
 posts?.forEach({ (post) in
 //print(post.title)
 self.postsArray.append(post.title)
 })
 //self.postsArray =
 
 */
    
    /*

 
 func loadPosts() -> [Post] {
 let urlString = "https://jsonplaceholder.typicode.com/posts"
 let url = URL(string: urlString)
 
 

        
        var post1 = Post(title: "")
        var post2 = Post(title: "")
        
        guard url != nil else {
            return []
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Parse JSON
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    //let postList = try decoder.decode(PostModel.self, from: data!)
                    let postList = try JSONDecoder().decode([PostModel].self, from: data!)
                    print(postList[0].title)
                    print(postList[1].title)
                    
                    
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        return[post1, post2]
        }
        dataTask.resume()
        
        */


/*
var videos: [Video] = []

override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.rowHeight = 90;
    videos = createArray()
    
    //tableView.delegate = self
    //tableView.dataSource = self
}


func createArray() -> [Video] {
    let video1 = Video(image: #imageLiteral(resourceName: "river"), title: "Forever we are Lost")
    let video2 = Video(image: #imageLiteral(resourceName: "whale"), title: "Catch the Sky")
    let video3 = Video(image: #imageLiteral(resourceName: "night"), title: "Southern Charm")
    let video4 = Video(image: #imageLiteral(resourceName: "river"), title: "Northern Lights")
    let video5 = Video(image: #imageLiteral(resourceName: "night"), title: "From below the twilight")
    let video6 = Video(image: #imageLiteral(resourceName: "river"), title: "From a Well Beside the Ocean")
    
    return [video1, video2, video3, video4, video5, video6]
}
*/
