//
//  postLikeFunctions.swift
//  Kite
//
//  Created by David Vasquez on 5/14/25.
//

import Foundation


class postLikeFunctions {
    static let shared = postLikeFunctions()
    private init() {}

    let postAPI = PostsAPI()
    let commentsAPI = CommentsAPI.shared
    let currentUser = userDefaultManager.getLoggedInUser()

    // Remove delegates if you're fully moving to PostDataController
    //weak var likePostDelegate: LikePostDelegate?
    //weak var likeCommentDelegate: LikeCommentDelegate?

    func likePost(post: Post, groupID: Int) async -> LikeModel? {
        do {
            let response = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
            if response.success {
                let likeModel = response.data
                post.isLikedByCurrentUser = true
                post.postLikesArray?.append(likeModel)
                post.simpleLikesArray?.append(likeModel.likedByUserName)
                return likeModel
            }
        } catch {
            print("Error liking post:", error)
        }
        return nil
    }

    func unlikePost(post: Post, groupID: Int) async -> LikeModel? {
        do {
            let response = try await postAPI.unlikePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
            if response.success {
                let likeModel = response.data
                post.isLikedByCurrentUser = false
                post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeModel.postLikeID }
                post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != response.currentUser }
                return likeModel
            }
        } catch {
            print("Error unliking post:", error)
        }
        return nil
    }

    // MARK: - Like Comment
    func likeComment(comment: Comment, postID: Int, groupID: Int) async {
        do {
            let response = try await commentsAPI.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
            if response.success {
                let commentLikeModel = response.data
                PostDataController.shared.likeComment(
                    postID: postID,
                    commentID: comment.commentID ?? 0,
                    commentLikeModel: commentLikeModel
                )
            }
        } catch {
            print("Error liking comment:", error)
        }
    }
    

    // MARK: - Unlike Comment
    func unlikeComment(comment: Comment, postID: Int, groupID: Int) async {
        do {
            let response = try await commentsAPI.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
            if response.success {
                let commentUnlikeModel = response.data
                PostDataController.shared.unlikeComment(
                    postID: postID,
                    commentID: comment.commentID ?? 0,
                    commentLikeModel: commentUnlikeModel
                )
            }
        } catch {
            print("Error unliking comment:", error)
        }
    }
}

