//
//  Networker.swift
//  Quotes
//
//  Created by David on 4/19/23.
//

import Foundation
 

enum NetworkerErrorFull: Error {
  case badResponse
  case badStatusCode(Int)
  case badData
}

                                                                                                                
class NetworkerFull {

    static let shared = NetworkerFull()
    
    private let session: URLSession
    
    init() {
      let config = URLSessionConfiguration.default
      session = URLSession(configuration: config)
    }
    
    //This is running on main queue but can also run on View Controller In real application want to create your own instance of a URL Session
    func getQuote(completion: @escaping (Kanye?, Error?) -> (Void)) {
        let url = URL(string: "https://api.kanye.rest/")!
        
        //How to configure for a specific case
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //session.downloadTask(with: <#T##URLRequest#>)
        //session.uploadTask(with: <#T##URLRequest#>, from: <#T##Data#>)
        //session.webSocketTask(with: <#T##URL#>)
        
        
        //This is so we dont use the shared one
        //Can configure timeouts, caching, etc
        //let config = URLSessionConfiguration.default
        //let session = URLSession(configuration: config)
        //URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue?)
         
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
              DispatchQueue.main.async {
                completion(nil, error)
              }
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
              DispatchQueue.main.async {
                completion(nil, NetworkerErrorFull.badResponse)
              }
              return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
              DispatchQueue.main.async {
                completion(nil, NetworkerErrorFull.badStatusCode(httpResponse.statusCode))
              }
              return
            }
            
            guard let data = data else {
              DispatchQueue.main.async {
                completion(nil, NetworkerErrorFull.badData)
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
    
    //This is running on main queue but can also run on View Controller
    //In real application want to create your own instance of a URL Session this is using shared
    func getQuoteSimple(completion: @escaping (Kanye?, Error?) -> (Void)) {
        let url = URL(string: "https://api.kanye.rest/")!
         
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

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
    
    
    
    
    
}
/*
 
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
     
     var request = URLRequest(url: url)
     request.httpMethod = "GET"
     
     let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
       
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
         DispatchQueue.main.async {
           completion(kanye, nil)
         }
       } catch let error {
         DispatchQueue.main.async {
           completion(nil, error)
         }
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
   
 }
 */
