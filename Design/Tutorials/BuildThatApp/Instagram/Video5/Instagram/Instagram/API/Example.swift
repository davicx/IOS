//
//  Example.swift
//  Instagram
//
//  Created by David Vasquez on 10/26/24.
//


import UIKit


class Example {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    //FUNCTIONS
    //Function A1: Like a Post (POST Request)
    func likePostAPI(currentUser: String, postID: Int, groupID: Int) async throws -> LikePostResponseModel {
        let endpoint = "http://localhost:3003/post/like"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
       
        let parameters = ["currentUser": currentUser, "postID": postID, "groupID": groupID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let postResponseModel = LikePostResponseModel()
            print("Error setting JSON")
            return postResponseModel
        }
        
        request.httpBody = httpBody
      
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postResponseModel = try decoder.decode(LikePostResponseModel.self, from: data)

            return postResponseModel
            
        } catch {
            let postResponseModel = LikePostResponseModel()
            print("Error decoding data")
            return postResponseModel
            
        }
    }
    
    
}

