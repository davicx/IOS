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
    2) Function B2: Create photo post (KITE)
    3) Function B3: Delete a post
 
FUNCTIONS C: All Functions Related to Items (purchase)
    1) Function C1: Purchase Item
    2) Function C2: Remove Item

FUNCTIONS D: Comments
    1) Function D1: Create comment (POST /comment)
 
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

    //Function B2: Create photo post (KITE)
    func createPhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async -> Bool {
        let postsAPI = PostsAPI()

        do {
            let responseModel = try await postsAPI.makePhotoPost(
                postImage: postImage,
                postFrom: postFrom,
                postTo: postTo,
                postCaption: postCaption,
                groupID: groupID,
                listID: listID
            )

            guard responseModel.success else {
                print("PostLogic: Failed to create photo post: \(responseModel.message)")
                return false
            }

            await postDataController.addPost(postModel: responseModel.data, groupID: groupID)
            return true
        } catch {
            print("PostLogic: Error creating photo post: \(error)")
            return false
        }
    }

    //Function B3: Delete a post
    func deletePost(postID: Int) async -> Bool {
        let currentUser = postDataController.currentUser

        do {
            let success = try await PostsAPI().deletePostAPI(
                currentUser: currentUser,
                postID: postID
            )
            guard success else {
                print("PostLogic: Failed to delete post \(postID)")
                return false
            }
            await MainActor.run {
                postDataController.removePost(postID: postID)
            }
            return true
        } catch {
            print("PostLogic: Error deleting post: \(error)")
            return false
        }
    }
    
    //FUNCTIONS D: Comments
    //Function D1: Create comment — API uses JSON numbers for groupID, postTo, postID, listID.
    /// `postTo` in the request body is the recipient user id (Int). Your POST /comment sample uses the same value as `postID`; `Post.postTo` is a String in the client and can be wrong (e.g. "72"), so we send `post.postID` for `postTo` to match that contract.
    func makeComment(post: Post, commentCaption: String) async -> Bool {
        let trimmed = commentCaption.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        guard let groupID = post.groupID else {
            print("PostLogic: makeComment skipped — missing groupID")
            return false
        }
        let listID = post.listID ?? 0
        let postToInt = post.postID

        do {
            let response = try await CommentsAPI.shared.makeComment(
                commentCaption: trimmed,
                commentFrom: postDataController.currentUser,
                commentType: "post",
                groupID: groupID,
                postTo: postToInt,
                postID: post.postID,
                listID: listID
            )
            guard response.success else {
                print("PostLogic: makeComment failed: \(response.message)")
                return false
            }
            await MainActor.run {
                postDataController.addCommentFromAPI(postID: post.postID, commentModel: response.data)
            }
            return true
        } catch {
            print("PostLogic: makeComment error: \(error)")
            return false
        }
    }

    //KITE
    //Add Kite Later
    /*
     
     */
    
    
    //FUNCTIONS C: All Functions Related to Items (purchase)
    //Function C1: Purchase Item
    func purchaseItem(post: Post, groupID: Int, showPurchased: [String]) async {
        guard let itemID = post.itemID else { return }
        let currentUser = postDataController.currentUser

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

