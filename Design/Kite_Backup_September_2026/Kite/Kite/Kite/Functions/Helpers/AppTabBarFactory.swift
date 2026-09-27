//
//  AppTabBarFactory.swift
//  Kite
//
//  Created by David Vasquez on 9/20/25.
//

import UIKit


class AppTabBar {

    static func setupTabBar() -> UITabBarController {

        //STORYBOARDS
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let groupsStoryboard = UIStoryboard(name: "Groups", bundle: nil)
        let discoverStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)

        //VIEW CONTROLLERS
        let homeViewController = homeStoryboard.instantiateViewController(
            withIdentifier: "HomeViewController"
        )
        let listsViewController = groupsStoryboard.instantiateViewController(
            withIdentifier: "groupViewControllerID"
        )
        let discoverViewController = discoverStoryboard.instantiateViewController(
            withIdentifier: "DiscoverViewController"
        )
        let profileViewController = profileStoryboard.instantiateViewController(
            withIdentifier: "ProfileViewController"
        )

        //NAVIGATION
        let homeNavigation = UINavigationController(rootViewController: homeViewController)
        homeNavigation.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )

        let listsNavigation = UINavigationController(rootViewController: listsViewController)
        listsNavigation.tabBarItem = UITabBarItem(
            title: "Lists",
            image: UIImage(systemName: "list.bullet.rectangle"),
            tag: 1
        )

        let discoverNavigation = UINavigationController(rootViewController: discoverViewController)
        discoverNavigation.tabBarItem = UITabBarItem(
            title: "Discover",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 2
        )

        let profileNavigation = UINavigationController(rootViewController: profileViewController)
        profileNavigation.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 3
        )

        //TAB BAR
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeNavigation,
            listsNavigation,
            discoverNavigation,
            profileNavigation
        ]
        tabBarController.tabBar.tintColor = Colors.primaryPink

        return tabBarController
    }
}
