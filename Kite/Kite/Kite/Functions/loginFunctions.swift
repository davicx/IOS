//
//  loginFunctions.swift
//  Kite
//
//  Created by David Vasquez on 12/24/24.
//

import Foundation


let userDefaultManager = UserDefaultManager()
let loginAPI = LoginAPI()


//Function A1: Login User
func loginUser(userName: String) async throws -> Bool {
    
    
    return true
}

//Function A2: Logout User

//NEW!!!
/*
 import Foundation

 class LoginManager {
     let loginAPI = LoginAPI()
     let userDefaultManager = UserDefaultManager()
     
     func login(username: String, password: String, deviceID: String, completion: @escaping (Bool, String) -> Void) {
         Task {
             do {
                 let loginResponseModel = try await loginAPI.loginUser(username: username, password: password, deviceID: deviceID)
                 
                 if loginResponseModel.data.loginSuccess {
                     let loginOutcome = userDefaultManager.logUserIn(userName: username)
                     if loginOutcome {
                         completion(true, "Login successful for \(username).")
                     } else {
                         completion(false, "Error during login.")
                     }
                 } else {
                     completion(false, "Incorrect username or password.")
                 }
             } catch {
                 completion(false, "An error occurred: \(error.localizedDescription)")
             }
         }
     }
 }

 */

/*
 func loginUser(postsArray: [Post]) async throws -> [Post]{
     for post in postsArray {
         let imageUrl = URL(string: post.fileUrl!)!
         let data = try await networker.downloadImageData(from: imageUrl)
         post.postImageData = UIImage(data: data)
     }
     
    return postsArray
 }

 */
