//
//  PostDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/8/25.
//

import UIKit


/*
FUNCTIONS A: All Functions Related to Getting Posts
    1) Function A1: Get home feed posts
    2) Function A2: Get posts for a specific group
    3) Function A3: Fetch posts for group
    4) Function A4: Get all posts from all groups
    5) Function A5: Get a Post (searches across all groups)
    6) Function A6: Get an Item (searches across all groups)
 
FUNCTIONS B: All Functions Related to Adding Posts
    1) Function B1: Add new post to groupPosts (called after creating a post via API)
 
FUNCTIONS C: All Functions Related to Post Actions
    1) Function C1: Like a Post
    2) Function C2: Unlike a Post
 
FUNCTIONS D: All Functions Related to Comments
    1) Function D1: Like a Comment
    2) Function D2: Unlike a Comment
    3) Function D3: Append new comment (after POST /comment)
 
FUNCTIONS E: All Functions Related to Items
    1) Function E1: Mark item purchased
    2) Function E2: Mark item unpurchased
 
*/


class PostDataController {

    static let shared = PostDataController()

    private var groupPosts: [Int: [Post]] = [:] // groupID -> [Post]

    private let postsAPI = PostsAPI()
    private let userDefaultManager = UserDefaultManager()

    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }

    var currentUserOwnsGroupForDisplay: Bool = true

    //FUNCTIONS A: All Functions Related to Getting Posts
    //Function A1: Get home feed posts (for now, returns posts from group 72)
    func getHomeFeedPosts() -> [Post] {
        return getPostsForGroup(groupID: 72)
    }
    
    //Function A2: Get posts for a specific group
    func getPostsForGroup(groupID: Int) -> [Post] {
        return groupPosts[groupID] ?? []
    }
    
    //Function A3: Fetch posts for group (WISHLIST: uses getItemsAPI, converts items to posts and merges into groupPosts)
    func fetchPosts(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getItemsAPI(groupID: groupID)
            let noImagePosts = try await createPostsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToPostsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToPostsArray(postsArray: postsWithImages)
            let fetchedPosts = try await addPostFromImageToPostsArray(postsArray: postsWithGroupImages)
            
            var existingPosts = groupPosts[groupID] ?? []
            for post in fetchedPosts {
                if let index = existingPosts.firstIndex(where: { $0.postID == post.postID }) {
                    existingPosts[index] = post
                } else {
                    existingPosts.append(post)
                }
            }
            groupPosts[groupID] = existingPosts

            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .postsFetched,
                    object: nil
                )
                NotificationCenter.default.post(
                    name: .itemsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
    }
    
    //KITE
    /*
     func fetchPosts(groupID: Int) async {
       
     }
     */
    
    
    //Function A4: Get all posts from all groups (for home feed)
    var allPosts: [Post] {
        return Array(groupPosts.values).flatMap { $0 }
    }

    //Function A5: Get a Post (searches across all groups)
    func getPostByID(postID: Int) -> Post? {
        // Search across all groups
        for posts in groupPosts.values {
            if let post = posts.first(where: { $0.postID == postID }) {
                return post
            }
        }
        return nil
    }
    
    //Function A6: Get an Item (searches across all groups)
    func getItemByID(postID: Int) -> Post? {
        return getPostByID(postID: postID)
    }
  

    
    //FUNCTIONS B: All Functions Related to Adding Posts
    //Function B1: Add new post to groupPosts (called after creating a post via API)
    func addPost(postModel: PostModel, groupID: Int) async {
        // Convert PostModel to Post (similar to createItemsArray logic)
        let newPost = Post(postID: postModel.postID)
        newPost.postType = postModel.postType
        newPost.groupID = postModel.groupID
        newPost.groupName = postModel.groupName
        newPost.groupImage = postModel.groupImage
        newPost.listID = postModel.listID
        newPost.postFrom = postModel.postFrom
        newPost.postFromImage = postModel.postFromImage
        newPost.postTo = postModel.postTo
        newPost.postCaption = postModel.postCaption
        
        newPost.fileName = postModel.fileURL
        newPost.fileNameServer = postModel.fileURL
        newPost.fileUrl = postModel.fileURL
        
        newPost.cloudBucket = postModel.cloudBucket
        newPost.cloudKey = postModel.cloudKey
        newPost.videoURL = postModel.videoURL
        newPost.videoCode = postModel.videoCode
        
        newPost.postDate = postModel.postDate
        newPost.postTime = postModel.postTime
        newPost.timeMessage = postModel.timeMessage
        
        newPost.created = postModel.created
        newPost.isLikedByCurrentUser = postModel.isLikedByCurrentUser
        
        // Convert Comments
        newPost.commentsArray = postModel.commentsArray.map { convertToCommentClass(from: $0) }
        
        newPost.postLikesArray = postModel.postLikesArray
        newPost.simpleLikesArray = postModel.simpleLikesArray
        
        // Add Item-specific data (if item field exists)
        if let item = postModel.item {
            newPost.itemID = item.item_id
            newPost.itemName = item.item_name
            newPost.itemPrice = item.item_price
            newPost.itemDescription = item.item_description
            newPost.itemCategory = item.item_category
            newPost.itemLink = item.item_link
            newPost.purchased = item.purchased
            newPost.purchasedBy = item.purchased_by
            newPost.purchasedViewers = item.purchased_viewers
            newPost.store = item.store
            newPost.multipleStores = item.multiple_stores
        }
        
        // Add images (async operations)
        var postWithImages = newPost
        let imageFunctions = ImageFunctions()
        
        // Add post image
        postWithImages.postImageData = await imageFunctions.getImageWithFallback(from: newPost.fileUrl)
        
        // Add group image
        postWithImages.groupImageData = await imageFunctions.getImageWithFallback(from: postWithImages.groupImage)
        
        // Add post-from image
        postWithImages.postFromImageData = await imageFunctions.getImageWithFallback(from: postWithImages.postFromImage)
        
   
        // Add post to groupPosts array (prepend to show at top)
        var existingPosts = groupPosts[groupID] ?? []
        existingPosts.insert(postWithImages, at: 0)
        groupPosts[groupID] = existingPosts
        
        // Notify app about new post
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .postsFetched,
                object: nil
            )
            NotificationCenter.default.post(
                name: .postUpdated,
                object: postModel.postID
            )
        }
    }
    

    //FUNCTIONS C: All Functions Related to Post Actions
    //Function C1: Like a Post
    func likePost(postID: Int, likeModel: LikeModel) {
        // APP DATA: Step 1 – Find post in source of truth (search across all groups)
        for (groupID, posts) in groupPosts {
            if let index = posts.firstIndex(where: { $0.postID == postID }) {
                // APP DATA: Step 2 – Mutate data
                var post = posts[index]
                
                post.simpleLikesArray = (post.simpleLikesArray ?? []).filter {
                    $0 != likeModel.likedByUserName
                }
                
                post.postLikesArray = (post.postLikesArray ?? []).filter {
                    $0.postLikeID != likeModel.postLikeID
                }
                
                post.simpleLikesArray?.append(likeModel.likedByUserName)
                post.postLikesArray?.append(likeModel)
                post.isLikedByCurrentUser = true
                
                // Update post in dictionary
                var updatedPosts = posts
                updatedPosts[index] = post
                groupPosts[groupID] = updatedPosts
                
                // APP DATA: Step 3 – Notify entire app
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .postUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }
    
    //Function C2: Unlike a Post
    func unlikePost(postID: Int, likeModel: LikeModel) {
        // APP DATA: Step 1 – Find post (search across all groups)
        for (groupID, posts) in groupPosts {
            if let index = posts.firstIndex(where: { $0.postID == postID }) {
                // APP DATA: Step 2 – Mutate data (same pattern as likePost)
                var post = posts[index]
                
                // Use currentUser instead of likeModel.likedByUserName (API doesn't populate it for unlike)
                let userNameToRemove = currentUser
                
                post.simpleLikesArray = (post.simpleLikesArray ?? []).filter {
                    $0 != userNameToRemove
                }
                
                post.postLikesArray = (post.postLikesArray ?? []).filter {
                    $0.postLikeID != likeModel.postLikeID
                }
                
                post.isLikedByCurrentUser = false
                
                // Update post in dictionary
                var updatedPosts = posts
                updatedPosts[index] = post
                groupPosts[groupID] = updatedPosts
                
                // APP DATA: Step 3 – Notify app
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .postUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }
 
 
    //FUNCTIONS D: All Functions Related to Comments
    //Function D1: Like a Comment
    func likeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        // APP DATA: Step 1 – Locate post + comment (search across all groups)
        for (groupID, posts) in groupPosts {
            if let postIndex = posts.firstIndex(where: { $0.postID == postID }),
               let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) {
                
                // APP DATA: Step 2 – Mutate data
                var updatedPosts = posts
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = true
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikeCount? += 1
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikes?.append(commentLikeModel)
                
                // Update posts in dictionary
                groupPosts[groupID] = updatedPosts
                
                // APP DATA: Step 3 – Notify app
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .commentUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }


    //Function D3: Append new comment after POST /comment succeeds
    func addCommentFromAPI(postID: Int, commentModel: CommentModel) {
        let comment = convertToCommentClass(from: commentModel)
        for (groupID, posts) in groupPosts {
            if let postIndex = posts.firstIndex(where: { $0.postID == postID }) {
                var updatedPosts = posts
                var post = updatedPosts[postIndex]
                if post.commentsArray == nil {
                    post.commentsArray = []
                }
                post.commentsArray?.append(comment)
                updatedPosts[postIndex] = post
                groupPosts[groupID] = updatedPosts
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .commentUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }

    //Function D2: Unlike a Comment
    func unlikeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        // Search across all groups
        for (groupID, posts) in groupPosts {
            if let postIndex = posts.firstIndex(where: { $0.postID == postID }),
               let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) {
                
                var updatedPosts = posts
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = false
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikeCount? -= 1
                updatedPosts[postIndex].commentsArray?[commentIndex].commentLikes?.removeAll {
                    $0.commentLikeID == commentLikeModel.commentLikeID
                }
                
                // Update posts in dictionary
                groupPosts[groupID] = updatedPosts
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .commentUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }
    
    
    //FUNCTIONS E: All Functions Related to Items
    //Function E1: Mark item purchased
    func markItemPurchased(postID: Int, purchasedBy: String, purchasedViewers: [String]) {
        for (groupID, posts) in groupPosts {
            if let index = posts.firstIndex(where: { $0.postID == postID }) {
                var post = posts[index]
                post.purchased = 1
                post.purchasedBy = purchasedBy
                post.purchasedViewers = purchasedViewers
                var updatedPosts = posts
                updatedPosts[index] = post
                groupPosts[groupID] = updatedPosts
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .postUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }
    
    //Function E2: Mark item unpurchased
    func markItemUnpurchased(postID: Int) {
        for (groupID, posts) in groupPosts {
            if let index = posts.firstIndex(where: { $0.postID == postID }) {
                var post = posts[index]
                post.purchased = 0
                post.purchasedBy = ""
                post.purchasedViewers = []
                var updatedPosts = posts
                updatedPosts[index] = post
                groupPosts[groupID] = updatedPosts
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: .postUpdated,
                        object: postID
                    )
                }
                return
            }
        }
    }


}


//NOTIFICATIONS
extension Notification.Name {
    static let postUpdated = Notification.Name("postUpdated")
    static let postsFetched = Notification.Name("postsFetched")
    static let commentUpdated = Notification.Name("commentUpdated")

 
    static let itemsFetched = Notification.Name("itemsFetched")
    static let itemUpdated = Notification.Name("itemUpdated")
}

