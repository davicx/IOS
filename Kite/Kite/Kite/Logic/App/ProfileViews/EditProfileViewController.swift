//
//  EditProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 1/12/25.
//



import UIKit



protocol EditProfileViewControllerDelegate: AnyObject {
    func didUpdateProfile(fullName: String, biography: String)
}


class EditProfileViewController: UIViewController {
    let profileAPI = ProfileAPI()
    let userDefaultManager = UserDefaultManager()

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userFullNameField: UITextField!
    @IBOutlet weak var userBiographyTextArea: UITextView!
    
    //Incoming Data
    var inputUserName: String!
    var inputFullName: String!
    var inputBiography: String!
    var inputProfileImage: UIImage?
   
    // Delegate property
    weak var delegate: EditProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName: String = inputUserName ?? ""
        let fullName : String = inputFullName ?? ""
        let biography : String = inputBiography ?? ""
        
        if let profileImage = inputProfileImage {
            userImageView.image = profileImage
        }
        
        userNameField.text = userName
        userFullNameField.text = fullName
        userBiographyTextArea.text = biography
        
    }

    @IBAction func editPhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let currentUser = userDefaultManager.getLoggedInUser()

        // Get the updated values
        let updatedFullName = userFullNameField.text ?? ""
        let updatedBiography = userBiographyTextArea.text ?? ""

        Task {
            do {
                let updatedProfileResponse = try await profileAPI.updateUserProfileAPI(currentUser: currentUser, imageName: "currentUser", firstName: updatedFullName, lastName: updatedFullName, biography: updatedBiography)
            
                print(updatedProfileResponse)
                // Notify the delegate with the updated data
                delegate?.didUpdateProfile(fullName: updatedFullName, biography: updatedBiography)
                
                // Go back to ProfileViewController
                navigationController?.popViewController(animated: true)
            
            } catch {
                print("Failed to update profile: \(error)")
            }
        }
    }
}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            print("You picked an image! dude!")
            userImageView.image = selectedImage
        }
        print("Here some info DUDE \(info)")
        picker.dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("ah never mind dude!")
        picker.dismiss(animated: true)
    }
}

