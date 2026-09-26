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
    
    
}
