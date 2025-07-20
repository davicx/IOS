//
//  postFunctions.swift
//  Instagram
//
//  Created by David Vasquez on 10/20/24.
//

import UIKit
 

let imageFunctions = ImageFunctions()


//Function A1: Create Posts from API this converts the Post Reponse into an array of Posts
func createPostsArray(postsResponseModel: PostResponseModel) async throws -> [Post]{
    let postsTemp = postsResponseModel.data
    var postsArray = [Post]()
    
    //STEP 1: Loop over posts and Create Post Objects
    for post in postsTemp {

        //STEP 2: Create Post
        let currentPost = Post(postID: post.postID)
        currentPost.postType = post.postType
        currentPost.groupID = post.groupID
        currentPost.groupName = post.groupName
        currentPost.groupImage = post.groupImage
        currentPost.listID = post.listID
        currentPost.postFrom = post.postFrom
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
    
        currentPost.fileName = post.fileURL
        currentPost.fileNameServer = post.fileURL
        currentPost.fileUrl = post.fileURL
        
        currentPost.cloudBucket = post.cloudBucket
        currentPost.cloudKey = post.cloudKey
        currentPost.videoURL = post.videoURL
        currentPost.videoCode = post.videoCode
        
        currentPost.postDate = post.postDate
        currentPost.postTime = post.postTime
        currentPost.timeMessage = post.timeMessage
        
        currentPost.created = post.created
        currentPost.isLikedByCurrentUser = post.isLikedByCurrentUser
        
        //Convert Comments
        currentPost.commentsArray = post.commentsArray.map { convertToCommentClass(from: $0) }
        
        //currentPost.commentsArray = post.commentsArray
        currentPost.postLikesArray = post.postLikesArray
        currentPost.simpleLikesArray = post.simpleLikesArray

        //STEP 3: Append to Array
        postsArray.append(currentPost)

    }
    
    return postsArray
}

func convertToCommentClass(from model: CommentModel) -> Comment {
    return Comment(
        commentID: model.commentID,
        postID: model.postID,
        groupID: model.groupID,
        listID: model.listID,
        commentCaption: model.commentCaption,
        commentFrom: model.commentFrom,
        commentType: model.commentType,
        userName: model.userName,
        imageName: model.imageName,
        firstName: model.firstName,
        lastName: model.lastName,
        commentDate: model.commentDate,
        commentTime: model.commentTime,
        timeMessage: model.timeMessage,
        commentLikes: model.commentLikes,
        created: model.created,
        friendshipStatus: model.friendshipStatus,
        commentLikeCount: model.commentLikeCount,
        commentLikedByCurrentUser: model.commentLikedByCurrentUser
    )
}

    

//Function A2: Add Image to Post
func addPostImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        if let fileUrlString = post.fileUrl,
           let imageUrl = URL(string: fileUrlString),
           fileUrlString.lowercased() != "empty" {
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].postImageData = UIImage(data: data)
            } catch {
                print("Error downloading image for postID \(post.postID): \(error)")
                updatedPosts[index].postImageData = UIImage(named: "background_1") // Default image
            }
        } else {
            print("Invalid or missing fileURL for postID \(post.postID), using default image")
            updatedPosts[index].postImageData = UIImage(named: "background_1") // Default image
        }
    }
    
    return updatedPosts
}

/*
//Function A2: Add Image to Post (Enhanced Error Handling)
func addPostImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        if let fileUrlString = post.fileUrl,
           fileUrlString.lowercased() != "empty",
           fileUrlString.lowercased() != "fileurl",
           !fileUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            // Validate URL format before attempting to download
            guard let imageUrl = URL(string: fileUrlString),
                  imageUrl.scheme != nil,
                  (imageUrl.scheme == "http" || imageUrl.scheme == "https") else {
                print("Invalid post image URL format for postID \(post.postID): '\(fileUrlString)'. Using default image.")
                updatedPosts[index].postImageData = UIImage(named: "background_1")
                continue
            }
            
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].postImageData = UIImage(data: data)
            } catch {
                print("Error downloading post image for postID \(post.postID): \(error.localizedDescription). Using default image.")
                updatedPosts[index].postImageData = UIImage(named: "background_1")
            }
        } else {
            print("Missing or invalid fileURL for postID \(post.postID): '\(post.fileUrl ?? "nil")'. Using default image.")
            updatedPosts[index].postImageData = UIImage(named: "background_1")
        }
    }
    
    return updatedPosts
}
*/

//Function A3: Add Group Image to Post
func addGroupImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        if let groupImageUrlString = post.groupImage,
           let imageUrl = URL(string: groupImageUrlString),
           groupImageUrlString.lowercased() != "empty" {
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].groupImageData = UIImage(data: data)
            } catch {
                print("Error downloading group image for postID \(post.postID): \(error)")
                updatedPosts[index].groupImageData = UIImage(named: "background_1") // Default image
            }
        } else {
            print("Invalid or missing groupImage for postID \(post.postID), using default image")
            updatedPosts[index].groupImageData = UIImage(named: "background_1") // Default image
        }
    }
    
    return updatedPosts
}

/*
//Function A3: Add Group Image to Post (Enhanced Error Handling)
func addGroupImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        if let groupImageUrlString = post.groupImage,
           groupImageUrlString.lowercased() != "empty",
           groupImageUrlString.lowercased() != "fileurl",
           !groupImageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            // Validate URL format before attempting to download
            guard let imageUrl = URL(string: groupImageUrlString),
                  imageUrl.scheme != nil,
                  (imageUrl.scheme == "http" || imageUrl.scheme == "https") else {
                print("Invalid group image URL format for postID \(post.postID): '\(groupImageUrlString)'. Using default image.")
                updatedPosts[index].groupImageData = UIImage(named: "background_1")
                continue
            }
            
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].groupImageData = UIImage(data: data)
            } catch {
                print("Error downloading group image for postID \(post.postID): \(error.localizedDescription). Using default image.")
                updatedPosts[index].groupImageData = UIImage(named: "background_1")
            }
        } else {
            print("Missing or invalid groupImage for postID \(post.postID): '\(post.groupImage ?? "nil")'. Using default image.")
            updatedPosts[index].groupImageData = UIImage(named: "background_1")
        }
    }
    
    return updatedPosts
}
*/

//FORCE an Error
/*
func addPostImageToPostsArray(postsArray: [Post]) async throws -> [Post]{
    for post in postsArray {
        let imageUrl = URL(string: post.fileUrl!)!
        let data = try await networker.downloadImageData(from: imageUrl)
        post.postImageData = UIImage(data: data)
    }
    
   return postsArray
}
*/

func printPostLikes(post: Post) {
    let simpleLikesArray : Array = post.simpleLikesArray ?? []
    for user in simpleLikesArray {
        print("Liked By, \(user)!")
    }
}

