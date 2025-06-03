//
//  FriendAPI.swift
//  Kite
//
//  Created by David Vasquez on 5/23/25.
//

import UIKit


class FriendAPI {
    
    static let shared = Networker()
    let loginAPI = LoginAPI()

    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func acceptFriendInvite(masterSite: String, currentUser: String, friendName: String) async throws -> AcceptFriendResponseModel {
        let endpoint = "http://localhost:3003/friend/accept/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "friendName": friendName
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(AcceptFriendResponseModel.self, from: data)
            return responseModel

        case 498:
            print("FRIEND API - 498 Refreshing Token (Accept Friend)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)

            if newAccessTokenModel.success {
                print("FRIEND API: 498 If Retry (Accept Friend)")
                return try await acceptFriendInvite(masterSite: masterSite, currentUser: currentUser, friendName: friendName)
            } else {
                print("FRIEND API: 498 Else logoutCurrentUser")
                return AcceptFriendResponseModel()
            }

        case 401:
            print("FRIEND API - 401 Unauthorized, Logging Out (Accept Friend)")
            return AcceptFriendResponseModel()

        default:
            print("FRIEND API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }

    
    
    /*
    func declineFriendInvite(masterSite: String, currentUser: String, friendName: String) async throws -> DeclineFriendResponseModel {
        let endpoint = "http://localhost:3003/friend/decline/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "friendName": friendName
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(DeclineFriendResponseModel.self, from: data)
            return responseModel

        case 498:
            print("FRIEND API - 498 Refreshing Token (Decline Friend)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)

            if newAccessTokenModel.success {
                print("FRIEND API: 498 If Retry (Decline Friend)")
                return try await declineFriendInvite(masterSite: masterSite, currentUser: currentUser, friendName: friendName)
            } else {
                print("FRIEND API: 498 Else logoutCurrentUser")
                return DeclineFriendResponseModel()
            }

        case 401:
            print("FRIEND API - 401 Unauthorized, Logging Out (Decline Friend)")
            return DeclineFriendResponseModel()

        default:
            print("FRIEND API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
     */
    
    // Function A6: Add Friend
    func addFriend(masterSite: String, currentUser: String, addFriendName: String) async throws -> AddFriendResponseModel {
        let endpoint = "http://localhost:3003/friend/request/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "addFriendName": addFriendName
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(AddFriendResponseModel.self, from: data)
            return responseModel

        case 498:
            print("FRIEND API - 498 Refreshing Token (Add Friend)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)

            if newAccessTokenModel.success {
                print("FRIEND API: 498 If Retry (Add Friend)")
                return try await addFriend(masterSite: masterSite, currentUser: currentUser, addFriendName: addFriendName)
            } else {
                print("FRIEND API: 498 Else logoutCurrentUser")
                return AddFriendResponseModel()
            }

        case 401:
            print("FRIEND API - 401 Unauthorized, Logging Out (Add Friend)")
            return AddFriendResponseModel()

        default:
            print("FRIEND API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }

    // Function A7: Remove Friend
    func removeFriend(masterSite: String, currentUser: String, removeFriendName: String) async throws -> RemoveFriendResponseModel {
        let endpoint = "http://localhost:3003/friend/remove/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "removeFriendName": removeFriendName
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(RemoveFriendResponseModel.self, from: data)
            return responseModel

        case 498:
            print("FRIEND API - 498 Refreshing Token (Remove Friend)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)

            if newAccessTokenModel.success {
                print("FRIEND API: 498 If Retry (Remove Friend)")
                return try await removeFriend(masterSite: masterSite, currentUser: currentUser, removeFriendName: removeFriendName)
            } else {
                print("FRIEND API: 498 Else logoutCurrentUser")
                return RemoveFriendResponseModel()
            }

        case 401:
            print("FRIEND API - 401 Unauthorized, Logging Out (Remove Friend)")
            return RemoveFriendResponseModel()

        default:
            print("FRIEND API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }

    
    //Function: Cancel Friend Request
    func cancelFriendRequest(masterSite: String, currentUser: String, friendName: String) async throws -> CancelFriendRequestResponseModel {
        let endpoint = "http://localhost:3003/friend/cancel/"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "friendName": friendName
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(CancelFriendRequestResponseModel.self, from: data)
            return responseModel

        case 498:
            print("FRIEND API - 498 Refreshing Token (Cancel Friend Request)")
            let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
            print(newAccessTokenModel.message)

            if newAccessTokenModel.success {
                print("FRIEND API: 498 If Retry (Cancel Friend Request)")
                return try await cancelFriendRequest(masterSite: masterSite, currentUser: currentUser, friendName: friendName)
            } else {
                print("FRIEND API: 498 Else logoutCurrentUser")
                return CancelFriendRequestResponseModel()
            }

        case 401:
            print("FRIEND API - 401 Unauthorized, Logging Out (Cancel Friend Request)")
            return CancelFriendRequestResponseModel()

        default:
            print("FRIEND API - Unexpected Status Code: \(httpResponse.statusCode)")
            throw networkError.serverError(statusCode: httpResponse.statusCode)
        }
    }



    
    // Function A4: Get All Your Friends
    func getAllCurrentUserFriends(currentUser: String) async throws -> FriendListResponseModel {
        let endpoint = "http://localhost:3003/friends/all/" + currentUser
        
        //printHeader(headerMessage: "PROFILE API - getAllCurrentUserFriends")
        
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
            //print("PROFILE API - 200 Success (Friends List)")
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
            //print("PROFILE API - 200 Success (Friends List)")
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
    

    func convertToFriendObjects(from models: [FriendModel]) -> [Friend] {
        return models.map { Friend(from: $0) }
    }

    

}




