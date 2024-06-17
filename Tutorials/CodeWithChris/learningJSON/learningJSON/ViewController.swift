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

