//
//  Networker.swift
//  getImage
//
//  Created by David on 7/4/24.
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
    

    func getImage(from postInputURL: String, completion: @escaping (Data?, Error?) -> (Void)) {
        //let url = URL(string: "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg")!
        let url = URL(string: postInputURL)!
           
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
