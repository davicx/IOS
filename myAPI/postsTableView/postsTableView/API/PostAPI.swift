//
//  postAPI.swift
//  postsTableView
//
//  Created by David on 6/23/24.
//

import Foundation
 

enum NetworkerError: Error {
  case badResponse
  case badStatusCode(Int)
  case badData
}

                                                                                                                
class PostAPI {

    static let shared = PostAPI()
    
    private let session: URLSession
    
    init() {
      let config = URLSessionConfiguration.default
      session = URLSession(configuration: config)
    }
    
    func getGroupPosts(completion: @escaping (PostResponseModel?, Error?) -> (Void)) {
        let url = URL(string: "http://localhost:3003/posts/group/70")!
        
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
                let postResponseModel = try JSONDecoder().decode(PostResponseModel.self, from: data)
                print(postResponseModel.data[0].postCaption)
         
                DispatchQueue.main.async {
                    //Data and Error (nil)
                    completion(postResponseModel, nil)
                }
            } catch let error {
                completion(nil, error)
            }

       }
        task.resume()
    }
    
    func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
        //let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg/440px-Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg")!
           
        let url = URL(string: "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240623%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240623T002225Z&X-Amz-Expires=3600&X-Amz-Signature=1a1d5d0439e02634e1a5f7fbd844b9233984b932760fdbdd349a535cd03ffcab&X-Amz-SignedHeaders=host&x-id=GetObject")!
           
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
    
  
    
}

