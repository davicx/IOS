//
//  Constants.swift
//  Kite
//
//  Created by David Vasquez on 12/7/24.
//

import UIKit


struct Constants {

    struct Segue {
        //static let showLogin = "showLoginPage"
        //static let showRegistrationScreen = "showRegistrationPage"
        //static let showMainTabBarController = "showMainTabBarController"
        //static let showEditProfileViewController = "showEditProfileViewController"
        static let showIndividualPost = "showIndividualPost"
    
    }
    
    struct StoryboardID {
        static let main = "Main"
        static let mainTabBarController = "MainTabBarController"
        static let onboardingViewController = "MainOnboardingViewController"
        //static let friendProfileViewControllerID = "FriendProfileViewControllerID"
        static let individualGroupViewControllerID = "individualGroupViewControllerID"
        static let individualGroupUserViewControllerID = "individualGroupUserViewControllerID"
        //static let individualListViewControllerID = "individualListViewControllerID"
    }
    
    //HomeViewController GroupsViewController DiscoverViewController ProfileViewController
    //MAIN PAGES
    struct StoryboardApp {
        static let homeViewController = "HomeViewController"
        static let groupsViewController = "GroupsViewController" //TEMP idea but change all others match groupViewControllerID
        static let discoverViewController = "DiscoverViewController"
        static let profileViewController = "ProfileViewController"
    }
    
    struct StoryboardNames {
        static let homeStoryboard = "Home"
        static let groupsStoryboard = "Groups" //TEMP idea but change all others match groupViewControllerID
        static let discoverStoryboard = "Discover"
        static let profileStoryboard = "Profile"
        static let postStoryboard = "Post"
    }
    
    
    
    //Image Constants
    struct Image {
        static let liked = "liked"
        static let unliked = "like"
        static let fallbackPostImage = "background_10"
    }
    
    struct TableViewCellIdentifier {
        static let post = "PostCell"
        static let homePostCell = "HomePostCell"
        static let comment = "CommentCell"
        static let friendCell = "friendCell"

    }
    
    static let cornerRadius: CGFloat = 8.0

    struct VariableConstants {
        static let tempURL = ""
    }

}



//static let groupViewControllerID = "groupViewControllerID"
//static let listsViewControllerID = "listsViewControllerID"
//static let showOnboardingScreen = "showOnboarding"
//static let showRegister = "showRegister"
