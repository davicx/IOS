//
//  postLikeFunctions.swift
//  Kite
//
//  Created by David Vasquez on 5/14/25.
//

import Foundation

//postLikeFunctions
class postLikeFunctions {
    static let shared = postLikeFunctions()
    private init() {}
    
    let postAPI = PostsAPI()
    let commentsAPI = CommentsAPI.shared
    let currentUser = userDefaultManager.getLoggedInUser()

    weak var likePostDelegate: LikePostDelegate?
    weak var likeCommentDelegate: LikeCommentDelegate?

    func likePost(post: Post, groupID: Int) async {
        do {
            let response = try await postAPI.likePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
            if response.success == true {
                let likeModel = response.data
                post.isLikedByCurrentUser = true
                post.postLikesArray?.append(likeModel)
                post.simpleLikesArray?.append(likeModel.likedByUserName)
                likePostDelegate?.updatePostsArrayWithLikePost(currentPostID: post.postID, likeModel: likeModel)
            }
        } catch {
            print("Error liking post:", error)
        }
    }

    func unlikePost(post: Post, groupID: Int) async {
        do {
            let response = try await postAPI.unlikePostAPI(currentUser: currentUser, postID: post.postID, groupID: groupID)
            if response.success == true {
                let likeModel = response.data
                post.isLikedByCurrentUser = false
                post.postLikesArray = post.postLikesArray?.filter { $0.postLikeID != likeModel.postLikeID }
                post.simpleLikesArray = post.simpleLikesArray?.filter { $0 != response.currentUser }
                likePostDelegate?.updatePostsArrayWithUnlikePost(currentPostID: post.postID, likeModel: likeModel)
            }
        } catch {
            print("Error unliking post:", error)
        }
    }

    func likeComment(comment: Comment, postID: Int, groupID: Int) async {
        do {
            let response = try await commentsAPI.likeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
            if response.success == true {
                let commentLikeModel = response.data
                likeCommentDelegate?.updatePostsArrayWithLikeComment(currentPostID: comment.postID ?? 0, currentCommentID: comment.commentID ?? 0, commentLikeModel: commentLikeModel)
            }
        } catch {
            print("Error liking comment:", error)
        }
    }

    func unlikeComment(comment: Comment, postID: Int, groupID: Int) async {
        do {
            let response = try await commentsAPI.unlikeComment(currentUser: currentUser, postID: postID, commentID: comment.commentID ?? 0, groupID: groupID)
            if response.success == true {
                let commentUnlikeModel = response.data
                likeCommentDelegate?.updatePostsArrayWithUnlikeComment(currentPostID: comment.postID ?? 0, currentCommentID: comment.commentID ?? 0, commentLikeModel: commentUnlikeModel)
            }
        } catch {
            print("Error unliking comment:", error)
        }
    }
}
