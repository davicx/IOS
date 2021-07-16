//
//  ViewController.swift
//  simpleGetPosts
//
//  Created by Syngenta on 7/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

