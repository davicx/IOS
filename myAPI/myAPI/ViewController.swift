//
//  ViewController.swift
//  myAPI
//
//  Created by David Vasquez on 6/13/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //GET Button
    @IBAction func getButton(_ sender: UIButton) {
        sendGetRequest()

    }

    //POST Button
    @IBAction func postButton(_ sender: UIButton) {
        sendPostRequest()
    }
    
    
    //FUNCTIONS
    //API: Get Request
    func sendGetRequest() {
        print("Yo! GET!")
    }
 
    
    //API: Post Request
    func sendPostRequest() {
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
    
    
   
    /*
     {
         "data": {
             "loginSuccess": true,
             "loggedInUser": "davey",
             "validUser": true,
             "passwordCorrect": true,
             "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNzE4NDA4ODU1LCJleHAiOjE3MTg0MTI0NTV9.9hQqr4bC6_I5Z0cugzK_TFqHy3Wv-7JOHHIS7c6Si54",
             "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW50VXNlciI6ImRhdmV5IiwiaWF0IjoxNzE4NDA4ODU1fQ.ttqqCqjjRKH1gFifi1ZJG1-IQrMiwgtfrwMgY-ggoXY"
         },
         "success": true,
         "message": "daveywas succesfully logged in!",
         "statusCode": 200,
         "errors": [],
         "currentUser": "davey"
     }
    class addFriendModel: Decodable {
        let request_from: String
        let request_to: String
        let add_friend_outcome: Int
        let add_friend_message: String
    }
    
    @IBAction func addFriend(_ sender: UIButton) {

    }
    
    */
    
    

}

