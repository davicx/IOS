//
//  ViewController.swift
//  simpleMakePost
//
//  Created by Syngenta on 7/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makePost()
    }

    func makePost() {
        let parameters = ["postFrom": "davey", "postTo": "sam", "postCaption": "Hiya Sam, wanna garden!"]
        
        guard let url = URL(string: "http://hellofour-env.eba-mymqvrea.us-west-2.elasticbeanstalk.com/post") else { return }
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



/*
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
 */


/*
 
 posts [
     {
        postID
        postFrom
        postTo
        postCaption
     }
 ]


func getUserFriends(userName: String, completionHandler:@escaping (Array<Friend>, Error?)->Void ) {
//func getUserFriends(userName: String) -> Array<Friend> {
    
    var friendsArray: [Friend] = []
    
    //Get Friends
    //var userName = "vasquezd"
    let parameters = ["user_name": userName, "user_key": userName]
    
    guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/friends/get_friends.php?user_name=vasquezd") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                friendsArray.removeAll()
                let friendModelArray = try JSONDecoder().decode([FriendModel].self, from: data)
                
                for friend in friendModelArray{
                    let currentFriend = Friend(userName: friend.friend_user_name)
                    currentFriend.userImage = friend.user_image
                    currentFriend.firstName = friend.first_name
                    currentFriend.lastName = friend.last_name
                    friendsArray.append(currentFriend)
                    print(currentFriend.userName)
                }
                completionHandler(friendsArray, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
    //print("Return Friends \(friendsArray)")
  
}



func getPosts(completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    //func getPosts(tempInput: String, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let parameters = ["user_name": "vasquezd", "user_key": "vasquezd"]
    
    guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/post/get_user_posts.php") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                
                let postModelArray = try JSONDecoder().decode([PostModel].self, from: data)
                completionHandler(postModelArray, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
}
*/

