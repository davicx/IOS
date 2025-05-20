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
