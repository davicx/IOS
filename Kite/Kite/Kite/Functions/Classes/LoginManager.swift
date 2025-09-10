//
//  AuthManager.swift
//  Kite
//
//  Created by David Vasquez on 2/3/25.
//


import Foundation


class LoginManager {
    static let shared = LoginManager()
    
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()

    private init() {} // Ensures singleton usage

    //Function A1: Login User
    func loginUser(username: String, password: String, deviceID: String, completion: @escaping (Bool, String) -> Void) {
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
    
  
    //Function A2: Logout Current User
    func logoutCurrentUser() {
        
        let loggedInUser = userDefaultManager.getLoggedInUser()
        
        // STEP 1: Set User Defaults
        let loginOutcome = userDefaultManager.logUserOut()
        
        if loginOutcome {
            print("You just logged out")
        } else {
            print("Was an error logging out!")
        }
        
        // STEP 2: Call Logout API
        Task {
            do {
                //let deviceID = getDeviceId()
                let deviceID = KeychainHelper.shared.getOrCreateDeviceId()
                print("Device ID:", deviceID)

                let logoutResponseModel = try await loginAPI.logoutUser(username: loggedInUser, deviceID: deviceID)
                
                print(logoutResponseModel)
                
                if logoutResponseModel.success == true {
                    print("API Logout worked!")
                } else {
                    print("API encountered an error while logging out!")
                }
                
            } catch {
                print("Error during logout!")
                print(error)
            }
        }
        
        // STEP 3: Navigate to Login Screen
        PresenterManager.shared.showOnboarding()
         
        print("AUTH MANAGER: Logout User")
    }
    

    //Function A3: Get Logged In User Status
    func getLoggedInUserStatus(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                // Get the current logged in user from UserDefaults
                let currentUser = userDefaultManager.getLoggedInUser()
                
                if currentUser.isEmpty {
                    // No user is logged in
                    completion(false)
                    return
                }
                
                let loginStatusResponse = try await loginAPI.getLoggedInUserStatus(userName: currentUser)
                
                if loginStatusResponse.success {
                    // Return the login status from the API response
                    completion(loginStatusResponse.data.userLoggedIn)
                } else {
                    // API call failed, assume not logged in
                    completion(false)
                }
            } catch {
                // Error occurred, assume not logged in
                print("Error checking login status: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}



/*
class LoginManager {
    static let shared = LoginManager()
    
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()

    private init() {} // Ensures singleton usage

    func logoutCurrentUser() {
        
        let loggedInUser = userDefaultManager.getLoggedInUser()
        
        // STEP 1: Set User Defaults
        let loginOutcome = userDefaultManager.logUserOut()
        
        if loginOutcome {
            print("You just logged out")
        } else {
            print("Was an error logging out!")
        }
        
        // STEP 2: Call Logout API
        Task {
            do {
                //let deviceID = getDeviceId()
                let deviceID = KeychainHelper.shared.getOrCreateDeviceId()
                print("Device ID:", deviceID)

                let logoutResponseModel = try await loginAPI.logoutUser(username: loggedInUser, deviceID: deviceID)
                
                print(logoutResponseModel)
                
                if logoutResponseModel.success == true {
                    print("API Logout worked!")
                } else {
                    print("API encountered an error while logging out!")
                }
                
            } catch {
                print("Error during logout!")
                print(error)
            }
        }
        
        // STEP 3: Navigate to Login Screen
        PresenterManager.shared.showOnboarding()
         
        print("AUTH MANAGER: Logout User")
    }
}
*/

/*
 //
 //  AuthManager.swift
 //  Kite
 //
 //  Created by David Vasquez on 2/3/25.
 //


 import Foundation



 */
