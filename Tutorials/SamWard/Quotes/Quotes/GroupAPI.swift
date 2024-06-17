//
//  Networker.swift
//  Quotes
//
//  Created by David on 4/19/23.
//

import Foundation
 

enum NetworkerErrors: Error {
  case badResponse
  case badStatusCode(Int)
  case badData
}

                                                                                                                
class GroupAPI {

    static let shared = GroupAPI()
    
    private let sessionAPI: URLSession
    
    init() {
      let config = URLSessionConfiguration.default
      sessionAPI = URLSession(configuration: config)
    }
    

    func newGroup(completion: @escaping (NewGroupModel?, Error?) -> (Void)) {

     
     guard let urlString = URL(string: "http://localhost:3003/group/create/") else { return }
     
     //let body : [String:Any] = ["id": userID, "name": userName, "contactInfo": contactInfo, "message": message
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
     
     //let session = URLSession.shared
        sessionAPI.dataTask(with: request) { (data, response, error) in
         if let data = data {
             do {
                 print(response)
                 let newGroupResponse = try JSONDecoder().decode(NewGroupModel.self, from: data)
                 print(newGroupResponse)
                 
                 DispatchQueue.main.async {
                     //Data and Error (nil)
                     completion(newGroupResponse, nil)
                 }
             } catch {
                 print(error)
             }
         }
         
         }.resume()
     

    
    }
    
    
    
    
    
}
