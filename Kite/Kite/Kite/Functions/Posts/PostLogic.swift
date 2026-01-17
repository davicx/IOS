//
//  PostLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/1/26.
//

import UIKit


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
        
        // STEP 5: PostLogic performs API request
        // STEP 6: API responds with updated post data
        // STEP 7: PostDataController updates its stored post
        // STEP 8: PostDataController posts NotificationCenter event
        
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
    
    // MARK: - Create Post
    
    func createItemPost(
        postImage: UIImage,
        postFrom: String,
        postTo: String,
        postCaption: String,
        groupID: Int,
        listID: Int,
        itemName: String,
        itemPrice: String,
        itemDescription: String,
        itemLink: String
    ) async -> Bool {
        // Step 1: API call via PostsAPI
        let postsAPI = PostsAPI()
        do {
            let responseModel = try await postsAPI.makeItemPost(
                postImage: postImage,
                postFrom: postFrom,
                postTo: postTo,
                postCaption: postCaption,
                groupID: groupID,
                listID: listID,
                itemName: itemName,
                itemPrice: itemPrice,
                itemDescription: itemDescription,
                itemLink: itemLink
            )
            
            guard responseModel.success else {
                print("PostLogic: Failed to create item post: \(responseModel.message)")
                return false
            }
            
            // Step 2: Add post to data controller (which posts notification)
            await postDataController.addPost(postModel: responseModel.data, groupID: groupID)
            
            return true
        } catch {
            print("PostLogic: Error creating item post: \(error)")
            return false
        }
    }
}

