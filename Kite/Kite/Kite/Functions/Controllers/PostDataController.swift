//
//  PostDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/8/25.
//

import UIKit



class PostDataController {

    static let shared = PostDataController()

    // MARK: - Posts Storage (Dictionary per groupID)
    private var groupPosts: [Int: [Post]] = [:] // groupID -> [Post]
    
    /*
    //OLD: Single array (replaced all posts when fetching new group)
    private(set) var posts: [Post] = []
    */

    private let postsAPI = PostsAPI()
    private let userDefaultManager = UserDefaultManager()

    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }
    
    // MARK: - Get Posts
    
    /// Get posts for a specific group
    func getPostsForGroup(groupID: Int) -> [Post] {
        return groupPosts[groupID] ?? []
    }
    
    /// Get home feed posts (for now, returns posts from group 72)
    func getHomeFeedPosts() -> [Post] {
        return getPostsForGroup(groupID: 72)
    }
    
    /// Get all posts from all groups (for home feed)
    var allPosts: [Post] {
        return Array(groupPosts.values).flatMap { $0 }
    }

    //FUNCTIONS A: Post Related
    //Function A1: Fetch posts from API
    func fetchPosts(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
            let noImagePosts = try await createPostsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToPostsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToPostsArray(postsArray: postsWithImages)
            let fetchedPosts = try await addPostFromImageToPostsArray(postsArray: postsWithGroupImages)
            
            // Store posts per groupID
            groupPosts[groupID] = fetchedPosts

            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .postsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
    }
    
    /*
    //OLD: Replaced entire posts array
    func fetchPosts(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
            let noImagePosts = try await createPostsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToPostsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToPostsArray(postsArray: postsWithImages)
            self.posts = try await addPostFromImageToPostsArray(postsArray: postsWithGroupImages)

            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .postsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
    }
    */
    
    
    func fetchItems(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getItemsAPI(groupID: groupID)
            let noImagePosts = try await createItemsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToItemsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToItemsArray(postsArray: postsWithImages)
            let itemsWithImages = try await addPostFromImageToItemsArray(postsArray: postsWithGroupImages)
            
            // Get existing posts for this group (or empty array)
            var existingPosts = groupPosts[groupID] ?? []
            
            // Merge items into existing posts (items are just posts with postType == "item")
            for item in itemsWithImages {
                if let index = existingPosts.firstIndex(where: { $0.postID == item.postID }) {
                    existingPosts[index] = item
                } else {
                    existingPosts.append(item)
                }
            }
            
            // Store updated posts for this group
            groupPosts[groupID] = existingPosts

            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .itemsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch items - \(error)")
        }
    }
    
    /*
    //OLD: Merged items into single posts array
    func fetchItems(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getItemsAPI(groupID: groupID)
            let noImagePosts = try await createItemsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToItemsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToItemsArray(postsArray: postsWithImages)
            let itemsWithImages = try await addPostFromImageToItemsArray(postsArray: postsWithGroupImages)
            
            // Merge items into posts array (items are just posts with postType == "item")
            for item in itemsWithImages {
                if let index = posts.firstIndex(where: { $0.postID == item.postID }) {
                    posts[index] = item
                } else {
                    posts.append(item)
                }
            }

            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .itemsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch items - \(error)")
        }
    }
    */

    //Function A2: Get a Post (searches across all groups)
    func getPostByID(postID: Int) -> Post? {
        // Search across all groups
        for posts in groupPosts.values {
            if let post = posts.first(where: { $0.postID == postID }) {
                return post
            }
        }
        return nil
    }
    
    /*
    //OLD: Searched single posts array
    func getPostByID(postID: Int) -> Post? {
        return posts.first(where: { $0.postID == postID })
    }
    */
    
    //Function A3: Get an Item (searches across all groups)
    func getItemByID(postID: Int) -> Post? {
        return getPostByID(postID: postID)
    }

    //Function A4: Like a Post
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
    
    /*
    //OLD: Searched single posts array
    func likePost(postID: Int, likeModel: LikeModel) {
        // APP DATA: Step 1 – Find post in source of truth
        guard let index = posts.firstIndex(where: { $0.postID == postID }) else { return }

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

        posts[index] = post

        // APP DATA: Step 3 – Notify entire app
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .postUpdated,
                object: postID
            )
        }
    }
    */

    //Function A5: Unlike a Post
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
    
    /*
    //OLD: Searched single posts array
    func unlikePost(postID: Int, likeModel: LikeModel) {
        // APP DATA: Step 1 – Find post
        guard let index = posts.firstIndex(where: { $0.postID == postID }) else { return }

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

        posts[index] = post

        // APP DATA: Step 3 – Notify app
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .postUpdated,
                object: postID
            )
        }
    }
    */

    //FUNCTIONS B: Comment Related
    //Function B1: Like a Comment
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
    
    /*
    //OLD: Searched single posts array
    func likeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        // APP DATA: Step 1 – Locate post + comment
        guard
            let postIndex = posts.firstIndex(where: { $0.postID == postID }),
            let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID })
        else { return }

        // APP DATA: Step 2 – Mutate data
        posts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = true
        posts[postIndex].commentsArray?[commentIndex].commentLikeCount? += 1
        posts[postIndex].commentsArray?[commentIndex].commentLikes?.append(commentLikeModel)

        // APP DATA: Step 3 – Notify app
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .commentUpdated,
                object: postID
            )
        }
    }
    */

    //Function B2: Unlike a Comment
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
    
    /*
    //OLD: Searched single posts array
    func unlikeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        guard
            let postIndex = posts.firstIndex(where: { $0.postID == postID }),
            let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID })
        else { return }

        posts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = false
        posts[postIndex].commentsArray?[commentIndex].commentLikeCount? -= 1
        posts[postIndex].commentsArray?[commentIndex].commentLikes?.removeAll {
            $0.commentLikeID == commentLikeModel.commentLikeID
        }

        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .commentUpdated,
                object: postID
            )
        }
    }
    */
    


}

