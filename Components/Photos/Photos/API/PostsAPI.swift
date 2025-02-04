//
//  PostsAPI.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
//

import UIKit


class PostsAPI {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    //FUNCTIONS A
    //Function A1: Make Photo Post
    func makePhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
        let postType = "photo"
        let masterSite = "kite"
        let notificationMessage = "Posted a Photo"
        let notificationType = "new_post_photo"
        let notificationLink = "http://localhost:3003/posts/group/72"
        
            
        //STEP 1: Create the URL
        let endpoint = "http://localhost:3003/post/photo/local"
        
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

    //Function A2: Get all Group Posts
    func getPostsAPI() async throws -> PostResponseModel {
        let endpoint = "http://localhost:3003/posts/group/72"
        
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
    
    //Function: Download Image
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }


}
