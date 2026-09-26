//
//  Functions.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


struct Constants {
    
    struct VariableConstants {
        static let tempURL = ""
    }
    
    struct Segue {
        static let showOnboardingScreen = "showOnboarding"
    }
    
    struct StoryboardID {
        static let main = "Main"
        static let mainTabBarController = "MainTabBarController"
        static let onboardingViewController = "OnboardingViewController"
               
    }
}


enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