//NOTIFICATIONS
extension Notification.Name {
    static let postUpdated = Notification.Name("postUpdated")
    static let postsFetched = Notification.Name("postsFetched")
    static let commentUpdated = Notification.Name("commentUpdated")

 
    static let itemsFetched = Notification.Name("itemsFetched")
    static let itemUpdated = Notification.Name("itemUpdated")
}


/*
 
 
 //CLEAN BELOW
 //CLEAN BELOW

 // ------------------------------------------------
 // APP DATA: DEBUG HELPERS
 // ------------------------------------------------
 func debugPrintCommentLikes() {
     for post in posts {
         print("POST ID: \(post.postID ?? -1)")
         guard let comments = post.commentsArray else {
             print("No comments")
             continue
         }

         for comment in comments {
             let likedUsernames = comment.commentLikes?.map { $0.likedByUserName } ?? []
             print("Comment \(comment.commentID ?? -1): \(likedUsernames)")
         }
         print("_________________")
     }
 }

 // ------------------------------------------------
 // APP DATA: ITEMS (using posts array, filtered by postType == "item")
 // ------------------------------------------------
 /*
 var items: [Post] {
     return posts.filter { $0.postType == "item" }
 }

 // OLD callback
 var onItemsUpdated: (() -> Void)?
 */
 */

