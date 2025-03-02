//
//  EditProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 1/12/25.
//

import UIKit


protocol EditProfileViewControllerDelegate: AnyObject {
    //func didUpdateProfile(firstName: String, lastName: String, biography: String)
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) 

}


class EditProfileViewController: UIViewController {
    let profileAPI = ProfileAPI()
    let userDefaultManager = UserDefaultManager()

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userFullNameField: UITextField!
    @IBOutlet weak var userBiographyTextArea: UITextView!
    
    //Incoming Data
    var inputFirstName: String! //First Name
    var inputLastName: String! //Last Name
    var inputBiography: String!
    var inputProfileImage: UIImage?
   
    // Delegate property
    weak var delegate: EditProfileViewControllerDelegate?
    
    var selectedProfileImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstName: String = inputFirstName ?? ""
        let lastName : String = inputLastName ?? ""
        let biography : String = inputBiography ?? ""
        
        if let profileImage = inputProfileImage {
            userImageView.image = profileImage
        }
        
        userNameField.text = firstName
        userFullNameField.text = lastName
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
        let updatedFirstName = userNameField.text ?? ""
        let updatedLastName = userFullNameField.text ?? ""
        let updatedBiography = userBiographyTextArea.text ?? ""

         //TYPE 1: Image Not Updated
         if selectedProfileImage == nil || selectedProfileImage == inputProfileImage {
             print("TYPE 1: Image is the same")
             
             Task {
                 do {
                     let updatedProfileResponse = try await profileAPI.updateUserProfileAPI(
                         currentUser: currentUser,
                         imageName: "currentUser",
                         firstName: updatedFirstName,
                         lastName: updatedLastName,
                         biography: updatedBiography
                     )

                     // Notify the delegate with the updated data
                     delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: nil)

                     // Go back to ProfileViewController
                     navigationController?.popViewController(animated: true)
                 
                 } catch {
                     print("Failed to update profile: \(error)")
                 }
             }
             
         //TYPE 2: Image Updated
         } else {
             print("TYPE 2: Image Changed")
             guard let newProfileImage = selectedProfileImage else {
                  print("No new image selected. Skipping image update.")
                  return
              }
             
             Task {
                 do {
                     let updatedProfileResponse = try await profileAPI.updateFullUserProfileAPI(currentUser: currentUser, profileImage: newProfileImage, firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)

                     // Notify the delegate with the updated data
                     //delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography)
                     delegate?.didUpdateProfile(firstName: updatedFirstName, lastName: updatedLastName, biography: updatedBiography, updatedImage: newProfileImage)

                     // Go back to ProfileViewController
                     navigationController?.popViewController(animated: true)
                 
                 } catch {
                     print("Failed to update profile: \(error)")
                 }
             }
         }
     

    }

  
    // New function to handle full profile update when image is changed
    func fullProfileUpdate() {
        print("Updating full profile with new image...")
        // Mock function to handle full profile update
        // You can replace this with the actual API call
    }

}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            print("You picked an image! dude!")
            userImageView.image = selectedImage
            selectedProfileImage = selectedImage
        }
        print("Here some info DUDE \(info)")
        picker.dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("ah never mind dude!")
        picker.dismiss(animated: true)
    }
}

