//
//  GroupsAPI.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit

/*
FUNCTIONS A: All Functions Related to Groups
    1) Function A1: Create a New Group
    2) Function A2: Invite User to a Group
    3) Function A3: Accept Group Invite
    4) Function A4: Leave a Group
    5) Function A5: Get All Groups User is In
    6) Function A6: Get Single Group by ID
    7) Function A7: Get Group Users
    8) Function A8: Get Group Users by Group ID
*/

class GroupsAPI {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    //FUNCTIONS A: All Functions Related to Groups
    //Function A1: Create a New Group
    func newGroup(currentUser: String, groupName: String, groupType: String, groupPrivate: Int, groupUsers: [String], notificationMessage: String, notificationType: String, notificationLink: String) async throws -> NewGroupResponseModel {
        let masterSite = "kite"
        
        // STEP 1: Create the URL
        let endpoint = "http://localhost:3003/group/create"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        
        // STEP 2: Create the Request
        var request = URLRequest(url: url)
        
        let parameters: [String: Any] = [
            "masterSite": masterSite,
            "currentUser": currentUser,
            "groupName": groupName,
            "groupType": groupType,
            "groupPrivate": groupPrivate,
            "groupUsers": groupUsers,
            "notificationMessage": notificationMessage,
            "notificationType": notificationType,
            "notificationLink": notificationLink
        ]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let groupResponseModel = NewGroupResponseModel()
            print("Error setting JSON")
            return groupResponseModel
        }
        
        request.httpBody = httpBody
        
        // STEP 3: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let newGroupResponseModel = try decoder.decode(NewGroupResponseModel.self, from: data)
            
            print("API Response")
            print(newGroupResponseModel)
            print("API Response")
            return newGroupResponseModel
            
        } catch {
            let newGroupResponseModel = NewGroupResponseModel()
            print("Error decoding data")
            print(newGroupResponseModel)
            return newGroupResponseModel
        }
        
    }

    // Function A2: Create a New Group using multipart/form-data
    func newGroupFormData(currentUser: String, groupName: String, groupImage: UIImage?, groupType: String, groupPrivate: Int, groupUsers: [String], notificationMessage: String, notificationType: String, notificationLink: String) async throws -> NewGroupResponseModel {
        let masterSite = "kite"
        
        // STEP 1: Create the URL
        let endpoint = "http://localhost:3003/group/create"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }

        // STEP 2: Create the Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Helper to append key/value pairs to multipart body
        func appendFormField(name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        // STEP 2.1: Append all fields
        appendFormField(name: "masterSite", value: masterSite)
        appendFormField(name: "currentUser", value: currentUser)
        appendFormField(name: "groupName", value: groupName)
        appendFormField(name: "groupType", value: groupType)
        appendFormField(name: "groupPrivate", value: String(groupPrivate))
        appendFormField(name: "notificationMessage", value: notificationMessage)
        appendFormField(name: "notificationType", value: notificationType)
        appendFormField(name: "notificationLink", value: notificationLink)
        
        // STEP 2.2: Append array of users (repeat key for each user)
        if let jsonData = try? JSONSerialization.data(withJSONObject: groupUsers, options: []),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            appendFormField(name: "groupUsers", value: jsonString)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        // STEP 3: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let newGroupResponseModel = try decoder.decode(NewGroupResponseModel.self, from: data)
            
            print("API Response")
            print(newGroupResponseModel)
            print("API Response")
            return newGroupResponseModel
            
        } catch {
            let newGroupResponseModel = NewGroupResponseModel()
            print("Error decoding data")
            print(newGroupResponseModel)
            return newGroupResponseModel
        }
    }

    
    //Function A2: Get Groups for a User
    func getGroupsAPI(for userName: String) async throws -> GroupsResponseModel {
        let endpoint = "http://localhost:3003/groups/user/\(userName)"
       
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let groupsResponseModel = try decoder.decode(GroupsResponseModel.self, from: data)

            return groupsResponseModel
            
        } catch {
            let groupsResponseModel = GroupsResponseModel()
            print("Error decoding data")
            return groupsResponseModel
            
        }
    }
    
    
    //Function A3: Invite User to a Group
    //Function A4: Accept Group Invite
    //Function A5: Leave a Group
    
    //Function A6: Get All Groups User is In
    func getGroupsUserIsIn() async throws -> UserGroupsResponseModel {
        let endpoint = "http://localhost:3003/groups/user/davey"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let groupResponseModel = try decoder.decode(UserGroupsResponseModel.self, from: data)

            return groupResponseModel
            
        } catch {
            let groupResponseModel = UserGroupsResponseModel()
            print("Error decoding data")
            return groupResponseModel
            
        }
    }
    
    //Function A7: Get Single Group by ID
    //Function A8: Get Group Users
    func getGroupUsers(groupID: String) async throws -> GroupUsersResponseModel {
        let endpoint = "http://localhost:3003/group/users/\(groupID)"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let groupUsersResponseModel = try decoder.decode(GroupUsersResponseModel.self, from: data)

            return groupUsersResponseModel
            
        } catch {
            let groupUsersResponseModel = GroupUsersResponseModel()
            print("Error decoding data")
            return groupUsersResponseModel
            
        }
    }

    

}

