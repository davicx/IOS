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
        
        /*
         guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
             let groupResponseModel = NewGroupResponseModel()
             print("Error setting JSON")
             return groupResponseModel
         }
         */
        
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
        
        /*
         
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
         */
    }

    /*
    func newPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
        let postType = "text"
        let masterSite = "kite"
        let notificationMessage = "Posted Text"
        let notificationType = "new_post_text"
        let notificationLink = "http://localhost:3003/post/text"
        
            
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/post/text"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        //STEP 2: Create the Request
        var request = URLRequest(url: url)
        
        let parameters = ["masterSite": masterSite, "postType": postType, "postFrom": postFrom, "postTo": postTo, "groupID": groupID, "listID": listID, "postCaption": postCaption, "videoURL": "", "notificationMessage": notificationMessage, "notificationType": notificationType, "notificationLink": notificationLink] as [String : Any]

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let postResponseModel = NewPostResponseModel()
            print("Error setting JSON")
            return postResponseModel
        }
        
        request.httpBody = httpBody

        //STEP 3: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

            print("API")
            print(newPostResponseModel)
            print("API")
            return newPostResponseModel
            
        } catch {
            let newPostResponseModel = NewPostResponseModel()
            print("Error decoding data")
            print(newPostResponseModel)
            return newPostResponseModel
            
        }
    }
    */
     
    
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

    

}


//
