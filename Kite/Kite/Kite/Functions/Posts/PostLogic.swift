//
//  PostLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/1/26.
//

import UIKit


/*
FUNCTIONS A: All Functions Related to Post Likes
    1) Function A1: Toggle like (like or unlike)
    2) Function A2: Like a Post
    3) Function A3: Unlike a Post
 
FUNCTIONS B: All Functions Related to Creating Posts
    1) Function B1: Create item post (WISHLIST)
 
FUNCTIONS C: All Functions Related to Items (purchase)
    1) Function C1: Purchase Item
    2) Function C2: Remove Item
 
*/


final class PostLogic {
    static let shared = PostLogic()
    private init() {}
    
    private let postDataController = PostDataController.shared

    //FUNCTIONS A: All Functions Related to Post Likes
    //Function A1: Toggle like (like or unlike)
    func toggleLike(post: Post, groupID: Int) async {
        if post.isLikedByCurrentUser == true {
            await unlike(post: post, groupID: groupID)
        } else {
            await like(post: post, groupID: groupID)
        }
    }
    

    //Function A2: Like a Post
    func like(post: Post, groupID: Int) async {
        // Step 1: API call via postLikeFunctions (lazy reference to avoid circular dependency)
        let likeFunctions = postLikeFunctions.shared
        guard let likeModel = await likeFunctions.likePost(post: post, groupID: groupID) else {
            return // API call failed
        }
        
        // Step 2: Update data controller (which posts notification)
        postDataController.likePost(postID: post.postID, likeModel: likeModel)
    }
    
    //Function A3: Unlike a Post
    func unlike(post: Post, groupID: Int) async {
        // Step 1: API call via postLikeFunctions (lazy reference to avoid circular dependency)
        let likeFunctions = postLikeFunctions.shared
        guard let likeModel = await likeFunctions.unlikePost(post: post, groupID: groupID) else {
            return // API call failed
        }
        
        // Step 2: Update data controller (which posts notification)
        postDataController.unlikePost(postID: post.postID, likeModel: likeModel)
    }
    
    
    //FUNCTIONS B: All Functions Related to Creating Posts
    //Function B1: Create item post (WISHLIST)
    func createItemPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int,
        listID: Int, itemName: String, itemPrice: String, itemDescription: String, itemLink: String) async -> Bool {
        
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
    
    //KITE
    //Add Kite Later
    /*
     
     */
    
    
    //FUNCTIONS C: All Functions Related to Items (purchase)
    //Function C1: Purchase Item
    func purchaseItem(post: Post, groupID: Int) async {
        guard let itemID = post.itemID else { return }
        let currentUser = postDataController.currentUser
        let showPurchased = post.purchasedViewers ?? ["frodo", "bilbo"]
        
        do {
            let response = try await PostsAPI().purchaseItemAPI(
                currentUser: currentUser,
                postID: post.postID,
                itemID: itemID,
                showPurchased: showPurchased
            )
            guard response.success else {
                print("PostLogic: Failed to purchase item: \(response.message)")
                return
            }
            postDataController.markItemPurchased(
                postID: post.postID,
                purchasedBy: response.data.purchasedBy,
                purchasedViewers: showPurchased
            )
        } catch {
            print("PostLogic: Error purchasing item: \(error)")
        }
    }
    
    
    //Function C2: Remove Item
    func removeItem(post: Post, groupID: Int) async {
        guard let itemID = post.itemID else { return }
        let currentUser = postDataController.currentUser
        
        do {
            let response = try await PostsAPI().removeItemPurchaseAPI(
                currentUser: currentUser,
                postID: post.postID,
                itemID: itemID
            )
            guard response.success else {
                print("PostLogic: Failed to remove item purchase: \(response.message)")
                return
            }
            postDataController.markItemUnpurchased(postID: post.postID)
        } catch {
            print("PostLogic: Error removing item purchase: \(error)")
        }
    }
}

