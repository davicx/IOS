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
            print("Error decoding data")
            print(newPostResponseModel)
            return newPostResponseModel
            
        }
    }


    
    //FUNCTIONS B: All Functions Related to getting Posts
    //Function B1: Get all Group Posts
    //func getPostsAPI() async throws -> PostResponseModel {
    func getPostsAPI(groupID: Int) async throws -> PostResponseModel {
        print("GET POSTS!!!")
        
        //let endpoint = "http://localhost:3003/posts/group/72"
        let endpoint = "http://localhost:3003/posts/group/\(groupID)"
        print("URL \(endpoint)")
        
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
            print("Error decoding data")
            return postResponseModel
            
        }
    }
    
    //CHAT
    /*
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
    
    //Function B2: Get all User Posts
    //Function B3: Get Single Post by ID
    //Function B4: Get All Posts
    
    //Function: Download Image
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }

    
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
    
    
     //Function C3: Select all Likes
     //Function C4: Select all Likes for a Post
     //Function C5: Delete a Post
     //Function C5: Edit a Post
 


}
