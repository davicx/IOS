//
//  GroupAPI.swift
//  QuoteNewGroup
//
//  Created by David on 5/15/23.
//

import Foundation

enum NetworkerError: Error {
  case badResponse
  case badStatusCode(Int)
  case badData
}

class GroupAPI {
    func createNewGroup(completion: @escaping (NewGroupModel?, Error?) -> (Void)) {
        guard let urlString = URL(string: "http://localhost:3003/group/create/") else { return }
        
        let parameters : [String:Any] = [
            "currentUser": "davey",
            "groupName": "music!",
            "groupType": "kite",
            "groupPrivate": 1,
            "groupUsers": ["davey", "sam", "frodo", "merry"],
            "notificationMessage": "Invited you to a new Group",
            "notificationType": "group_invite",
            "notificationLink": "http://localhost:3003/group/77"
        ]
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        
       //TYPE 1: This is better
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
              print("not right httpResponse")
              completion(nil, NetworkerError.badResponse)
              return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
              print("Not right 200...299")
             completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
              return
            }
            
            guard let data = data else {
              print("bad data")
              completion(nil, NetworkerError.badData)
              return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Int]
                let newGroupResponse = try JSONDecoder().decode(NewGroupModel.self, from: data)
                let groupMembers = newGroupResponse.groupData.groupMembers
                let pendingGroupMembers = newGroupResponse.groupData.pendingGroupMembers
                
                print("API GROUP")
                print(newGroupResponse.message)
                print(groupMembers)
                print(pendingGroupMembers)
                print("___________")
        
                DispatchQueue.main.async {
                    //self.label.text = json["quote"]
                    completion(newGroupResponse, nil)
                }
            } catch let error {
                completion(nil, error)
                print(error)
            }

       }
        session.resume()
        
        //let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        
        //TYPE 2: This is a singleton that any part of the application can use
        /*
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
              print("not right httpResponse")
              completion(nil, NetworkerError.badResponse)
              return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
              print("Not right 200...299")
             completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
              return
            }
            
            guard let data = data else {
              print("bad data")
              completion(nil, NetworkerError.badData)
              return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Int]
                let newGroupResponse = try JSONDecoder().decode(NewGroupModel.self, from: data)
                let groupMembers = newGroupResponse.groupData.groupMembers
                let pendingGroupMembers = newGroupResponse.groupData.pendingGroupMembers
                
                print("API GROUP")
                print(newGroupResponse.message)
                print(groupMembers)
                print(pendingGroupMembers)
                print("___________")
        
                DispatchQueue.main.async {
                    //self.label.text = json["quote"]
                    completion(newGroupResponse, nil)
                }
            } catch let error {
                completion(nil, error)
                print(error)
            }

       }
        session.resume()
         */
    }
    
}
