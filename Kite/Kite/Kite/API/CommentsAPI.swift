//
//  CommentsAPI.swift
//  Kite
//
//  Created by David Vasquez on 5/4/25.
//

import UIKit


class CommentsAPI {
    
    static let shared = CommentsAPI()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    //Function 1: Make Comment
    func makeComment(commentCaption: String, commentFrom: String, commentType: String, groupID: Int, postTo: Int, postID: Int, listID: Int) async throws -> CommentResponseModel {
        
        let masterSite = "kite"
        let notificationMessage = "Made a Comment on your Post"
        let notificationType = "new_post_comment"
        let notificationLink = "http://localhost:3003/posts/group/\(groupID)"
        
        let endpoint = "http://localhost:3003/comment/create"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["masterSite": masterSite, "commentCaption": commentCaption, "commentType": commentType, "commentFrom": commentFrom, "groupID": groupID, "postTo": postTo, "postID": postID, "listID": listID, "notificationMessage": notificationMessage, "notificationType": notificationType, "notificationLink": notificationLink] as [String : Any]

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let commentResponseModel = CommentResponseModel()
            print("Error setting JSON")
            return commentResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let commentResponseModel = try decoder.decode(CommentResponseModel.self, from: data)
            return commentResponseModel
            
        } catch {
            let commentResponseModel = CommentResponseModel()
            print("Error decoding data")
            return commentResponseModel
        }
    }

    func likeComment(currentUser: String, postID: Int, commentID: Int, groupID: Int) async throws -> CommentLikeResponseModel {
        
        let endpoint = "http://localhost:3003/comment/like"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["currentUser": currentUser, "postID": postID, "commentID": commentID, "groupID": groupID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let commentLikeResponseModel = CommentLikeResponseModel()
            print("Error setting JSON")
            return commentLikeResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {

            let decoder = JSONDecoder()
            let commentLikeResponseModel = try decoder.decode(CommentLikeResponseModel.self, from: data)
            return commentLikeResponseModel
            
        } catch {
            let commentLikeResponseModel = CommentLikeResponseModel()
            print("Error decoding data")
            return commentLikeResponseModel
        }
    }
    
    //Function 3: Unlike Comment
    func unlikeComment(currentUser: String, postID: Int, commentID: Int, groupID: Int) async throws -> CommentLikeResponseModel {
        
        let endpoint = "http://localhost:3003/comment/unlike"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        let parameters = ["currentUser": currentUser, "postID": postID, "commentID": commentID, "groupID": groupID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let commentLikeResponseModel = CommentLikeResponseModel()
            print("Error setting JSON")
            return commentLikeResponseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let commentLikeResponseModel = try decoder.decode(CommentLikeResponseModel.self, from: data)
            return commentLikeResponseModel
            
        } catch {
            let commentLikeResponseModel = CommentLikeResponseModel()
            print("Error decoding data")
            return commentLikeResponseModel
        }
    }
}
