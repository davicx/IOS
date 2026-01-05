//
//  PostLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/1/26.
//

import Foundation


final class PostLogic {
    static let shared = PostLogic()
    private init() {}
    
    private let postDataController = PostDataController.shared
    
    // MARK: - Likes
    
    func toggleLike(post: Post, groupID: Int) async {
        if post.isLikedByCurrentUser == true {
            await unlike(post: post, groupID: groupID)
        } else {
            await like(post: post, groupID: groupID)
        }
    }
    
    func like(post: Post, groupID: Int) async {
        // Step 1: API call via postLikeFunctions (lazy reference to avoid circular dependency)
        let likeFunctions = postLikeFunctions.shared
        guard let likeModel = await likeFunctions.likePost(post: post, groupID: groupID) else {
            return // API call failed
        }
        
        // Step 2: Update data controller (which posts notification)
        postDataController.likePost(postID: post.postID, likeModel: likeModel)
    }
    
    func unlike(post: Post, groupID: Int) async {
        // Step 1: API call via postLikeFunctions (lazy reference to avoid circular dependency)
        let likeFunctions = postLikeFunctions.shared
        guard let likeModel = await likeFunctions.unlikePost(post: post, groupID: groupID) else {
            return // API call failed
        }
        
        // Step 2: Update data controller (which posts notification)
        postDataController.unlikePost(postID: post.postID, likeModel: likeModel)
    }
}

