//
//  Networker.swift
//  Quotes
//
//  Created by David on 4/19/23.
//

import Foundation
 

enum NetworkerError: Error {
  case badResponse
  case badStatusCode(Int)
  case badData
}

                                                                                                                
class Networker {

    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
      let config = URLSessionConfiguration.default
      session = URLSession(configuration: config)
    }
    
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
    
    func newGroup(completion: @escaping (NewGroupModel?, Error?) -> (Void)) {
        let url = URL(string: "http://localhost:3003/group/create/")!
        
        //How to configure for a specific case
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
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        /*

         var request = URLRequest(url: urlString)
         request.httpMethod = "POST"
         */
     
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
              DispatchQueue.main.async {
                  print(error)
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
                  print(httpResponse.statusCode)
                completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
              }
              return
            }
            
            guard let data = data else {
              DispatchQueue.main.async {
                  print(NetworkerError.badData)
                completion(nil, NetworkerError.badData)
              }
              return
            }
            
            do {
                let newGroup = try JSONDecoder().decode(NewGroupModel.self, from: data)
                print(newGroup)
                
                DispatchQueue.main.async {
                    //Data and Error (nil)
                    completion(newGroup, nil)
                }
                
            } catch let error {
                print(error)
                completion(nil, error)
            }

       }
        task.resume()
    /*
     
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
     
     let session = URLSession.shared
     session.dataTask(with: request) { (data, response, error) in
         if let data = data {
             do {
                 print(response)
                 //let loginUserResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                 //print(loginUserResponse)
             } catch {
                 print(error)
             }
         }
         
         }.resume()
     */

    
    }
    
    
    
    
    
}