//
//  ViewController.swift
//  addFriend
//
//  Created by David Vasquez on 9/5/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    class addFriendModel: Decodable {
        let request_from: String
        let request_to: String
        let add_friend_outcome: Int
        let add_friend_message: String
    }
    @IBAction func addFriend(_ sender: UIButton) {
        let parameters = ["request_from": "vasquezd", "request_to": "matt"]
        
        guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/friends/add_friend.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    let friendResponse = try JSONDecoder().decode(addFriendModel.self, from: data)
                    print("\(friendResponse.request_to) \(friendResponse.request_from)")
                    print(friendResponse.add_friend_message)
                    //print("\(friendResponse.request_from)")
                    
                    //completionHandler(postModelArray, nil)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}




