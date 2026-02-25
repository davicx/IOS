//
//  PostsAPI.swift
//  Kite
//
//  Created by David Vasquez on 12/14/24.
//


import UIKit

/*
FUNCTIONS A: All Functions Related to Posts
    1) Function A1: Post Text
    2) Function A2: Post Photo
    3) Function A3: Post Video
    4) Function A4: Post Article
    5) Function A5: Post Item
 
FUNCTIONS B: All Functions Related to getting Posts
    1) Function B1: Get all Group Posts
    2) Function B2: Get all User Posts
    3) Function B3: Get Single Post by ID
    4) Function B4: Get All Posts

FUNCTIONS C: All Functions Related to Post Actions
    1) Function C1: Like a Post
    2) Function C2: Unlike a Post
    3) Function C3: Select all Likes
    4) Function C4: Select all Likes for a Post
    5) Function C5: Delete a Post
    6) Function C5: Edit a Post
 
 FUNCTIONS D: All Functions Related to Items
     1) Function D1: Purchase an Item
     2) Function D2: Remove a Purchase for an Item


*/

class PostsAPI {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    //FUNCTIONS A
    //Function A1: Make Text Post
    func makeTextPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
        let postType = "text"
        let masterSite = "kite"
        let notificationMessage = "Posted Text"
        let notificationType = "new_post_text"
        let notificationLink = "http://localhost:3003/post/text"
        
            
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/post/text"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        //STEP 2: Create the Request
        var request = URLRequest(url: url)
        
