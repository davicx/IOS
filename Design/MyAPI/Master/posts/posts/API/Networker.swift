//
//  Networker.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/11/24.
//

import Foundation


                                                                                                                
class Networker {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func getPostsAPI() async throws -> PostResponseModel {
        //let endpoint = "http://localhost:3003/posts/group/72"
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
    
}

