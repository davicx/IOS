//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by David Vasquez on 10/17/24.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector (didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    @objc private func didTapSave() {
        print("save")
    }
    
    @objc private func didTapCancel () {
        print("cancel")

    }

    
    
    @objc private func didTapChangeProfilePicture () {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction (title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction (title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction (UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //So IPad works
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)

        
    }

}



