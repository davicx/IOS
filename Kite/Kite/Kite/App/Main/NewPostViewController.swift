//
//  NewPostViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


class NewPostViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    let postsAPI = PostsAPI()
    let loginAPI = LoginAPI()
    
    @IBOutlet weak var newPostButtonStyle: UIButton!
    @IBOutlet weak var newPostImageView: UIImageView!
    @IBOutlet weak var newPostCaption: UITextView!
    
    var selectedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Buttons.styleTikTokButton(newPostButtonStyle)
        newPostButtonStyle.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        //newPostImageView.isUserInteractionEnabled = true
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        //newPostImageView.addGestureRecognizer(tapGesture)
    
    }
    
    @IBAction func selectImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)

    }
    
    @IBAction func tempLogoutButton(_ sender: UIButton) {
        Task {
            do {
                let currentUser = userDefaultManager.getLoggedInUser()
                let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? "UnknownDevice"

                let logoutResponse = try await loginAPI.logoutUser(username: currentUser, deviceID: deviceID)
                
                if logoutResponse.success {
                    print("Logout successful!")
                    // Optional: Perform additional cleanup or navigate to the login screen
                    self.navigationController?.popToRootViewController(animated: true)
                    PresenterManager.shared.showOnboarding()
                    
                } else {
                    print("Logout failed. Reason: \(logoutResponse.message ?? "Unknown error")")
                }

            } catch {
                print("Failed to logout: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    @IBAction func NewPostButton(_ sender: UIButton) {
        print("New Post!!")
        let groupID = 72
        let postTo = "72"
        
        guard let postImage = selectedImage, let postCaption = newPostCaption.text, !postCaption.isEmpty else {
            print("Image and caption are required")
            return
        }
        
        Task{
            do{
                let currentUser = userDefaultManager.getLoggedInUser()
                
                let newPostResponseModel = try await postsAPI.makePhotoPost(postImage: postImage, postFrom: currentUser, postTo: postTo, postCaption: postCaption, groupID: groupID, listID: 0)
                
                print("You made a new post to \(postTo) and it was \(newPostResponseModel.success)")
                
            } catch{
                print("yo man error!")
                print(error)
            }
        }
        
    }
    
}

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            newPostImageView.image = selectedImage
            self.selectedImage = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
