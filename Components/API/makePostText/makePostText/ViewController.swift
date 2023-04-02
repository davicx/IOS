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