        let parameters = ["masterSite": masterSite, "postType": postType, "postFrom": postFrom, "postTo": postTo, "groupID": groupID, "listID": listID, "postCaption": postCaption, "videoURL": "", "notificationMessage": notificationMessage, "notificationType": notificationType, "notificationLink": notificationLink] as [String : Any]

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let postResponseModel = NewPostResponseModel()
            print("Error setting JSON")
            return postResponseModel
        }
        
        request.httpBody = httpBody

        //STEP 3: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

            print("API")
            print(newPostResponseModel)
            print("API")
            return newPostResponseModel
            
        } catch {
            let newPostResponseModel = NewPostResponseModel()
            print("Error decoding data")
            print(newPostResponseModel)
            return newPostResponseModel
            
        }
    }
    
    //Function A2: Make Photo Post
    func makePhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
        let postType = "photo"
        let masterSite = "kite"
        let notificationMessage = "Posted a Photo"
        let notificationType = "new_post_photo"
        //http://localhost:3003/post/photo
        let notificationLink = "http://localhost:3003/posts/group/72"
        
            
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/post/photo"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        //STEP 2: Create the Request
        var request = URLRequest(url: url)
        let boundary = UUID().uuidString
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //STEP 3: Create the Form Data and Photo
        let body = NSMutableData()

    
        //Post Type
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postType\"\r\n\r\n")
        body.appendString("\(postType)\r\n")
            
        //Master Site
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"masterSite\"\r\n\r\n")
        body.appendString("\(masterSite)\r\n")

        //Post From
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postFrom\"\r\n\r\n")
        body.appendString("\(postFrom)\r\n")
        
        //Post To
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postTo\"\r\n\r\n")
        body.appendString("\(postTo)\r\n")
       
        //Group ID
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"groupID\"\r\n\r\n")
        body.appendString("\(groupID)\r\n")
        
        //List ID
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"listID\"\r\n\r\n")
        body.appendString("\(listID)\r\n")
        
        //Post Caption
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
        body.appendString("\(postCaption)\r\n")
        
        //Notification Message
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationMessage\"\r\n\r\n")
        body.appendString("\(notificationMessage)\r\n")
        
        //Notification Type
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationType\"\r\n\r\n")
        body.appendString("\(notificationType)\r\n")
        
        //Notification Link
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationLink\"\r\n\r\n")
        body.appendString("\(notificationLink)\r\n")
    
        if let imageData = postImage.jpegData(compressionQuality: 1.0) {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.appendString("\r\n")
        }
        
        body.appendString("--\(boundary)--\r\n")
        
        request.httpBody = body as Data
        
        //STEP 4: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

            print("API")
            print(newPostResponseModel)
            print("API")
            return newPostResponseModel
            
        } catch {
            let newPostResponseModel = NewPostResponseModel()
            print("Error decoding data YOOO")
            print(newPostResponseModel)
            return newPostResponseModel
            
        }
    }
    
    //Function A5: Post Item
    func makeItemPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int, itemName: String, itemPrice: String, itemDescription: String, itemLink: String) async throws -> NewPostResponseModel {
        let postType = "item"
        let masterSite = "wishlist"
        let notificationMessage = "Posted a New Item"
        let notificationType = "new_item"
        let notificationLink = "http://localhost:3003/posts/group/72"
        let itemCategory = "video_games"
        
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/post/item"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        //STEP 2: Create the Request
        var request = URLRequest(url: url)
        let boundary = UUID().uuidString
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //STEP 3: Create the Form Data and Photo
        let body = NSMutableData()

        //Post Type
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postType\"\r\n\r\n")
        body.appendString("\(postType)\r\n")
            
        //Master Site
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"masterSite\"\r\n\r\n")
        body.appendString("\(masterSite)\r\n")

        //Post From
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postFrom\"\r\n\r\n")
        body.appendString("\(postFrom)\r\n")
        
        //Post To
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postTo\"\r\n\r\n")
        body.appendString("\(postTo)\r\n")
       
        //Group ID
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"groupID\"\r\n\r\n")
        body.appendString("\(groupID)\r\n")
        
        //List ID
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"listID\"\r\n\r\n")
        body.appendString("\(listID)\r\n")
        
        //Post Caption
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
        body.appendString("\(postCaption)\r\n")
        
        //Item Name
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"itemName\"\r\n\r\n")
        body.appendString("\(itemName)\r\n")
        
        //Item Price
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"itemPrice\"\r\n\r\n")
        body.appendString("\(itemPrice)\r\n")
        
        //Item Description
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"itemDescription\"\r\n\r\n")
        body.appendString("\(itemDescription)\r\n")
        
        //Item Link
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"itemLink\"\r\n\r\n")
        body.appendString("\(itemLink)\r\n")
        
        //Item Category
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"itemCategory\"\r\n\r\n")
        body.appendString("\(itemCategory)\r\n")
        
        //Notification Message
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationMessage\"\r\n\r\n")
        body.appendString("\(notificationMessage)\r\n")
        
        //Notification Type
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationType\"\r\n\r\n")
        body.appendString("\(notificationType)\r\n")
        
        //Notification Link
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"notificationLink\"\r\n\r\n")
        body.appendString("\(notificationLink)\r\n")
    
        if let imageData = postImage.jpegData(compressionQuality: 1.0) {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.appendString("\r\n")
        }
        
        body.appendString("--\(boundary)--\r\n")
        
        request.httpBody = body as Data
        
        //STEP 4: Handle the Response
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

            print("API")
            print(newPostResponseModel)
            print("API")
            return newPostResponseModel
            
        } catch {
            print("Error decoding data YOOO")
            print("Decoding error: \(error)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch for type \(type): \(context.debugDescription)")
                    print("Coding path: \(context.codingPath)")
                case .valueNotFound(let type, let context):
                    print("Value not found for type \(type): \(context.debugDescription)")
                    print("Coding path: \(context.codingPath)")
                case .keyNotFound(let key, let context):
                    print("Key not found: \(key.stringValue) - \(context.debugDescription)")
                    print("Coding path: \(context.codingPath)")
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                    print("Coding path: \(context.codingPath)")
                @unknown default:
                    print("Unknown decoding error")
                }
            }
            
            // Print raw response data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            let newPostResponseModel = NewPostResponseModel()
            return newPostResponseModel
            
        }
    }


    //FUNCTIONS B: All Functions Related to getting Posts
    //Function B1: Get all Group Posts
    func getPostsAPI(groupID: Int) async throws -> PostResponseModel {
        //print("GET POSTS!!!")
        
        //let endpoint = "http://localhost:3003/posts/group/72"
  
        let endpoint = "http://localhost:3003/posts/group/\(groupID)"
        //print("URL \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postResponseModel = try decoder.decode(PostResponseModel.self, from: data)
      
            return postResponseModel
            
        } catch {
            let postResponseModel = PostResponseModel()
            print("Error decoding data: \(error)")


            print("Error decoding data")
            return postResponseModel
            
        }
    }
  
    //Function B2: Get all Group Items
    func getItemsAPI(groupID: Int) async throws -> PostResponseModel {
        //print("GET ITEMS!!!")
        
        let endpoint = "http://localhost:3003/items/group/\(groupID)"
        //print("URL \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postsResponseModel = try decoder.decode(PostResponseModel.self, from: data)
      
            return postsResponseModel
            
        } catch {
            let postsResponseModel = PostResponseModel()
            print("Error decoding data: \(error)")


            print("Error decoding data")
            return postsResponseModel
            
        }
    }
    

    
    //Function B3: Get all User Posts
    //Function B4: Get Single Post by ID
    //Function B5: Get All Posts
    

    //FUNCTIONS C: All Functions Related to Post Actions
    //Function C1: Like a Post
    func likePostAPI(currentUser: String, postID: Int, groupID: Int) async throws -> LikePostResponseModel {
        let endpoint = "http://localhost:3003/post/like"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
       
        //Not sure what to use
        //let parameters = ["currentUser": "davey", "postID": 72, "groupID": 72] as [String : Any]
        let parameters = ["currentUser": currentUser, "postID": postID, "groupID": groupID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let postResponseModel = LikePostResponseModel()
            print("Error setting JSON")
            return postResponseModel
        }
        
        request.httpBody = httpBody
      
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postResponseModel = try decoder.decode(LikePostResponseModel.self, from: data)

            return postResponseModel
            
        } catch {
            let postResponseModel = LikePostResponseModel()
            print("Error decoding data")
            return postResponseModel
            
        }
    }
    

    //Function C2: Unlike a Post
    func unlikePostAPI(currentUser: String, postID: Int, groupID: Int) async throws -> LikePostResponseModel {
        let endpoint = "http://localhost:3003/post/unlike"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
       
        //Not sure what to use
        //let parameters = ["currentUser": "davey", "postID": 72, "groupID": 72] as [String : Any]
        let parameters = ["currentUser": currentUser, "postID": postID, "groupID": groupID] as [String : Any]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let postResponseModel = LikePostResponseModel()
            print("Error setting JSON")
            return postResponseModel
        }
        
        request.httpBody = httpBody
      
        let (data, response) = try await URLSession.shared.data(for: request)
               
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            let postResponseModel = try decoder.decode(LikePostResponseModel.self, from: data)

            return postResponseModel
            
        } catch {
            let postResponseModel = LikePostResponseModel()
            print("Error decoding data")
            return postResponseModel
            
        }
    }
    
    
    //FUNCTIONS D: All Functions Related to Items
    //Function D1: Purchase an Item
    func purchaseItemAPI(currentUser: String, postID: Int, itemID: Int, showPurchased: [String]) async throws -> PurchaseItemResponseModel {
        let endpoint = "http://localhost:3003/items/purchase/add"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        let parameters: [String: Any] = [
            "currentUser": currentUser,
            "postID": postID,
            "itemID": itemID,
            "showPurchased": showPurchased
        ]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let responseModel = PurchaseItemResponseModel()
            print("Error setting JSON")
            return responseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(PurchaseItemResponseModel.self, from: data)
            return responseModel
        } catch {
            let responseModel = PurchaseItemResponseModel()
            print("Error decoding data")
            return responseModel
        }
    }
    
    
    //Function D2: Remove a Purchase for an Item
    func removeItemPurchaseAPI(currentUser: String, postID: Int, itemID: Int) async throws -> PurchaseItemResponseModel {
        let endpoint = "http://localhost:3003/items/purchase/remove"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        let parameters: [String: Any] = [
            "currentUser": currentUser,
            "postID": postID,
            "itemID": itemID
        ]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let responseModel = PurchaseItemResponseModel()
            print("Error setting JSON")
            return responseModel
        }
        
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(PurchaseItemResponseModel.self, from: data)
            return responseModel
        } catch {
            let responseModel = PurchaseItemResponseModel()
            print("Error decoding data")
            return responseModel
        }
    }
    
    
     //Function C3: Select all Likes
     //Function C4: Select all Likes for a Post
     //Function C5: Delete a Post
     //Function C5: Edit a Post
 


}


//APPENDIX
/*
 do {
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .useDefaultKeys // or .convertFromSnakeCase if needed
     let decoded = try decoder.decode(PostResponseModel.self, from: jsonData)
     print("Decoded successfully!")
 } catch {
     print("Decoding error: \(error)")
 }

 func getPostsAPI(groupID: Int) async throws -> PostResponseModel {
     let endpoint = "http://localhost:3003/posts/group/\(groupID)"
     
     guard let url = URL(string: endpoint) else {
         throw networkError.invalidURL
     }
     
     let apiURL = URLRequest(url: url)
     
     let (data, response) = try await URLSession.shared.data(for: apiURL)
            
     guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
         throw networkError.invalidResponse
     }
     
     do {
         let decoder = JSONDecoder()
         let postResponseModel = try decoder.decode(PostResponseModel.self, from: data)

         return postResponseModel
         
     } catch {
         print("Error decoding data:", error)
         throw error
     }
 }

 */
