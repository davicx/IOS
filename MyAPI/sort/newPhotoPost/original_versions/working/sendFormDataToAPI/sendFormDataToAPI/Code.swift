//
//  Code.swift
//  sendFormDataToAPI
//
//  Created by David Vasquez on 8/12/24.
//


import Foundation
import UIKit




//WORKS
/*
func uploadPost(caption: String, image: UIImage, to url: URL, completion: @escaping (Result<[String: String], Error>) -> Void) {
    // Define boundary
    let boundary = UUID().uuidString
    
    // Create URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    // Create the multipart form data body
    let body = NSMutableData()
    
    // Add postCaption field
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
    body.appendString("\(caption)\r\n")
    
    // Add postImage field
    if let imageData = image.jpegData(compressionQuality: 1.0) {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")
    }
    
    // End of the multipart form data
    body.appendString("--\(boundary)--\r\n")
    
    // Set the request body
    request.httpBody = body as Data
    
    // Create URLSession data task
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Check the response status code
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            let statusCodeError = NSError(domain: "com.example", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error \(httpResponse.statusCode)"])
            completion(.failure(statusCodeError))
            return
        }
        
        // Check if data is not nil
        guard let data = data else {
            let error = NSError(domain: "com.example", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
            completion(.failure(error))
            return
        }
        
        // Parse JSON response
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                completion(.success(json))
            } else {
                let error = NSError(domain: "com.example", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"])
                completion(.failure(error))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

*/
/*
func uploadPost(caption: String, image: UIImage, to url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    // Define boundary
    let boundary = UUID().uuidString
    
    // Create URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    // Create the multipart form data body
    let body = NSMutableData()
    
    // Add postCaption field
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
    body.appendString("\(caption)\r\n")
    
    // Add postImage field
    if let imageData = image.jpegData(compressionQuality: 1.0) {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")
    }
    
    // End of the multipart form data
    body.appendString("--\(boundary)--\r\n")
    
    // Set the request body
    request.httpBody = body as Data
    
    // Create URLSession data task
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let data = data {
            completion(.success(data))
        } else {
            let error = NSError(domain: "com.example", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
            completion(.failure(error))
        }
    }
    
    task.resume()
}

// Extension to NSMutableData for convenience
extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


*/
