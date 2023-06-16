//
//  GroupTwoAPI.swift
//  QuoteNewGroup
//
//  Created by David on 5/22/23.
//

import Foundation

//Shared Instance so every object can use
class GroupTwoAPI {
    
    static let shared = GroupTwoAPI()
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
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
        
        
       //TYPE 1: This is better it is a Singleton
        let task = session.dataTask(with: request) { (data, response, error) in
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
        task.resume()
        
    }
    
    
    
    /*
     func getQuote(completion: @escaping (Kanye?, Error?) -> (Void)) {
         let url = URL(string: "https://api.kanye.rest/")!
         
         //How to configure for a specific case
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
      
         let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

             if let error = error {
               DispatchQueue.main.async {
                 completion(nil, error)
               }
               return
             }
             
             guard let httpResponse = response as? HTTPURLResponse else {
               DispatchQueue.main.async {
                 completion(nil, NetworkerError.badResponse)
               }
               return
             }
             
             guard (200...299).contains(httpResponse.statusCode) else {
               DispatchQueue.main.async {
                 completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
               }
               return
             }
             
             guard let data = data else {
               DispatchQueue.main.async {
                 completion(nil, NetworkerError.badData)
               }
               return
             }
             
             do {
                 let kanye = try JSONDecoder().decode(Kanye.self, from: data)
                 print(kanye)
                 
                 DispatchQueue.main.async {
                     //Data and Error (nil)
                     completion(kanye, nil)
                 }
             } catch let error {
                 completion(nil, error)
             }

        }
         task.resume()
     }
     
     func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
         let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg/440px-Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg")!
            
            let task = session.downloadTask(with: url) { (localUrl: URL?, response: URLResponse?, error: Error?) in
              
              if let error = error {
                DispatchQueue.main.async {
                  completion(nil, error)
                }
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                  completion(nil, NetworkerError.badResponse)
                }
                return
              }
              
              guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                  completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
                }
                return
              }
              
              guard let localUrl = localUrl else {
                DispatchQueue.main.async {
                  completion(nil, NetworkerError.badData)
                }
                return
              }
              
              do {
                let data = try Data(contentsOf: localUrl)
                DispatchQueue.main.async {
                  completion(data, nil)
                }
              } catch let error {
                DispatchQueue.main.async {
                  completion(nil, error)
                }
              }
            }
            task.resume()
     }
     */
    
    ///
    
    
    
}
