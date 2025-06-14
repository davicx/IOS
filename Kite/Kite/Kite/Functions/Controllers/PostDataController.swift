//
//  PostDataController.swift
//  Kite
//
//  Created by David Vasquez on 6/8/25.
//

import UIKit


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
            self.posts = try await addPostImageToPostsArray(postsArray: noImagePosts)
            print("FETCHING POSTS!!!!")

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

}

