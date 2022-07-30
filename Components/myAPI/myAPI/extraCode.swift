//
//  extraCode.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/25/22.
//

import Foundation

//
//  PostResponseModel.swift
//  makePostText
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/7/21.
//

/*
let token = "here is the token"
let url = URL(string: "https://mypostrequestdestination.com/api/")!

// prepare json data
let json: [String: Any] = ["State": 1]

let jsonData = try? JSONSerialization.data(withJSONObject: json)

// create post request
var request = URLRequest(url: url)
request.httpMethod = "POST"

// insert json data to the request
request.httpBody = jsonData
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")
request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
    }
    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
    if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
    }
}

task.resume()
*/

/*
import Foundation

struct PostResponseModel: Codable {
    var outcome:Int = 0
    var postID:Int = 0
    var errors:Array = ["worky"]
}

//
//  ViewController.swift
//  makePostText
//
//  Created by Vasquez, Charles Geoffrey David [C] on 12/7/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postTextField: UITextView!

    override func viewDidLoad() {
        
    }


    @IBAction func makePostButton(_ sender: Any) {
        let postCaption = postTextField.text!
        makePost(postCaption: postCaption)
        print(postCaption);
    }
    
    //func getPosts(groupID: Int)
    func makePost(postCaption: String){
        let parameters = [
            "postType": "text",
            "postStatus": "1",
            "groupID": "72",
            "postFrom": "davey",
            "postTo": "sam",
            "postCaption": postCaption,
            "notificationMessage": "Posted a Message",
            "notificationType": "new_post_text",
            "notificationLink": "http://localhost:3003/posts/group/72"
        ]
        
        guard let url = URL(string: "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/post/text") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                    print(postResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
         
    }
        
}


*/

/*

//Function 1: Get Simple Posts (GET)
func getPostsNotSure() {
    let urlString = "http://localhost:3003/posts/simple"
    let url = URL(string: urlString)
    
    guard url != nil else {
        return
    }
   
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
        
        //Parse JSON
        if error == nil && data != nil {
            //let decoder = JSONDecoder()

            do {
                //let postList = try decoder.decode(PostModel.self, from: data!)
                let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
                print(postArray[0].userName)
                print(postArray[1])

            } catch {
                print("Error Parsing JSON")
                
            }
        }
        
    }
    dataTask.resume()
}

*/
