//
//  ProfileAPI.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import UIKit

/*
FUNCTIONS A: All Functions Related to User Profile
    1) Function A1: Get User Profile Information
    2) Function A2: Update User Profile Information
*/

class ProfileAPI {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    //FUNCTIONS A: All Functions Related to User Profile
    //Function A1: Get User Profile Information
    func getUserProfileAPI(currentUser: String) async throws -> UserProfileResponseModel {
        let endpoint = "http://localhost:3003/profile/" + currentUser
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
        
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        print("Get User Profile Response \(httpResponse.statusCode)")

        if httpResponse.statusCode == 200 {
            // Continue processing as normal
        } else if httpResponse.statusCode == 401 {
            logUserOut()
        } else if httpResponse.statusCode == 498 {
            getNewAccessToken()
        } else {
            throw networkError.invalidResponse
        }


        
        do {
            let decoder = JSONDecoder ()
            let userProfileResponseModel = try decoder.decode(UserProfileResponseModel.self, from: data)

            return userProfileResponseModel
            
        } catch {
            let userProfileResponseModel = UserProfileResponseModel()
            print("CATCH: Going to use empty response data")
            return userProfileResponseModel
            
        }
    }


    //Function A2: Update User Profile Information without Image
    func updateUserProfileAPI(currentUser: String, imageName: String, firstName: String, lastName: String, biography: String) async throws -> UpdateUserProfileResponseModel {
        let endpoint = "http://localhost:3003/profile/update"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        
        var request = URLRequest(url: url)

       let parameters = ["currentUser": currentUser, "imageName": imageName, "firstName": firstName, "lastName": lastName, "biography": biography] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let updateProfileResponseModel = UpdateUserProfileResponseModel()
            print("Error setting JSON")
            return updateProfileResponseModel
        }
        
        request.httpBody = httpBody
      
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let updateProfileResponseModel = try decoder.decode(UpdateUserProfileResponseModel.self, from: data)

            return updateProfileResponseModel
            
        } catch {
            let updateProfileResponseModel = UpdateUserProfileResponseModel()
            print("Error decoding data")
            return updateProfileResponseModel
            
        }
    }
    
    //Function A3: Update User Profile Information
    func updateFullUserProfileAPI(currentUser: String, imageName: String, firstName: String, lastName: String, biography: String) async throws -> UpdateUserProfileResponseModel {
        let endpoint = "http://localhost:3003/profile/update"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)

       let parameters = ["currentUser": currentUser, "imageName": imageName, "firstName": firstName, "lastName": lastName, "biography": biography] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let updateProfileResponseModel = UpdateUserProfileResponseModel()
            print("Error setting JSON")
            return updateProfileResponseModel
        }
        
        request.httpBody = httpBody
      
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let updateProfileResponseModel = try decoder.decode(UpdateUserProfileResponseModel.self, from: data)

            return updateProfileResponseModel
            
        } catch {
            let updateProfileResponseModel = UpdateUserProfileResponseModel()
            print("Error decoding data")
            return updateProfileResponseModel
            
        }
    }
    

    
    func logUserOut() {
        print("logUserOut")
    }
    
    func getNewAccessToken() {
        print("getNewAccessToken")
    }
}






/*

 */
