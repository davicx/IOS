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
        //let url = URL(string: "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg")!
        let url = URL(string: "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240704%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240704T220000Z&X-Amz-Expires=3600&X-Amz-Signature=9c76d5df6edc245ebc60bb27b806d982fceacf0324850bcc14333cf446e31b4b&X-Amz-SignedHeaders=host&x-id=GetObject")!
           
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
