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
        let url = URL(string: "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717890765111-678334753-stars.jpg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjELD%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMiJHMEUCIQCCie39FBZMZ7D8QchHKpsaz3q7Il%2BB5mdadvS5SjvRJgIgcU9QAV1C2HNCbax8vm0V%2Fe4O4Bn6r56rPW%2BflZoGRtcq5AIIaRAAGgw1MzQ3NTMzNjk4NTAiDOr%2BJf6vl5NgR64msCrBAljBfZodNGY7mknZlvPbACk%2BWNwaOgmnK3FFjHDUNtUhe1u9lS5rQnTwim0i4do790ZJsedwXOBgprRAWYKFywdCPY523yFMjq2dbffQKhyzfYoG%2BQimoe2c%2FeBiX24dT07WlI4qQ%2Fj9Yk%2BtZRSUeUCffJyQs%2FqmMD3EmSvW4LfRtjXvExyB%2Bjxza3zJUi6Jce3YD78KWyB52x82qaDXfT8mWTNZMursj7aVCzoYp0mwIOXfimgcIUpB1PYIi7CGdTdILh74Zg9NzmSBXpEl7UsuQo5PDE3GrRTYCHJi%2B80Kbq6p6p%2BNRbasmZtmaCzZcnUuVqQMhUxpYx%2BuqdJNcNxZ3vnOTc0hwYycBCYNulUYIz%2FsMrsh3GgCES2lk34kn8nVACpCZ9uaf4C%2FkfklpfMiFIKd2aKaGqBZcqmctlIE6TD39Iy0BjqzAqX9TzAyHeMcOOXc0YVqTjnEIxHAq1bi3fzWTnklD0OQfwzfwzsXu25y42xUnIVREJJGcwtrDkx4qlI%2Bzxad1G20FzRKOrgzdYB0FeO0wuM1tRS5TW1dR8TPdXlohFMWyON5QZCxd57e3apAcGjCamX3iWgnphSBxJOPHSGQSEoWXWzniIZW8F9Qt3IZ%2BPQyVRxE1eweH0zzcBJfsG1avpDqOmRQOs62PnPjX%2BIXcI8SBWUr6Lg%2FIck3U%2Bc%2Bwwl3kLagHINNyj1p%2FYjuCcmaK5DMZhSSdHFenLqCIULd3LCiAX9wFmvWok8TX9qfbNpPtffFMjhLfEtVDqW9gOD47ipm26zt4W1sqLdBbcxxMOiGUMMA2ZLjOAHX57h9SkSoVPkICdD5IFd%2Bxp1DnlhkIYqWoEg%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240701T232409Z&X-Amz-SignedHeaders=host&X-Amz-Expires=14400&X-Amz-Credential=ASIAXZAOI335B73FUW7M%2F20240701%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=e8acc6cf2698e40f2312458d6c4090d74f6f803df4d2f41f741c770edf893f9d")!
           
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
