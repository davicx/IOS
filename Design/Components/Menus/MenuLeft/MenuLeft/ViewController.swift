//
//  ViewController.swift
//  MenuLeft
//
//  Created by David Vasquez on 7/11/25.
//

import UIKit


class ViewController: UIViewController {
    private let menuWidth: CGFloat = 250
    private var isMenuOpen = false
    private let menuVC = MenuViewController()
    private let dimmingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Main View"

        setupMenu()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toggleMenu))
    }
    
    private func setupMenu() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)

        // Position the menu off-screen to the left
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)

        // Optional dimming view
        dimmingView.frame = view.bounds
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        dimmingView.isUserInteractionEnabled = true
        view.insertSubview(dimmingView, belowSubview: menuVC.view)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleMenu))
        dimmingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleMenu() {
        isMenuOpen.toggle()
        let targetX = isMenuOpen ? 0 : -menuWidth

        UIView.animate(withDuration: 0.3) {
            self.menuVC.view.frame.origin.x = targetX
            self.dimmingView.alpha = self.isMenuOpen ? 1 : 0
        }
    }
}

class MenuViewController: UIViewController {
    
    private let menuOptions = ["Home", "Profile", "Settings", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupMenuOptions()
    }
    
    private func setupMenuOptions() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for option in menuOptions {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.addTarget(self, action: #selector(menuOptionTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func menuOptionTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        print("\(title) tapped")
    }
}
