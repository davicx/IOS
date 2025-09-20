//
//  AppTabBarFactory.swift
//  Kite
//
//  Created by David Vasquez on 9/20/25.
//

import UIKit

class AppTabBarFactory: UIViewController {

    static func makeMainTabBar() -> UITabBarController {
        
        // MAIN: Main storyboard for Home, Groups
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        let groupsVC = mainStoryboard.instantiateViewController(withIdentifier: "groupViewControllerID")

        
        //HOME: Home Storyboard 
        
        // DISCOVER: Discover storyboard
        let discoverStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        let discoverVC = discoverStoryboard.instantiateViewController(withIdentifier: "DiscoverViewController")

        // PROFILE: Profile storyboard
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
        
        

        // NAVIGATION: Wrap each in navigation controllers
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let groupsNav = UINavigationController(rootViewController: groupsVC)
        groupsNav.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), tag: 1)

        let discoverNav = UINavigationController(rootViewController: discoverVC)
        discoverNav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 2)

        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)

        // TAB BAR: Build tab bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, groupsNav, discoverNav, profileNav]

        return tabBarController
    }
}

/*
class AppTabBarFactory: UIViewController {

    static func makeMainTabBar() -> UITabBarController {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        let groupsVC = mainStoryboard.instantiateViewController(withIdentifier: "groupViewControllerID")
        
        
        
        let discoverStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        let discoverVC = discoverStoryboard.instantiateViewController(withIdentifier: "DiscoverViewController")
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
 
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let groupsNav = UINavigationController(rootViewController: groupsVC)
        groupsNav.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), tag: 1)
        
        let discoverNav = UINavigationController(rootViewController: discoverVC)
        discoverNav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, groupsNav, discoverNav, profileNav]
        
        return tabBarController
    }
}
*/
