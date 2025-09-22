//
//  SearchAPI.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import UIKit


class SearchAPI {
    
    static let shared = SearchAPI()

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func searchFriends(username: String, searchString: String) async throws -> FriendSearchResponseModel {
        print("Search Friends")
        
        let endpoint = "http://localhost:3003/search/user/\(username)/string/\(searchString)/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let friendSearchResponseModel = try decoder.decode(FriendSearchResponseModel.self, from: data)
            
            return friendSearchResponseModel
            
        } catch {
            let friendSearchResponseModel = FriendSearchResponseModel()
            print("Error decoding Friend Search Response data")
            return friendSearchResponseModel
        }
    }
}