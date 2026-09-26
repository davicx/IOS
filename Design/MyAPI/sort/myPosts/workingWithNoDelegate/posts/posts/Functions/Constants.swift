//
//  Constants.swift
//  posts
//
//  Created by David Vasquez on 8/22/24.
//

import Foundation


struct Constants {
    
    struct VariableConstants {
        static let tempURL = ""
    }
    
    struct Segue {
        //this connects the two screens
        static let showOnboardingScreen = "showIndividualPost"
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



//SEGUES
//showIndividualPost this connects the two screens
