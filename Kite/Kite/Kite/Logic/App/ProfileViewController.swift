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
    @IBOutlet weak var firstNameLabek: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    

    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
 
        setUpViews()
        
        let deviceId = getDeviceId()
        print("Device ID:", deviceId)
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                userNameLabel.text = "USERNAME: \(userResponseModel.data.userName)"
                firstNameLabek.text = userResponseModel.data.firstName
                lastNameLabel.text = userResponseModel.data.lastName
                biographyLabel.text = userResponseModel.data.biography
                //print("Image URL \(userResponseModel.data.userImage)")
                //print(userResponseModel)
                //print("SUCCESS: Got the User Profile")
           
                /*
                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    profileImageView.image = image
                    //print("Loaded image")
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                    //print("Failed to load image")
                }
                 */
                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }

                
                
                /*
                 //Original Uncroped Image
                 if let originalImage = profileImageView.image,
                           let croppedImage = originalImage.croppedToSquare() {
                            profileImageView.image = croppedImage
                        }
                 
                 //Use Image Fill
                 profileImageView.contentMode = .scaleAspectFill
                 profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
                 profileImageView.clipsToBounds = true
                 */
           
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
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
            editProfileViewController.inputFirstName = userResponseModel?.data.firstName ?? "Error getting User Name"
            editProfileViewController.inputLastName = userResponseModel?.data.lastName ?? "Error getting Full Name"
            editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
            
            // Set the delegate
            editProfileViewController.delegate = self
        }
    }
    
    
    func setUpViews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        firstNameLabek.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Check if an updated image was provided
        if let newImage = updatedImage {
            print("Updating profile image in ProfileViewController")
            profileImageView.image = newImage
        }

        print("Profile updated: \(firstName), \(lastName), \(biography)")
    }
}


/*
extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String) {
        // Update the UI with the new data
        firstNameLabek.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Optionally, you can save the updated profile to the server or local storage
        print("Profile updated: \(firstName), \(lastName) \(biography)")
    }
}
*/
