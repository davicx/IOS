//
//  NetworkManager.swift
//  Kite
//
//  Created by David Vasquez on 2/4/25.
//

import Foundation

//Example
/*
 Task {
     do {
         let userProfile: UserProfileResponseModel = try await NetworkManager.shared.performRequest(
             endpoint: "http://localhost:3003/profile/john_doe"
         )
         print("User Profile: \(userProfile)")
     } catch {
         print("Error fetching profile: \(error)")
     }
 }

 */



import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let loginAPI = LoginAPI() // Ensure you have an instance of `LoginAPI`
    
    private init() {} // Singleton

    func performRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        headers: [String: String] = [:],
        requiresAuth: Bool = true,
        currentUser: String
    ) async throws -> T {
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body

        var finalHeaders = headers
        finalHeaders["Content-Type"] = "application/json"

        for (key, value) in finalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let config = URLSessionConfiguration.default
        config.httpCookieStorage = HTTPCookieStorage.shared
        let session = URLSession(configuration: config)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(T.self, from: data) // Success

        case 498:
            print("Session expired, attempting to refresh access token...")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)

            if newAccessTokenModel.success {
                print("Access token refreshed, retrying request...")
                return try await performRequest(
                    endpoint: endpoint,
                    method: method,
                    body: body,
                    headers: headers,
                    requiresAuth: requiresAuth,
                    currentUser: currentUser // Retry request
                )
            } else {
                print("Failed to refresh token. Logging out user.")
                AuthManager.shared.logoutCurrentUser()
                throw networkError.tokenRefreshFailed
            }

        case 401:
            print("Unauthorized - Logging out user.")
            AuthManager.shared.logoutCurrentUser()
            throw networkError.unauthorized

        default:
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}






/*
 //ORIGINAL
 class NetworkManager {
 static let shared = NetworkManager()
 
 private init() {} // Ensures singleton usage
 
 // Performs an API request while ensuring cookies are used
 func performRequest<T: Decodable>(
 endpoint: String,
 method: String = "GET",
 body: Data? = nil,
 headers: [String: String] = [:],
 requiresAuth: Bool = true
 ) async throws -> T {
 
 guard let url = URL(string: endpoint) else {
 throw networkError.invalidURL
 }
 
 var request = URLRequest(url: url)
 request.httpMethod = method
 request.httpBody = body
 
 // Add default headers
 var finalHeaders = headers
 finalHeaders["Content-Type"] = "application/json"
 
 // Set all headers
 for (key, value) in finalHeaders {
 request.setValue(value, forHTTPHeaderField: key)
 }
 
 //Ensure cookies are included
 let config = URLSessionConfiguration.default
 config.httpCookieStorage = HTTPCookieStorage.shared
 let session = URLSession(configuration: config)
 
 // Perform the request
 let (data, response) = try await session.data(for: request)
 
 guard let httpResponse = response as? HTTPURLResponse else {
 throw networkError.invalidResponse
 }
 
 // Save received cookies
 if let cookies = HTTPCookieStorage.shared.cookies(for: url) {
 for cookie in cookies {
 HTTPCookieStorage.shared.setCookie(cookie)
 }
 }
 
 // Handle HTTP status codes
 switch httpResponse.statusCode {
 case 200...299:
 return try JSONDecoder().decode(T.self, from: data) // Success
 
 case 498:
 print("Session expired, attempting to refresh cookies...")
 if try await refreshSessionCookies() {
 // Retry request after refreshing cookies
 return try await performRequest(
 endpoint: endpoint,
 method: method,
 body: body,
 headers: headers,
 requiresAuth: requiresAuth
 )
 } else {
 throw networkError.tokenRefreshFailed
 }
 
 case 401:
 print("Unauthorized - Logging out user.")
 AuthManager.shared.logoutCurrentUser()
 throw networkError.unauthorized
 
 default:
 throw networkError.serverError(statusCode: httpResponse.statusCode)
 }
 }
 
 //Refreshes the session cookies by making a request to the refresh endpoint
 private func refreshSessionCookies() async throws -> Bool {
 let refreshEndpoint = "http://localhost:3003/auth/refresh"
 guard let url = URL(string: refreshEndpoint) else {
 throw networkError.invalidURL
 }
 
 var request = URLRequest(url: url)
 request.httpMethod = "POST"
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
 let config = URLSessionConfiguration.default
 config.httpCookieStorage = HTTPCookieStorage.shared
 let session = URLSession(configuration: config)
 
 let (data, response) = try await session.data(for: request)
 
 guard let httpResponse = response as? HTTPURLResponse else {
 throw networkError.invalidResponse
 }
 
 if httpResponse.statusCode == 200 {
 print("Cookies refreshed successfully.")
 return true
 } else {
 print("Failed to refresh cookies. Logging out.")
 AuthManager.shared.logoutCurrentUser()
 return false
 }
 }
 
 
 }
 */
