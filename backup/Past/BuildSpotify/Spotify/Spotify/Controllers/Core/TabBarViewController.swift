//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Vasquez, Charles Geoffrey David [C] on 1/7/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarVC = UITabBarController()

        //let vc1 = HomeViewController()
        //let vc2 = SearchViewController()
        //let vc3 = LibraryViewController()
        

        //let vc1.navigationItem.largeTitleDisplayMode = .always
        //let vc2.navigationItem.largeTitleDisplayMode = .always
        //let vc3.navigationItem.largeTitleDisplayMode = .always
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: LibraryViewController())
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"


        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        tabBarVC.setViewControllers([nav1, nav1, nav3], animated: false)
        //tabBarVC.modalPresentationStyle = .fullScreen
        //present(tabBarVC, animated: true)
        

    }
    


}