//WORKING
/*
 class PostDataController {
    static let shared = PostDataController()

    private(set) var posts: [Post] = []

    private let postsAPI = PostsAPI()
    private let userDefaultManager = UserDefaultManager()

    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }

    // Callback to notify when posts are updated
    var onPostsUpdated: (() -> Void)?

    
    // Fetch posts from API
    func fetchPosts(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
            let noImagePosts = try await createPostsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToPostsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToPostsArray(postsArray: postsWithImages)
            self.posts = try await addPostFromImageToPostsArray(postsArray: postsWithGroupImages)
         
            DispatchQueue.main.async {
                self.onPostsUpdated?()
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
    }

    
    func getPostByID(postID: Int) -> Post? {
        return posts.first(where: { $0.postID == postID })
    }

    // Like a post
    func likePost(postID: Int, likeModel: LikeModel) {
        guard let index = posts.firstIndex(where: { $0.postID == postID }) else { return }

        var post = posts[index]
        post.simpleLikesArray = (post.simpleLikesArray ?? []).filter { $0 != likeModel.likedByUserName }
        post.postLikesArray = (post.postLikesArray ?? []).filter { $0.postLikeID != likeModel.postLikeID }

        post.simpleLikesArray?.append(likeModel.likedByUserName)
        post.postLikesArray?.append(likeModel)
        post.isLikedByCurrentUser = true

        posts[index] = post
    }

    // Unlike a post
    func unlikePost(postID: Int, likeModel: LikeModel) {
        guard let index = posts.firstIndex(where: { $0.postID == postID }) else { return }

        var post = posts[index]
        post.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
        post.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })
        post.isLikedByCurrentUser = false

        posts[index] = post
    }
    
    func likeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        guard let postIndex = posts.firstIndex(where: { $0.postID == postID }),
              let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) else {
            return
        }

        posts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = true
        posts[postIndex].commentsArray?[commentIndex].commentLikeCount? += 1
        posts[postIndex].commentsArray?[commentIndex].commentLikes?.append(commentLikeModel)
    }

    func unlikeComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        guard let postIndex = posts.firstIndex(where: { $0.postID == postID }),
              let commentIndex = posts[postIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) else {
            return
        }

        posts[postIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = false
        posts[postIndex].commentsArray?[commentIndex].commentLikeCount? -= 1
        posts[postIndex].commentsArray?[commentIndex].commentLikes?.removeAll {
            $0.commentLikeID == commentLikeModel.commentLikeID
        }
    }

    func debugPrintCommentLikes() {
        for post in posts {
            print("POST ID: \(post.postID ?? -1)")
            
            guard let comments = post.commentsArray else {
                print("No comments")
                continue
            }
            
            for comment in comments {
                let commentID = comment.commentID ?? -1
                let likedUsernames = comment.commentLikes?.map { $0.likedByUserName } ?? []
                print("Comment ID: \(commentID) - Liked By: \(likedUsernames)")
            }
            print("_________________")
        }
    }

    
    //ITEMS
    private(set) var items: [Item] = []
    
    // Callback to notify when items are updated
    var onItemsUpdated: (() -> Void)?
    
    // Fetch items from API
    func fetchPostItems(groupID: Int) async {
        do {
            let itemsResponseModel = try await postsAPI.getItemsAPI(groupID: groupID)
            let noImageItems = try await createItemsArray(itemsResponseModel: itemsResponseModel)
            let itemsWithImages = try await addPostImageToItemsArray(itemsArray: noImageItems)
            let itemsWithGroupImages = try await addGroupImageToItemsArray(itemsArray: itemsWithImages)
            self.items = try await addPostFromImageToItemsArray(itemsArray: itemsWithGroupImages)
         
            DispatchQueue.main.async {
                self.onItemsUpdated?()
            }
        } catch {
            print("PostDataController: Failed to fetch items - \(error)")
        }
    }
    
    func getItemByID(postID: Int) -> Item? {
        return items.first(where: { $0.postID == postID })
    }
    
    // Like an item
    func likeItem(postID: Int, likeModel: LikeModel) {
        guard let index = items.firstIndex(where: { $0.postID == postID }) else { return }

        var item = items[index]
        item.simpleLikesArray = (item.simpleLikesArray ?? []).filter { $0 != likeModel.likedByUserName }
        item.postLikesArray = (item.postLikesArray ?? []).filter { $0.postLikeID != likeModel.postLikeID }

        item.simpleLikesArray?.append(likeModel.likedByUserName)
        item.postLikesArray?.append(likeModel)
        item.isLikedByCurrentUser = true

        items[index] = item
        
        // TEST: Post notification for item update
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .itemUpdated,
                object: item
            )
        }
    }

    // Unlike an item
    func unlikeItem(postID: Int, likeModel: LikeModel) {
        guard let index = items.firstIndex(where: { $0.postID == postID }) else { return }

        var item = items[index]
        item.simpleLikesArray?.removeAll(where: { $0 == likeModel.likedByUserName })
        item.postLikesArray?.removeAll(where: { $0.postLikeID == likeModel.postLikeID })
        item.isLikedByCurrentUser = false

        items[index] = item
        
        // TEST: Post notification for item update
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .itemUpdated,
                object: item
            )
        }
    }
    
    func likeItemComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        guard let itemIndex = items.firstIndex(where: { $0.postID == postID }),
              let commentIndex = items[itemIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) else {
            return
        }

        items[itemIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = true
        items[itemIndex].commentsArray?[commentIndex].commentLikeCount? += 1
        items[itemIndex].commentsArray?[commentIndex].commentLikes?.append(commentLikeModel)
    }

    func unlikeItemComment(postID: Int, commentID: Int, commentLikeModel: CommentLikeModel) {
        guard let itemIndex = items.firstIndex(where: { $0.postID == postID }),
              let commentIndex = items[itemIndex].commentsArray?.firstIndex(where: { $0.commentID == commentID }) else {
            return
        }

        items[itemIndex].commentsArray?[commentIndex].commentLikedByCurrentUser = false
        items[itemIndex].commentsArray?[commentIndex].commentLikeCount? -= 1
        items[itemIndex].commentsArray?[commentIndex].commentLikes?.removeAll {
            $0.commentLikeID == commentLikeModel.commentLikeID
        }
    }
    
}

// TEST: Notification names for PostDataController
extension Notification.Name {
    static let itemUpdated = Notification.Name("itemUpdated")
}

*/
