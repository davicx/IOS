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
    func loginUser(username: String, password: String) async throws -> LoginResponseModel {
        
        let endpoint = "http://localhost:3003/user/login"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username, "password": password] as [String : Any]
        
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
            
            return loginResponseModel
            
        } catch {
            let loginResponseModel = LoginResponseModel()
            print("Error decoding data")
            return loginResponseModel
            
        }
    }
    
    //func loginUser(username: String?, email: String?, password: String) -> LoginResponseModel {
    func logoutUser(username: String) async throws -> LogoutResponseModel {
        
        let endpoint = "http://localhost:3003/user/logout"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["userName": username] as [String : Any]
        
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
    
    func getNewAccessToken() {
        print("getNewAccessToken")
    }
    
    
    //TEMP
    /*
     import Foundation

     struct RefreshResponseModel: Codable {
         let accessToken: String
     }

     enum NetworkError: Error {
         case invalidURL
         case invalidResponse
         case decodingError
     }

     func refreshToken() async throws -> RefreshResponseModel {
         print("ATTEMPTING TO REFRESH TOKEN: refreshToken()")
         
         let refreshURL = "http://localhost:3003/refresh/tokens"
         
         guard let url = URL(string: refreshURL) else {
             throw NetworkError.invalidURL
         }
         
         guard let userData = UserDefaults.standard.string(forKey: "localStorageCurrentUser"),
               let userName = try? JSONDecoder().decode(String.self, from: Data(userData.utf8)) else {
             throw NetworkError.invalidResponse
         }
         
         print("refreshToken: you are refreshing for \(userName)")
         
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         let parameters: [String: Any] = [
             "userName": userName,
             "refreshToken": "dontneedheretoken"
         ]
         
         guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
             throw NetworkError.invalidResponse
         }
         
         request.httpBody = httpBody
         
         let (data, response) = try await URLSession.shared.data(for: request)
         
         guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
             throw NetworkError.invalidResponse
         }
         
         do {
             let decoder = JSONDecoder()
             let refreshResponseModel = try decoder.decode(RefreshResponseModel.self, from: data)
             print("refreshToken(): We got a new access token!")
             return refreshResponseModel
         } catch {
             print("refreshToken(): We failed to get a new access token!")
             throw NetworkError.decodingError
         }
     }

     */
    


}
