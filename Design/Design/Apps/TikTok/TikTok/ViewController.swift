//
//  ViewController.swift
//  TikTok
//
//  Created by David Vasquez on 11/24/24.
//

import UIKit


class ViewController: UIViewController {

    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        // Set background colors for visibility
        headerView.backgroundColor = .systemBlue
        bodyView.backgroundColor = .systemGreen
        footerView.backgroundColor = .systemRed

        // Add views to the main view
        view.addSubview(headerView)
        view.addSubview(bodyView)
        view.addSubview(footerView)

        // Disable autoresizing mask translation
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints
        NSLayoutConstraint.activate([
            // Header view constraints
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),

            // Footer view constraints
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60),

            // Body view constraints
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
}


/*
 class ViewController: UIViewController {
 let headerView = UIView()
 let bodyView = UIView()
 let footerView = UIView()
 
 let headerHeight = CGFloat(40.0)
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 setUpHeaderView()
 setUpBodyView()
 setUpFooterView()
 
 }
 
 func setUpHeaderView() {
 headerView.backgroundColor = .systemPink
 view.addSubview(headerView)
 
 headerView.translatesAutoresizingMaskIntoConstraints = false
 
 NSLayoutConstraint.activate([
 headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
 headerView.heightAnchor.constraint(equalToConstant: headerHeight),
 headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
 headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
 ])
 
 }
 
 func setUpBodyView() {
 
 bodyView.backgroundColor = .systemBlue
 
 // Add the views to the main view
 view.addSubview(bodyView)
 
 // Disable autoresizing masks for Auto Layout
 bodyView.translatesAutoresizingMaskIntoConstraints = false
 
 // Left View
 NSLayoutConstraint.activate([
 bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
 bodyView.leftAnchor.constraint(equalTo: view.leftAnchor),
 bodyView.rightAnchor.constraint(equalTo: view.rightAnchor),
 bodyView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
 ])
 
 }
 
 func setUpFooterView() {
 
 footerView.backgroundColor = .systemGreen
 
 // Add the views to the main view
 view.addSubview(footerView)
 
 // Disable autoresizing masks for Auto Layout
 footerView.translatesAutoresizingMaskIntoConstraints = false
 
 // Left View
 NSLayoutConstraint.activate([
 footerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120.0),
 footerView.heightAnchor.constraint(equalToConstant: 80.0),
 footerView.leftAnchor.constraint(equalTo: view.leftAnchor),
 footerView.rightAnchor.constraint(equalTo: view.rightAnchor),
 
 ])
 }
 
 
 
 
 
 func setUpHeaderViewInside() {
 
 
 //VIEWS
 let leftView = UIView()
 let rightView = UIView()
 let dividerView = UIView()
 
 
 
 // Set background colors for visibility
 leftView.backgroundColor = .systemBlue
 rightView.backgroundColor = .systemGreen
 dividerView.backgroundColor = .black
 
 // Add the views to the main view
 view.addSubview(leftView)
 view.addSubview(rightView)
 view.addSubview(dividerView)
 
 // Disable autoresizing masks for Auto Layout
 leftView.translatesAutoresizingMaskIntoConstraints = false
 dividerView.translatesAutoresizingMaskIntoConstraints = false
 rightView.translatesAutoresizingMaskIntoConstraints = false
 
 
 // Left View
 NSLayoutConstraint.activate([
 leftView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
 leftView.heightAnchor.constraint(equalToConstant: headerHeight),
 leftView.trailingAnchor.constraint(equalTo: dividerView.leadingAnchor),
 leftView.widthAnchor.constraint(equalTo: rightView.widthAnchor),
 
 ])
 
 // Divider View
 NSLayoutConstraint.activate([
 rightView.heightAnchor.constraint(equalToConstant: headerHeight),
 rightView.leftAnchor.constraint(equalTo: dividerView.leftAnchor),
 rightView.rightAnchor.constraint(equalTo: view.rightAnchor),
 rightView.topAnchor.constraint(equalTo: leftView.topAnchor),
 ])
 
 // Right View
 NSLayoutConstraint.activate([
 dividerView.heightAnchor.constraint(equalToConstant: headerHeight),
 dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 dividerView.topAnchor.constraint(equalTo: leftView.topAnchor),
 dividerView.widthAnchor.constraint(equalToConstant: 2),
 ])
 
 //LABELS
 // Create labels
 let followingLabel = UILabel()
 let forYouLabel = UILabel()
 
 // Set label properties
 followingLabel.text = "Following"
 forYouLabel.text = "For You"
 
 followingLabel.textColor = UIColor.white
 forYouLabel.textColor = UIColor.white
 
 followingLabel.textAlignment = .right
 forYouLabel.textAlignment = .left
 
 // Add labels to the views
 leftView.addSubview(followingLabel)
 rightView.addSubview(forYouLabel)
 
 // Disable autoresizing masks for Auto Layout
 followingLabel.translatesAutoresizingMaskIntoConstraints = false
 forYouLabel.translatesAutoresizingMaskIntoConstraints = false
 
 // Define Auto Layout constraints for label1
 NSLayoutConstraint.activate([
 followingLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 10),
 followingLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -10),
 followingLabel.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 10),
 followingLabel.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -10)
 ])
 
 // Define Auto Layout constraints for label2
 NSLayoutConstraint.activate([
 forYouLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 10),
 forYouLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -10),
 forYouLabel.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 10),
 forYouLabel.bottomAnchor.constraint(equalTo: rightView.bottomAnchor, constant: -10)
 ])
 
 }
 
 
 
 
 }
 
 */
