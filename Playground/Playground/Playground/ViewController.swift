//
//  ViewController.swift
//  Playground
//
//  Created by David Vasquez on 12/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        //setupConstraints()
        setBackgroundImage()
    }
    
    
    private func setBackgroundImage() {
         let backgroundImage = UIImageView(frame: view.bounds)
         backgroundImage.image = UIImage(named: "background_2")
         backgroundImage.contentMode = .scaleAspectFill
         backgroundImage.clipsToBounds = true
         backgroundImage.translatesAutoresizingMaskIntoConstraints = false

         view.insertSubview(backgroundImage, at: 0) // Places it behind all other views

         NSLayoutConstraint.activate([
             backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
             backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
    
    
    
    
    // MARK: - UI Elements
    // Status Bar Elements
    private let statusBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:41"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signalIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right") // Signal icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wifiIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wifi") // Wi-Fi icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let batteryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "battery.75") // Battery icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Main Content
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Evently"
        label.font = UIFont(name: "Billabong", size: 50) ?? UIFont.systemFont(ofSize: 50) // Approx Instagram font
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder") // Replace with your image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "jacob_w"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0) // Instagram blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let switchAccountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Switch accounts"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(statusBarView)
        statusBarView.addSubview(timeLabel)
        statusBarView.addSubview(signalIcon)
        statusBarView.addSubview(wifiIcon)
        statusBarView.addSubview(batteryIcon)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(loginButton)
        view.addSubview(switchAccountsLabel)
        view.addSubview(signUpLabel)
        
        // Add tap gesture to switch accounts label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchAccountsTapped))
        switchAccountsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        // Status Bar Constraints
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 20), // Status bar height
            
            timeLabel.centerXAnchor.constraint(equalTo: statusBarView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            
            signalIcon.trailingAnchor.constraint(equalTo: wifiIcon.leadingAnchor, constant: -8),
            signalIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            signalIcon.widthAnchor.constraint(equalToConstant: 15),
            signalIcon.heightAnchor.constraint(equalToConstant: 15),
            
            wifiIcon.trailingAnchor.constraint(equalTo: batteryIcon.leadingAnchor, constant: -8),
            wifiIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            wifiIcon.widthAnchor.constraint(equalToConstant: 15),
            wifiIcon.heightAnchor.constraint(equalToConstant: 15),
            
            batteryIcon.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor, constant: -8),
            batteryIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            batteryIcon.widthAnchor.constraint(equalToConstant: 25),
            batteryIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        // Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: statusBarView.bottomAnchor, constant: 100) // Adjusted for image
        ])
        
        // Profile Image Constraints
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Username Label Constraints
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
        ])
        
        // Login Button Constraints
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Switch Accounts Label Constraints
        NSLayoutConstraint.activate([
            switchAccountsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchAccountsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
        
        // Sign Up Label Constraints
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func switchAccountsTapped() {
        print("Switch accounts tapped")
        // Add switch accounts logic here
    }
}
