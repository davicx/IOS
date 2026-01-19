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
        currentPost.postFromImage = post.postFromImage
        currentPost.postTo = post.postTo
        currentPost.postCaption = post.postCaption
    
        currentPost.fileName = post.fileURL
        currentPost.fileNameServer = post.fileURL
        currentPost.fileUrl = post.fileURL
        
        currentPost.cloudBucket = post.cloudBucket
        currentPost.cloudKey = post.cloudKey
        currentPost.storageType = post.storageType
        
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




//Function A3: Convert Comments
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

    

//Function A4: Add Image to Post
func addPostImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].postImageData = await imageFunctions.getImageWithFallback(from: post.fileUrl)
    }
    
    return updatedPosts
}

/*
//OLD: Manual validation and download
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
*/


//Function A5: Add Group Image to Post
func addGroupImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].groupImageData = await imageFunctions.getImageWithFallback(from: post.groupImage)
    }

    return updatedPosts
}

/*
//OLD: Manual validation and download
func addGroupImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        if let groupImageUrlString = post.groupImage,
           !groupImageUrlString.isEmpty,
           groupImageUrlString.lowercased() != "empty",
           let imageUrl = URL(string: groupImageUrlString),
           imageUrl.scheme == "http" || imageUrl.scheme == "https" {
            
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].groupImageData = UIImage(data: data)
            } catch {
                print("Error downloading group image for groupID \(post.groupID ?? -1)")
                updatedPosts[index].groupImageData = UIImage(named: "background_1")
            }

        } else {
            print("Invalid or missing groupImage for groupID \(post.groupID ?? -1), using default image")
            updatedPosts[index].groupImageData = UIImage(named: "background_1")
        }
    }

    return updatedPosts
}
*/


//Function A6: Add Post From Image to Posts
func addPostFromImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].postFromImageData = await imageFunctions.getImageWithFallback(from: post.postFromImage)
    }

    return updatedPosts
}

/*
//OLD: Manual validation and download
func addPostFromImageToPostsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        if let postFromImageUrlString = post.postFromImage,
           !postFromImageUrlString.isEmpty,
           postFromImageUrlString.lowercased() != "empty",
           let imageUrl = URL(string: postFromImageUrlString),
           imageUrl.scheme == "http" || imageUrl.scheme == "https" {
            
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].postFromImageData = UIImage(data: data)
            } catch {
                print("Error downloading post from image for postID \(post.postID)")
                updatedPosts[index].postFromImageData = UIImage(named: "background_1")
            }

        } else {
            print("Invalid or missing postFromImage for postID \(post.postID), using default image")
            updatedPosts[index].postFromImageData = UIImage(named: "background_1")
        }
    }

    return updatedPosts
}
*/


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


/*
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

*/
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

//ITEMS HELPER FUNCTIONS

//Function I1: Create Posts from API this converts the Post Response into an array of Posts (for items/wishlist)
func createItemsArray(postsResponseModel: PostResponseModel) async throws -> [Post]{
    let postsTemp = postsResponseModel.data
    var postsArray = [Post]()
    
    //STEP 1: Loop over posts and Create Post Objects
    for postModel in postsTemp {

        //STEP 2: Create Post
        let currentPost = Post(postID: postModel.postID)
        currentPost.postType = postModel.postType
        currentPost.groupID = postModel.groupID
        currentPost.groupName = postModel.groupName
        currentPost.groupImage = postModel.groupImage
        currentPost.listID = postModel.listID
        currentPost.postFrom = postModel.postFrom
        currentPost.postFromImage = postModel.postFromImage
        currentPost.postTo = postModel.postTo
        currentPost.postCaption = postModel.postCaption
    
        currentPost.fileName = postModel.fileURL
        currentPost.fileNameServer = postModel.fileURL
        currentPost.fileUrl = postModel.fileURL
        
        currentPost.cloudBucket = postModel.cloudBucket
        currentPost.cloudKey = postModel.cloudKey
        currentPost.videoURL = postModel.videoURL
        currentPost.videoCode = postModel.videoCode
        
        currentPost.postDate = postModel.postDate
        currentPost.postTime = postModel.postTime
        currentPost.timeMessage = postModel.timeMessage
        
        currentPost.created = postModel.created
        currentPost.isLikedByCurrentUser = postModel.isLikedByCurrentUser
        
        //Convert Comments
        currentPost.commentsArray = postModel.commentsArray.map { convertToCommentClass(from: $0) }
        
        currentPost.postLikesArray = postModel.postLikesArray
        currentPost.simpleLikesArray = postModel.simpleLikesArray

        //STEP 3: Add Item-specific data (if item field exists)
        if let item = postModel.item {
            currentPost.itemID = item.item_id
            currentPost.itemName = item.item_name
            currentPost.itemPrice = item.item_price
            currentPost.itemDescription = item.item_description
            currentPost.itemCategory = item.item_category
            currentPost.itemLink = item.item_link
            currentPost.purchased = item.purchased
            currentPost.purchasedBy = item.purchased_by
            currentPost.store = item.store
            currentPost.multipleStores = item.multiple_stores
        }

        //STEP 4: Append to Array
        postsArray.append(currentPost)

    }
    
    return postsArray
}

//Function I2: Add Image to Posts (for items/wishlist)
func addPostImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray
    
    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].postImageData = await imageFunctions.getImageWithFallback(from: post.fileUrl)
    }
    
    return updatedPosts
}

/*
//OLD: Manual validation and download
func addPostImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
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
*/

//Function I3: Add Group Image to Posts (for items/wishlist)
func addGroupImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].groupImageData = await imageFunctions.getImageWithFallback(from: post.groupImage)
    }

    return updatedPosts
}

/*
//OLD: Manual validation and download
func addGroupImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
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
*/

//Function I4: Add Post From Image to Posts (for items/wishlist)
func addPostFromImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        updatedPosts[index].postFromImageData = await imageFunctions.getImageWithFallback(from: post.postFromImage)
    }

    return updatedPosts
}

/*
//OLD: Manual validation and download
func addPostFromImageToItemsArray(postsArray: [Post]) async throws -> [Post] {
    var updatedPosts = postsArray

    for (index, post) in updatedPosts.enumerated() {
        if let postFromImageUrlString = post.postFromImage,
           !postFromImageUrlString.isEmpty,
           postFromImageUrlString.lowercased() != "empty",
           let imageUrl = URL(string: postFromImageUrlString),
           imageUrl.scheme == "http" || imageUrl.scheme == "https" {
            
            do {
                let data = try await imageFunctions.downloadData(from: imageUrl)
                updatedPosts[index].postFromImageData = UIImage(data: data)
            } catch {
                print("Error downloading post from image for postID \(post.postID)")
                updatedPosts[index].postFromImageData = UIImage(named: "background_1")
            }

        } else {
            print("Invalid or missing postFromImage for postID \(post.postID), using default image")
            updatedPosts[index].postFromImageData = UIImage(named: "background_1")
        }
    }

    return updatedPosts
}
*/

func printItemLikes(post: Post) {
    let simpleLikesArray : Array = post.simpleLikesArray ?? []
    for user in simpleLikesArray {
        print("Liked By, \(user)!")
    }
}



