//
//  AuthManager.swift
//  Kite
//
//  Created by David Vasquez on 2/3/25.
//


import Foundation


class AuthManager {
    static let shared = AuthManager()
    
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
