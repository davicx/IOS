//
//  ViewController.swift
//  NewGroupExample
//
//  Created by David Vasquez on 7/3/25.
//

import UIKit


class ViewController: UIViewController {
    
    let newGroupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Group", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }
    
    private func setupButton() {
        view.addSubview(newGroupButton)
        newGroupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGroupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newGroupButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newGroupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGroupButton.addTarget(self, action: #selector(openCreateGroup), for: .touchUpInside)
    }
    
    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }
}


