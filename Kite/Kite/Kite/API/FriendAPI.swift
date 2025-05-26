//
//  FriendAPI.swift
//  Kite
//
//  Created by David Vasquez on 5/23/25.
//

import Foundation


class FriendAPI {
    
    static let shared = Networker()
    let loginAPI = LoginAPI()

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    // Function A4: Get All Your Friends
    func getAllCurrentUserFriends(currentUser: String) async throws -> FriendListResponseModel {
        let endpoint = "http://localhost:3003/friends/all/" + currentUser
        
        printHeader(headerMessage: "PROFILE API - getAllCurrentUserFriends")
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            print("PROFILE API - 200 Success (Friends List)")
            let decoder = JSONDecoder()
            let friendsResponse = try decoder.decode(FriendListResponseModel.self, from: data)
            return friendsResponse
            
        case 498:
            print("PROFILE API - 498 Refreshing Token (Friends List)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)
            
            if newAccessTokenModel.success {
                print("PROFILE API: 498 If Retry (Friends List)")
                return try await getAllCurrentUserFriends(currentUser: currentUser)
            } else {
                print("PROFILE API: 498 Else logoutCurrentUser")
                return FriendListResponseModel()
            }
            
        case 401:
            print("PROFILE API - 401 Unauthorized, Logging Out (Friends List)")
            return FriendListResponseModel()
            
        default:
            print("PROFILE API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
        
    }
    
    // Function A5: Get Another Users Friends
    func getOtherUserFriends(otherUser: String, currentUser: String) async throws -> FriendListResponseModel {
        //let endpoint = "http://localhost:3003/friends/all/" + currentUser
        let endpoint = "http://localhost:3003/friend/" + otherUser + "/user/" + currentUser
 
        printHeader(headerMessage: "PROFILE API - getOtherUserFriends")
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            print("PROFILE API - 200 Success (Friends List)")
            let decoder = JSONDecoder()
            let friendsResponse = try decoder.decode(FriendListResponseModel.self, from: data)
            return friendsResponse
            
        case 498:
            print("PROFILE API - 498 Refreshing Token (Friends List)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)
            
            if newAccessTokenModel.success {
                print("PROFILE API: 498 If Retry (Friends List)")
                return try await getAllCurrentUserFriends(currentUser: currentUser)
            } else {
                print("PROFILE API: 498 Else logoutCurrentUser")
                return FriendListResponseModel()
            }
            
        case 401:
            print("PROFILE API - 401 Unauthorized, Logging Out (Friends List)")
            return FriendListResponseModel()
            
        default:
            print("PROFILE API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
        
    }
    
    func convertToFriendObjects(from models: [FriendModel]) -> [Friend] {
        return models.map { Friend(from: $0) }
    }


}




