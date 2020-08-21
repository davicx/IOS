//
//  Functions.swift
//  getFriends
//
//  Created by David Vasquez on 8/10/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

func getUserFriends(userName: String, completionHandler:@escaping (Array<Friend>, Error?)->Void ) {
//func getUserFriends(userName: String) -> Array<Friend> {
    
    var friendsArray: [Friend] = []
    
    //Get Friends
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
                     currentFriend.userName = friend.friend_user_name
                    friendsArray.append(currentFriend)
                    //print(currentFriend.userName)
                }
                completionHandler(friendsArray, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
    //print("Return Friends \(friendsArray)")
  
}


/*
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
