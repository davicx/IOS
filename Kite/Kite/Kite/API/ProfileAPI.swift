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
    2) Function A2: Update User Profile Information without Image
    3) Function A3: Update User Profile Information
    4) Function A4: Get All Your Friends
*/

//Friends
//Friend Requests


class ProfileAPI {
    
    static let shared = Networker()
    let loginAPI = LoginAPI()
    //let authManager = AuthManager()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    //FUNCTIONS A: All Functions Related to User Profile
    //Function A1: Get User Profile Information
    func getUserProfileAPI(currentUser: String) async throws -> UserProfileResponseModel {
        let endpoint = "http://localhost:3003/profile/" + currentUser
        
        //printHeader(headerMessage: "PROFILE API- getUserProfileAPI")
        
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
            //print("PROFILE API - 200 Success")
            let decoder = JSONDecoder ()
            let userProfileResponseModel = try decoder.decode(UserProfileResponseModel.self, from: data)
            
            
            return userProfileResponseModel
            
        case 498:
            print("PROFILE API - 498 Refreshing Token")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)
            
            //Get new token
            if newAccessTokenModel.success == true {
                print("PROFILE API: 498 If Retry")
                
                return try await getUserProfileAPI(currentUser: currentUser)
                
            } else {
                print("PROFILE API: 498 Else logoutCurrentUser because we couldnt get a token")
                let userProfileResponseModel = UserProfileResponseModel()
                
                return userProfileResponseModel
                
            }
            
        case 401:
            print("PROFILE API - 401 Unauthorized, Logging Out")
            let userProfileResponseModel = UserProfileResponseModel()
            return userProfileResponseModel
        default:
            print("PROFILE API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
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
    func updateFullUserProfileAPI(currentUser: String, profileImage: UIImage, firstName: String, lastName: String, biography: String) async throws -> UpdateUserProfileResponseModel {
        print("ProfileAPI updateFullUserProfileAPI")
        
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/profile/full/update/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        //STEP 2: Create the Request
        var request = URLRequest(url: url)
        let boundary = UUID().uuidString
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //STEP 3: Create the Form Data
        let body = NSMutableData()
    
        //Current User
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"currentUser\"\r\n\r\n")
        body.appendString("\(currentUser)\r\n")
            
        if let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"profileImage\"; filename=\"image.jpg\"\r\n")
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.appendString("\r\n")
        }
        
        //First Name
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"firstName\"\r\n\r\n")
        body.appendString("\(firstName)\r\n")
        
        //Last Name
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"lastName\"\r\n\r\n")
        body.appendString("\(lastName)\r\n")
        
        //Biography
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"biography\"\r\n\r\n")
        body.appendString("\(biography)\r\n")

        body.appendString("--\(boundary)--\r\n")
        
        request.httpBody = body as Data
        
        //STEP 4: Handle the Response
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
    

}

