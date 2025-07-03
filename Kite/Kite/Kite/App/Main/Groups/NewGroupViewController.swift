//
//  NewGroupViewController.swift
//  Kite
//
//  Created by David Vasquez on 7/3/25.
//

import Foundation


/*
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


 //
 //  CreateGroupViewController.swift
 //  NewGroupExample
 //
 //  Created by David Vasquez on 7/3/25.
 //


 import UIKit


 class CreateGroupViewController: UIViewController, UITextFieldDelegate {
     
     let nameLabel: UILabel = {
         let label = UILabel()
         label.text = "Name"
         label.font = UIFont.boldSystemFont(ofSize: 24)
         return label
     }()
     
     let nameField: UITextField = {
         let field = UITextField()
         field.placeholder = "Name your group"
         field.borderStyle = .roundedRect
         return field
     }()
     
     let createButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Create group", for: .normal)
         button.backgroundColor = .lightGray
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
         button.layer.cornerRadius = 10
         button.isEnabled = false // initially disabled
         return button
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         setupCloseButton()
         setupLayout()
         nameField.delegate = self
     }
     
     private func setupCloseButton() {
         let closeButton = UIButton(type: .system)
         closeButton.setTitle("✕", for: .normal)
         closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
         closeButton.setTitleColor(.black, for: .normal)
         closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
         closeButton.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(closeButton)
         NSLayoutConstraint.activate([
             closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
             closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
         ])
     }
     
     private func setupLayout() {
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         nameField.translatesAutoresizingMaskIntoConstraints = false
         createButton.translatesAutoresizingMaskIntoConstraints = false
         
         view.addSubview(nameLabel)
         view.addSubview(nameField)
         view.addSubview(createButton)
         
         NSLayoutConstraint.activate([
             nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
             nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             
             nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
             nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             
             createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
             createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             createButton.heightAnchor.constraint(equalToConstant: 50)
         ])
         
         createButton.addTarget(self, action: #selector(createGroup), for: .touchUpInside)
     }
     
     @objc private func closeTapped() {
         let alert = UIAlertController(title: "Warning", message: "Do you want to stop creating the group?", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
             self.dismiss(animated: true)
         })
         alert.addAction(UIAlertAction(title: "No", style: .cancel))
         present(alert, animated: true)
     }
     
     @objc private func createGroup() {
         if let groupName = nameField.text {
             print("Created group with name: \(groupName)")
             dismiss(animated: true)
         }
     }
     
     func textFieldDidChangeSelection(_ textField: UITextField) {
         let hasText = !(textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
         createButton.isEnabled = hasText
         createButton.backgroundColor = hasText ? .systemBlue : .lightGray
     }

     

     /*
      
      func textFieldDidChangeSelection(_ textField: UITextField) {
          createButton.isHidden = textField.text?.isEmpty ?? true
      }
      let createButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("Create group", for: .normal)
          button.backgroundColor = .systemBlue
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
          button.layer.cornerRadius = 10
          button.isHidden = true
          return button
      }()
      
      */
 }


 */
