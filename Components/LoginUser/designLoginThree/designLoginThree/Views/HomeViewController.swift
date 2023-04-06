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
        print("Get Posts")
        getPosts()
    }
    
    
    
}

func getPosts() {
    let urlString = "http://localhost:3003/posts/group/72"
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
                }
            
                
                let decoder = JSONDecoder()
                /*
                let posts = try decoder.decode(Posts.self, from: data)
                let postArray = posts.posts
                for post in postArray {
                    print("\(post.userName) \(post.caption)")
                }
                 */
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }.resume()
}
