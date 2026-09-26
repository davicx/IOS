//
//  PostsAPI.swift
//  Instagram
//
//  Created by David Vasquez on 10/20/24.
//


import UIKit


class PostsAPI {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    //FUNCTIONS
    //Function A1: Get Posts for a Group
    func getPostsAPI() async throws -> PostResponseModel {
        let endpoint = "http://localhost:3003/posts/group/72"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postResponseModel = try decoder.decode(PostResponseModel.self, from: data)

            return postResponseModel
            
        } catch {
            let postResponseModel = PostResponseModel()
            print("Error decoding data")
            return postResponseModel
            
        }
    }
    
    //Function A2: Download Image
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    
    //Function A3: Like a Post
    func likePostAPI(currentUser: String, postID: Int, groupID: Int) async throws -> LikePostResponseModel {
        let endpoint = "http://localhost:3003/post/like"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
       
        //Not sure what to use
        //let parameters = ["currentUser": "davey", "postID": 72, "groupID": 72] as [String : Any]
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
    
    
    //Function A3: UnLike a Post
    func unlikePostAPI(currentUser: String, postID: Int, groupID: Int) async throws -> LikePostResponseModel {
        let endpoint = "http://localhost:3003/post/unlike"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
       
        //Not sure what to use
        //let parameters = ["currentUser": "davey", "postID": 72, "groupID": 72] as [String : Any]
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

