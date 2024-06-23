//
//  ViewController.swift
//  MyAPI
//
//  Created by David Vasquez on 6/21/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButton(_ sender: UIButton) {
        loginUser()
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        getAPIButton()
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        postAPIButton()
    }
    
    
    //Functions
    func loginUser() {
        print("Yo! POST!")
        let parameters = ["userName": "davey", "password": "password"]

        
        guard let url = URL(string: "http://localhost:3003/user/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    //print("\(friendResponse.request_to) \(friendResponse.request_from)")
                    print(loginResponse.data.loggedInUser)
                    print(loginResponse.message)
                    //print("\(friendResponse.request_from)")
                    
                    //completionHandler(postModelArray, nil)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func getAPIButton() {
        guard let url = URL(string: "http://localhost:3003/posts/group/72") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        //request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                    //print("\(friendResponse.request_to) \(friendResponse.request_from)")
                    //print(PostResponseModel.data.loggedInUser)
                    print(postResponse.message)
                    //print("\(friendResponse.request_from)")
                    
                    //completionHandler(postModelArray, nil)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    func postAPIButton() {
        
    }
}


