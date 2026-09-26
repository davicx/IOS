//
//  Code.swift
//  sendFormDataToAPI
//
//  Created by David Vasquez on 8/12/24.
//


import Foundation
import UIKit


/*
 //
 //  ViewController.swift
 //  sendFormDataToAPI
 //
 //  Created by David Vasquez on 8/11/24.
 //

 import UIKit


 class ViewController: UIViewController {

     let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
     let imageOne: UIImage = UIImage(named: "lake")!
     let imageTwo: UIImage = UIImage(named: "lake_png")!
     
     @IBOutlet weak var imageView: UIImageView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
     }
     
     
     @IBAction func newPhotoPostButton(_ sender: UIButton) {
         print("hi")

         imageView.image = imageOne
         uploadPost(caption: "hiya!!", image: imageOne, to: url) { result in
             switch result {
             case .success(let data):
                 // Handle the successful upload
                 print("Upload successful with data: \(data)")
                 print(result)
             case .failure(let error):
                 // Handle the error
                 print("Upload failed with error: \(error.localizedDescription)")
             }
         }
    
     }
     
     
  
  
     //FUNCTIONS
     //func fromMyAPI(currentUser: String, postTo: String, postCaption: String, groupID: Int) async throws -> NewPostResponseModel {
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


     func fromMyAPI(currentUser: String, postTo: String, postCaption: String, groupID: Int) async throws -> NewPostResponseModel {
         let endpoint = "http://localhost:3003/post/text"
         
         guard let url = URL(string: endpoint) else {
             throw networkError.invalidURL
         }
         
         var request = URLRequest(url: url)
        
     
         let parameters = ["masterSite": "kite","postType": "text", "postFrom": currentUser, "postTo": postTo, "groupID": groupID,"listID": 0, "postCaption":postCaption, "videoURL": "", "videoCode": "","notificationMessage": "Posted a Message", "notificationType": "new_post_text", "notificationLink": "http://localhost:3003/posts/group/72"] as [String : Any]
         
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
             let postResponseModel = NewPostResponseModel()
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
             let postResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

             print("API")
             print(postResponseModel)
             return postResponseModel
             
         } catch {
             let postResponseModel = NewPostResponseModel()
             print("Error decoding data")
             print(postResponseModel)
             return postResponseModel
             
         }
     }
     
     func uploadPostNoResponse(caption: String, image: UIImage, to url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
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

 }



 // Extension to NSMutableData for convenience
 extension NSMutableData {
     func appendString(_ string: String) {
         if let data = string.data(using: .utf8) {
             append(data)
         }
     }
 }



 enum networkError: Error {
     case invalidURL
     case invalidResponse
     case invalidData
 }



 //WORKS

 /*
  import UIKit


  class ViewController: UIViewController {

      let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
      let imageOne: UIImage = UIImage(named: "lake")!
      let imageTwo: UIImage = UIImage(named: "lake_png")!
      
      @IBOutlet weak var imageView: UIImageView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          
      }
      
      
      @IBAction func newPhotoPostButton(_ sender: UIButton) {
          print("hi")

          imageView.image = imageOne
          uploadPost(caption: "hiya!!", image: imageOne, to: url) { result in
              switch result {
              case .success(let data):
                  // Handle the successful upload
                  print("Upload successful with data: \(data)")
                  print(result)
              case .failure(let error):
                  // Handle the error
                  print("Upload failed with error: \(error.localizedDescription)")
              }
          }
     
      }
      
      
   
   
      //FUNCTIONS
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


 //SORT OF WORKS


 /*
  import UIKit

  class ViewController: UIViewController {

      let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
      //let imageArray: [UIImage] = [UIImage(named: "lake")!, UIImage(named: "lake_png")!]
      let imageArray: [UIImage] = [UIImage(named: "lake")!]
      let boundary: String = "Boundary-\(UUID().uuidString)"
      
      @IBOutlet weak var imageView: UIImageView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          
      }
      
      
      @IBAction func newPhotoPostButton(_ sender: UIButton) {
          print("hi")
          let requestBody = self.multipartFormDataBody(self.boundary, "Hiya!", self.imageArray)
          let request = self.generateRequest(httpBody: requestBody)
          
          URLSession.shared.dataTask(with: request) { data, resp, error in
              if let error = error {
                  print(error)
                  return
              }
              
              
              print(resp)
              print("success")
          }.resume()
          
      }
      
      private func generateRequest(httpBody: Data) -> URLRequest {
          var request = URLRequest(url: self.url)
          request.httpMethod = "POST"
          request.httpBody = httpBody
          request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
          return request
      }
      
      private func multipartFormDataBody(_ boundary: String, _ postCaption: String, _ images: [UIImage]) -> Data {
          
          let lineBreak = "\r\n"
          var body = Data()
          body.append("--\(boundary + lineBreak)")
          body.append("Content-Disposition: form-data; name=\"postCaption\"\(lineBreak + lineBreak)")
          body.append("\(postCaption + lineBreak)")
          
          for image in images {
              if let uuid = UUID().uuidString.components(separatedBy: "-").first {
                  body.append("--\(boundary + lineBreak)")
                  body.append("Content-Disposition: form-data; name=\"postImage\"; filename=\"\(uuid).jpg\"\(lineBreak)")
                  body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                  body.append(image.jpegData(compressionQuality: 0.99)!)
                  body.append(lineBreak)
              }
          }
          
          body.append("--\(boundary)--\(lineBreak)") // End multipart form and return
          return body
      }

      

  }

  extension Data {
      mutating func append(_ string: String) {
          if let data = string.data(using: .utf8) {
              self.append(data)
          }
      }
  }


  */

 */



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
