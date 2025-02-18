//
//  LoginAPI.swift
//  Instagram
//
//  Created by David Vasquez on 10/25/24.
//

import UIKit


class LoginAPI {
    
    static let shared = LoginAPI()

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func registerNewUser (username: String, fullName: String, email: String, password: String)  async throws -> RegistrationResponseModel {
        print("Register")
        
        let endpoint = "http://localhost:3003/user/register"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username, "fullName": fullName, "email": email, "password": password] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let registrationResponseModel = RegistrationResponseModel()
            print("Error setting JSON")
            return registrationResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let registrationResponseModel = try decoder.decode(RegistrationResponseModel.self, from: data)
            
            return registrationResponseModel
            
        } catch {
            let registrationResponseModel = RegistrationResponseModel()
            print("Error decoding Registration Response data")
            return registrationResponseModel
            
        }
    }
    
    
    //func loginUser(username: String?, email: String?, password: String) -> LoginResponseModel {
    func loginUser(username: String, password: String, deviceID: String) async throws -> LoginResponseModel {
        
        let endpoint = "http://localhost:3003/user/login"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username, "password": password, "device_id": deviceID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let loginResponseModel = LoginResponseModel()
            print("Error setting JSON")
            return loginResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let loginResponseModel = try decoder.decode(LoginResponseModel.self, from: data)
            print("loginResponseModel")
            print(loginResponseModel)
            print("loginResponseModel")
            
            return loginResponseModel
            
        } catch {
            let loginResponseModel = LoginResponseModel()
            print("Error decoding data")
            return loginResponseModel
            
        }
    }
    
    //func loginUser(username: String?, email: String?, password: String) -> LoginResponseModel {
    func logoutUser(username: String, deviceID: String) async throws -> LogoutResponseModel {
        
        let endpoint = "http://localhost:3003/user/logout"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username, "device_id": deviceID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let logoutResponseModel = LogoutResponseModel()
            print("Error setting JSON")
            return logoutResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
 
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let logoutResponseModel = try decoder.decode(LogoutResponseModel.self, from: data)
            
            return logoutResponseModel
            
        } catch {
            let logoutResponseModel = LogoutResponseModel()
            print("Error decoding data")
            return logoutResponseModel
            
        }
    }
    
    
    func logUserOut() {
        print("logUserOut")
    }
    

    func getNewAccessToken(username: String) async throws -> AccessTokenResponseModel {
        print("___________________________")
        print("getNewAccessToken")

        
        let endpoint = "http://localhost:3003/refresh/tokens"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let accessTokenResponseModel = AccessTokenResponseModel()
            print("Error converting JSON")
            return accessTokenResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("LoginAPI.getNewAccessToken: networkError.invalidResponse")
            throw networkError.invalidResponse
        }
        
        if httpResponse.statusCode == 200 {
            // Continue processing as normal
        } else if httpResponse.statusCode == 498 {
            print("LoginAPI.getNewAccessToken: 498")
        } else if httpResponse.statusCode == 401 {
            print("LoginAPI.getNewAccessToken: 401")
        } else {
            print("LoginAPI.getNewAccessToken: networkError.invalidResponse")
            throw networkError.invalidResponse
        }

        
        do {
            let decoder = JSONDecoder ()
            let accessTokenResponseModel = try decoder.decode(AccessTokenResponseModel.self, from: data)
            print(accessTokenResponseModel.message)
            print("getNewAccessToken")
            print("___________________________")
            return accessTokenResponseModel
            
        } catch {
            let accessTokenResponseModel = AccessTokenResponseModel()
            print("Error decoding data")
            print("getNewAccessToken")
            print("___________________________")
            return accessTokenResponseModel
            
        }

    }
    

}


//REQUEST
/*
let loginAPI = LoginAPI()
 
Task{
    do{
        let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
        print(newAccessTokenModel)
    } catch{
        print("ProfileViewController profileAPI.getUserProfileAPI yo man error!")
        print(error)
    }
}
 */
