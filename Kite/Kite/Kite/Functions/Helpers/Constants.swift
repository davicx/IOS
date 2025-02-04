//
//  Constants.swift
//  Kite
//
//  Created by David Vasquez on 12/7/24.
//

import UIKit


struct Constants {
    
    static let cornerRadius: CGFloat = 8.0
    
    struct VariableConstants {
        static let tempURL = ""
    }
    
    struct Segue {
        static let showLogin = "showLoginPage"
        static let showRegistrationScreen = "showRegistrationPage"
        static let showMainTabBarController = "showMainTabBarController"
        static let showEditProfileViewController = "showEditProfileViewController"
        
        //static let showOnboardingScreen = "showOnboarding"
        //static let showRegister = "showRegister"
        
    }
    
    struct StoryboardID {
        static let main = "Main"
        static let mainTabBarController = "MainTabBarController"
        static let onboardingViewController = "MainOnboardingViewController"
    }
}
