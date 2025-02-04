//
//  postFunctions.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
//




import UIKit
 

let networker = PostsAPI()
//var tempURL = Constants.VariableConstants.tempURL


//Function A1: Create Posts from API
func createPostsArray(postsResponseModel: PostResponseModel) async throws -> [Post]{
    let postsTemp = postsResponseModel.data
    var postsArray = [Post]()
    
    //STEP 1: Loop over posts and Create Post Objects
    for post in postsTemp {

        //STEP 2: Create Post
        let currentPost = Post(postID: post.postID)
        currentPost.postType = post.postType
        currentPost.groupID = post.groupID
        currentPost.listID = post.listID
        currentPost.postFrom = post.postFrom
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
    
        currentPost.fileName = post.fileURL
        currentPost.fileNameServer = post.fileURL
        currentPost.fileUrl = post.fileURL
        
        currentPost.cloudKey = post.cloudKey
        currentPost.videoURL = post.videoURL
        currentPost.videoCode = post.videoCode
        
        currentPost.postDate = post.postDate
        currentPost.postTime = post.postTime
        currentPost.timeMessage = post.timeMessage
        
        currentPost.created = post.created
        
        currentPost.commentsArray = post.commentsArray
        currentPost.postLikesArray = post.postLikesArray
        currentPost.simpleLikesArray = post.simpleLikesArray
        

        //STEP 3: Append to Array
        postsArray.append(currentPost)

    }
    

    
    return postsArray
}
    
//Function A2: Add Image to Post
func addPostImageToPostsArray(postsArray: [Post]) async throws -> [Post]{
    for post in postsArray {
        let imageUrl = URL(string: post.fileUrl!)!
        let data = try await networker.downloadImageData(from: imageUrl)
        post.postImageData = UIImage(data: data)
    }
    
   return postsArray
}


func printPostLikes(post: Post) {
    let simpleLikesArray : Array = post.simpleLikesArray ?? []
    for user in simpleLikesArray {
        print("Liked By, \(user)!")
    }
}
