//
//  ProfileViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var biographyTextField: UITextView!
    
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
 
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                userNameLabel.text = userResponseModel.data.userName
                nameLabel.text = userResponseModel.data.firstName
                biographyTextField.text = userResponseModel.data.biography
                //print("Image URL \(userResponseModel.data.userImage)")
                //print(userResponseModel)
                //print("SUCCESS: Got the User Profile")
            
                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    profileImageView.image = image
                    //print("Loaded image")
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                    //print("Failed to load image")
                }
                
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                AuthManager.shared.logoutCurrentUser()
            }
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        print("hi!")
    }
    
    //SEND Data to Edit Profile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditProfileViewController" {
            let editProfileViewController = segue.destination as! EditProfileViewController
            editProfileViewController.inputUserName = userResponseModel?.data.userName ?? "Error getting User Name"
            editProfileViewController.inputFullName = userResponseModel?.data.firstName ?? "Error getting Full Name"
            editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
            
            // Set the delegate
            editProfileViewController.delegate = self
        }
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(fullName: String, biography: String) {
        // Update the UI with the new data
        nameLabel.text = fullName
        biographyTextField.text = biography

        // Optionally, you can save the updated profile to the server or local storage
        print("Profile updated: \(fullName), \(biography)")
    }
}


/*
 let newAccessTokenModel = try await loginAPI.getNewAccessToken(username: currentUser)
 print(newAccessTokenModel)
 */
