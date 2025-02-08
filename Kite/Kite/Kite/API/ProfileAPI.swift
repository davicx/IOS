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
        
        printHeader(headerMessage: "PROFILE API- getUserProfileAPI")

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
            print("PROFILE API - 200 Success")
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
        
        printFooter()

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
    func updateFullUserProfileAPI(currentUser: String, newProfileImage: UIImage, imageName: String, firstName: String, lastName: String, biography: String) async throws -> UpdateUserProfileResponseModel {
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
    
}






//WORKS
/*
if httpResponse.statusCode == 200 {
    print("PROFILE API- 200")

} else if httpResponse.statusCode == 498 {
    print("PROFILE API: 498 If Retry")
    let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
    print(newAccessTokenModel.message)
    
} else if httpResponse.statusCode == 401 {
    print("PROFILE API: 401 logoutCurrentUser")
    //AuthManager.shared.logoutCurrentUser()
} else {
    print("PROFILE API: ELSE networkError.invalidResponse")
    throw networkError.invalidResponse
}
 */
/*
if httpResponse.statusCode == 200 {
    print("PROFILE API- 200")
    // Continue processing as normal
} else if httpResponse.statusCode == 498 {
    print("PROFILE API: 498")
    let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
    print(newAccessTokenModel)
    
    if newAccessTokenModel.success == true {
        print("PROFILE API: 498 If Retry")
        //RETRY getUserProfileAPI Request Here
        return try await getUserProfileAPI(currentUser: currentUser)
    } else {
        print("PROFILE API: 498 Else logoutCurrentUser")
        AuthManager.shared.logoutCurrentUser()
    }
    
} else if httpResponse.statusCode == 401 {
    print("PROFILE API: 401 logoutCurrentUser")
    AuthManager.shared.logoutCurrentUser()
} else {
    print("PROFILE API: 401 invalidResponse")
    throw networkError.invalidResponse
}


do {
    let decoder = JSONDecoder ()
    let userProfileResponseModel = try decoder.decode(UserProfileResponseModel.self, from: data)

    return userProfileResponseModel
    
} catch {
    let userProfileResponseModel = UserProfileResponseModel()
    //print("CATCH: Going to use empty response data")
    return userProfileResponseModel
    
}
 */




//NEW
//let accessTokenResponse = try await loginAPI.getNewAccessToken(username: currentUser)
//print(accessTokenResponse)
//NEW
//Logout User AuthManager.shared.logoutCurrentUser()

/*
 func getUserProfileAPITEMP(currentUser: String) async throws -> UserProfileResponseModel {
     let endpoint = "http://localhost:3003/profile/" + currentUser
     print("______________________________")
     print("PROFILE API - getUserProfileAPI")
     
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
         print("PROFILE API - 200 Success")
         do {
             return try JSONDecoder().decode(UserProfileResponseModel.self, from: data)
         } catch {
             print("PROFILE API - Decoding Error:", error)
             throw networkError.decodingError
         }

     case 498:
         print("PROFILE API - 498 Refreshing Token")
         let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)

         if newAccessTokenModel.success {
             print("PROFILE API - 498 Retry Request")
             return try await getUserProfileAPI(currentUser: currentUser)
         } else {
             print("PROFILE API - 498 Refresh Failed, Logging Out")
             AuthManager.shared.logoutCurrentUser()
             throw networkError.tokenRefreshFailed
         }

     case 401:
         print("PROFILE API - 401 Unauthorized, Logging Out")
         AuthManager.shared.logoutCurrentUser()
         throw networkError.unauthorized

     default:
         print("PROFILE API - Unexpected Status Code: \(httpResponse.statusCode)")
         throw networkError.serverError(statusCode: httpResponse.statusCode)
     }
 }

 */
