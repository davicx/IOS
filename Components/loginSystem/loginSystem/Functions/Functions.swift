//
//  Functions.swift
//  loginSystem
//
//  Created by David Vasquez on 7/21/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation


func registerUser(userName: String, fullName: String, email: String, password: String) {
    
    //var registerUserOutcome = RegisterUserModel()
    //registerUserOutcome.master_success = 0
    
    
    let parameters = [
        "user_name": userName,
        "full_name": fullName,
        "email": email,
        "password": password,
        "user_key": "my_key"
    ]
    
    guard let url = URL(string:    "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/user/register_user.php") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                //let userModelArray = try JSONDecoder().decode([UserModel].self, from: data)
                let currentUser = try JSONDecoder().decode(RegisterUserModel.self, from: data)
                print(currentUser.user_name)
                print(currentUser.username_failure)
                print(currentUser.user_name_message)
                print(currentUser.email)
                print(currentUser.email_failure)
                print(currentUser.email_message)
                print(currentUser.full_name)
                print(currentUser.password)
                print(currentUser.user_key)
                print(currentUser.master_success)
                print("______________")
                
                
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
    
    
}


