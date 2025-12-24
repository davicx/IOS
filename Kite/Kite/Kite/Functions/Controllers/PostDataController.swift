//
//  PostDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/8/25.
//

import UIKit


class PostDataController {

    static let shared = PostDataController()

    // ------------------------------------------------
    // APP DATA: Source of truth for all posts
    // ------------------------------------------------
    private(set) var posts: [Post] = []

    private let postsAPI = PostsAPI()
    private let userDefaultManager = UserDefaultManager()

    var currentUser: String {
        return userDefaultManager.getLoggedInUser()
    }

    // ------------------------------------------------
    // APP DATA: OLD WAY (keep for now, but do not use)
    // ------------------------------------------------
    // OLD: Callback-based updates (confusing, will remove later)
    var onPostsUpdated: (() -> Void)?

    // ------------------------------------------------
    // APP DATA: FETCH POSTS
    // ------------------------------------------------
    func fetchPosts(groupID: Int) async {
        do {
            let postsResponseModel = try await postsAPI.getPostsAPI(groupID: groupID)
            let noImagePosts = try await createPostsArray(postsResponseModel: postsResponseModel)
            let postsWithImages = try await addPostImageToPostsArray(postsArray: noImagePosts)
            let postsWithGroupImages = try await addGroupImageToPostsArray(postsArray: postsWithImages)
            self.posts = try await addPostFromImageToPostsArray(postsArray: postsWithGroupImages)

            DispatchQueue.main.async {

                // ------------------------------------------------
                // APP DATA: OLD (do not rely on this anymore)
                // ------------------------------------------------
                // self.onPostsUpdated?()

                // ------------------------------------------------
                // APP DATA: NEW — broadcast to entire app
                // ------------------------------------------------
                NotificationCenter.default.post(
                    name: .postsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
    }

    // ------------------------------------------------
    // APP DATA: READ — Views pull, never store
    // ------------------------------------------------
    func getPostByID(postID: Int) -> Post? {
        return posts.first(where: { $0.postID == postID })
    }
    
    func getItemByID(postID: Int) -> Item? {
        return items.first { $0.postID == postID }
    }


    // ------------------------------------------------
    // APP DATA: LIKE POST
    // ------------------------------------------------
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

    // ------------------------------------------------
    // APP DATA: UNLIKE POST
    // ------------------------------------------------
    func unlikePost(postID: Int, likeModel: LikeModel) {

        // APP DATA: Step 1 – Find post
        guard let index = posts.firstIndex(where: { $0.postID == postID }) else { return }

        // APP DATA: Step 2 – Mutate data
        var post = posts[index]
        post.simpleLikesArray?.removeAll { $0 == likeModel.likedByUserName }
        post.postLikesArray?.removeAll { $0.postLikeID == likeModel.postLikeID }
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

    // ------------------------------------------------
    // APP DATA: LIKE COMMENT
    // ------------------------------------------------
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
    // APP DATA: ITEMS (LEFT MOSTLY AS-IS FOR NOW)
    // ------------------------------------------------
    private(set) var items: [Item] = []

    // OLD callback
    var onItemsUpdated: (() -> Void)?

    func fetchPostItems(groupID: Int) async {
        do {
            let itemsResponseModel = try await postsAPI.getItemsAPI(groupID: groupID)
            let noImageItems = try await createItemsArray(itemsResponseModel: itemsResponseModel)
            let itemsWithImages = try await addPostImageToItemsArray(itemsArray: noImageItems)
            let itemsWithGroupImages = try await addGroupImageToItemsArray(itemsArray: itemsWithImages)
            self.items = try await addPostFromImageToItemsArray(itemsArray: itemsWithGroupImages)

            DispatchQueue.main.async {

                // OLD
                // self.onItemsUpdated?()

                // NEW
                NotificationCenter.default.post(
                    name: .itemsFetched,
                    object: nil
                )
            }
        } catch {
            print("PostDataController: Failed to fetch items - \(error)")
        }
    }
}

// ------------------------------------------------
// APP DATA: Notification names
// ------------------------------------------------
extension Notification.Name {
    static let postUpdated = Notification.Name("postUpdated")
    static let postsFetched = Notification.Name("postsFetched")
    static let commentUpdated = Notification.Name("commentUpdated")

    // Items (later)
    static let itemsFetched = Notification.Name("itemsFetched")
    static let itemUpdated = Notification.Name("itemUpdated")
}


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
