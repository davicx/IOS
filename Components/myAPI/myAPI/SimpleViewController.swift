//
//  SimpleViewController.swift
//  myAPI
//
//  Created by David on 3/5/23.
//

import UIKit

class SimpleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func simpleOneButton(_ sender: UIButton) {
        print("hi!")
        simpleGET()
    }
    
    func simpleGET() {
        let urlString = "http://localhost:3003/post"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "postCaption": "hiya!"
        ]
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch let error {
            print("Error occured parsing to json")
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("error!!", error)
                return
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        print("JSON")
                        print(response)
                        print(json)
                    }
                } catch let error {
                    print("error!!", error)
                }
            }
        }.resume()
        
    }
}

/*
let urlString = "http://localhost:3003/posts/group/77"
let url = URL(string: urlString)

guard url != nil else {
    return
}

let session = URLSession.shared
let dataTask = session.dataTask(with: url!) { (data, response, error) in
    
    //Parse JSON
    if error == nil && data != nil {
        do {
            let decoder = JSONDecoder()
            //print(response)

            print("START")
            let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
            //print(postArray)

            for post in postArray {
                print("\(post.postFrom) \(post.postCaption)")
            }
            
            print("END")
             
            //print(postArray[0].userName)
            //print(postArray[1])
            //let posts = try JSONDecoder().decode(posts.self, from: data!)
            //let postArray = posts[post]
            //print(response)
     
        } catch {
            print("Error Parsing JSON")
            
        }
    }
}
dataTask.resume()
*/
