//
//  PostsAPI.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/13/24.
//

import Foundation


class PostsAPI {
    

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    //FUNCTIONS
    //Function A1: Get Posts for a Group
    func getPostsAPI() async throws -> [PostModel] {
        let endpoint = "http://localhost:3003/simple/pagination/1"
        
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
            let postResponseModel = try decoder.decode([PostModel].self, from: data)

            return postResponseModel
            
        } catch {
            let postResponseModel = PostModel(postID: 0, postCaption: "error")
            print("Error decoding data")
            return [postResponseModel]
            
        }
    }


}

