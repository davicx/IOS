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

            DispatchQueue.main.async {
                self.onPostsUpdated?()
            }
        } catch {
            print("PostDataController: Failed to fetch posts - \(error)")
        }
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
}

