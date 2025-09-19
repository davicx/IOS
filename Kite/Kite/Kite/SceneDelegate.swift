//
//  SceneDelegate.swift
//  Kite
//
//  Created by David Vasquez on 12/14/24.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        // Main storyboard for Home, Groups, Profile
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        let groupsVC = mainStoryboard.instantiateViewController(withIdentifier: "groupViewControllerID")
        let profileVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")

        // Discover storyboard
        let discoverStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        let discoverVC = discoverStoryboard.instantiateViewController(withIdentifier: "DiscoverViewController")

        // Wrap each in navigation controllers
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let groupsNav = UINavigationController(rootViewController: groupsVC)
        groupsNav.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), tag: 1)

        let discoverNav = UINavigationController(rootViewController: discoverVC)
        discoverNav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 2)

        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)

        // Build tab bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, groupsNav, discoverNav, profileNav]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}


/*
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate from storyboard (make sure storyboard IDs are set!)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        let groupsVC = storyboard.instantiateViewController(withIdentifier: "groupViewControllerID")
        let discoverVC = storyboard.instantiateViewController(withIdentifier: "DiscoverViewController")
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")

        // Embed in navigation controllers (so each tab can push new views)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let groupsNav = UINavigationController(rootViewController: groupsVC)
        groupsNav.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), tag: 1)

        let discoverNav = UINavigationController(rootViewController: discoverVC)
        discoverNav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 2)

        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)

        // Create Tab Bar Controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, groupsNav, discoverNav, profileNav]

        // Set root
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
*/

//ORIGINAL
/*
 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

*/
