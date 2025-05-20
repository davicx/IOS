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
    
    private let userProfileLayout = UserProfileLayout()
    
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add action to Edit Button
        userProfileLayout.userProfileEditView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        userProfileLayout.userProfileSocialsView.followingButton.addTarget(self, action: #selector(followingButtonTapped), for: .touchUpInside)

        Task {
            do {
                userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if let statusCode = userResponseModel?.statusCode, statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                if let currentUser = userResponseModel?.data {
                    //STEP 1: Fetch image asynchronously before updating UI
                    let profileImage = await fetchImage(from: currentUser.userImage)

                    DispatchQueue.main.async {
                        //STEP 2: Set UI Elements
                        
                        //Step 2A: Set Username
                        self.userProfileLayout.userNameView.nameLabel.text = "@\(currentUser.userName)"
                        
                        //Step 2B: Set Image with fetched image
                        if let profileImage = profileImage {
                            if let croppedImage = profileImage.croppedToSquare() {
                                self.userProfileLayout.profileImageView.imageView.image = croppedImage
                            } else {
                                self.userProfileLayout.profileImageView.imageView.image = profileImage
                            }
                        } else {
                            self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
                        }

                        self.userProfileLayout.profileImageView.imageView.makeRounded()
                        
                        //Step 2C: Set first and last name
                        self.userProfileLayout.userProfileBiography.configure(
                            firstName: currentUser.firstName,
                            lastName: currentUser.lastName
                        )
                        
                    }
                }
            } catch {
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
                print(error)
            }
        }
    }

    @objc private func followingButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let followingVC = storyboard.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        navigationController?.pushViewController(followingVC, animated: true)
    }
    
    // EDIT
    @objc private func editButtonTapped() {
        guard let userResponse = userResponseModel else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController

        // Send the existing data
        editProfileVC.inputFirstName = userResponse.data.firstName
        editProfileVC.inputLastName = userResponse.data.lastName
        editProfileVC.inputBiography = userResponse.data.biography

        if let profileImage = userProfileLayout.profileImageView.imageView.image {
            editProfileVC.inputProfileImage = profileImage
        }

        // **Set the delegate**
        editProfileVC.delegate = self

        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    /*
    @objc private func editButtonTapped() {
        guard let userResponse = userResponseModel else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController

        // Send the data
        editProfileVC.inputFirstName = userResponse.data.firstName
        editProfileVC.inputLastName = userResponse.data.lastName
        editProfileVC.inputBiography = userResponse.data.biography

        if let profileImage = userProfileLayout.profileImageView.imageView.image {
            editProfileVC.inputProfileImage = profileImage
        }
        
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
     */
}


extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        DispatchQueue.main.async {
            self.userProfileLayout.userProfileBiography.configure(
                firstName: firstName,
                lastName: lastName
            )
            
            //self.userProfileLayout.userProfileEditView.biographyLabel.text = biography
            
            // Update profile image if changed
            if let newImage = updatedImage {
                self.userProfileLayout.profileImageView.imageView.image = newImage
            }

            print("Profile updated: \(firstName), \(lastName)")
        }
    }
}



/*
@objc private func editButtonTapped() {
    print("EDIT ME!!")
    let editProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
    navigationController?.pushViewController(editProfileVC, animated: true)
}
 */

//ADD THIS LOGIC
/*
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showEditProfileViewController" {
        let editProfileViewController = segue.destination as! EditProfileViewController
        //self.userProfileLayout.editProfileViewController.inputFirstName = userResponseModel?.data.firstName ?? "Error getting User Name"
        //self.userProfileLayout.editProfileViewController.inputLastName = userResponseModel?.data.lastName ?? "Error getting Full Name"
        //self.userProfileLayout.editProfileViewController.inputBiography = userResponseModel?.data.biography ?? "Error getting Biography"

    
        //if let profileImage = profileImageView.image {
        //    editProfileViewController.inputProfileImage = profileImage
       // }
    
        
        // Set the delegate
        //editProfileViewController.delegate = self
    }
}
*/
//ADD THIS LOGIC

//THIS WORKS!!!!
/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    

    //MAIN VIEWS
    @IBOutlet weak var UserProfileImageView: UIView!
    @IBOutlet weak var UserProfileUserNameView: UIView!
    @IBOutlet weak var UserProfileSocialsView: UIView!
    @IBOutlet weak var UserProfileEditView: UIView!
    @IBOutlet weak var UserProfileBiographyView: UIView!
    
    private let userProfileLayout = UserProfileLayout()
    
    //UI ELEMENTS
    @IBOutlet weak var profileImageView: UIImageView!
    
    /*

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    */
     
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
 

        userProfileLayout.setup(in: view)
        
        /*
        setUpViews()
        

        let userFollowerView = UserFollowersView()
        userFollowerView.translatesAutoresizingMaskIntoConstraints = false
        self.userFollowerView.addSubview(userFollowerView)

        NSLayoutConstraint.activate([
            userFollowerView.topAnchor.constraint(equalTo: self.userFollowerView.topAnchor),
            userFollowerView.leadingAnchor.constraint(equalTo: self.userFollowerView.leadingAnchor),
            userFollowerView.trailingAnchor.constraint(equalTo: self.userFollowerView.trailingAnchor),
            userFollowerView.bottomAnchor.constraint(equalTo: self.userFollowerView.bottomAnchor)
        ])
         */
        
        let deviceId = getDeviceId()
        print("Device ID:", deviceId)
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
            
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

            /*
            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
             */
            
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
        
        firstNameLabel.text = firstName
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
 */






/*
class ProfileViewController: UIViewController {

    

    /*

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    */
     
    var userResponseModel: UserProfileResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        userProfileLayout.setup(in: view)
        
        /*
        setUpViews()
        

        let userFollowerView = UserFollowersView()
        userFollowerView.translatesAutoresizingMaskIntoConstraints = false
        self.userFollowerView.addSubview(userFollowerView)

        NSLayoutConstraint.activate([
            userFollowerView.topAnchor.constraint(equalTo: self.userFollowerView.topAnchor),
            userFollowerView.leadingAnchor.constraint(equalTo: self.userFollowerView.leadingAnchor),
            userFollowerView.trailingAnchor.constraint(equalTo: self.userFollowerView.trailingAnchor),
            userFollowerView.bottomAnchor.constraint(equalTo: self.userFollowerView.bottomAnchor)
        ])
         */
        
        
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                /*
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
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

            /*
            if let profileImage = profileImageView.image {
                editProfileViewController.inputProfileImage = profileImage
            }
             */
            
            // Set the delegate
            editProfileViewController.delegate = self
        }
    }
    
    /*
    func setUpViews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
     */
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateProfile(firstName: String, lastName: String, biography: String, updatedImage: UIImage?) {
        // Update UI with the new data
        /*
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        biographyLabel.text = biography

        // Check if an updated image was provided
        if let newImage = updatedImage {
            print("Updating profile image in ProfileViewController")
            profileImageView.image = newImage
        }

         */
        print("Profile updated: \(firstName), \(lastName), \(biography)")
    }
}
 */

/*
class ProfileViewController: UIViewController {
    
    private let userProfileLayout = UserProfileLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(userProfileLayout)
        setupConstraints()
    }
    
    private func setupConstraints() {
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
*/






//ALL BELOW GOOD







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
 
 //biographyLabel.text = userResponseModel.data.biography
 //firstNameLabek.text = userResponseModel.data.firstName
 //lastNameLabel.text = userResponseModel.data.lastName
*/


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



/*
Task {
    do {
        let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
        
        if userResponseModel.statusCode == 401 {
            AuthManager.shared.logoutCurrentUser()
            return
        }
        
        DispatchQueue.main.async {
            // Set Username
            self.userProfileLayout.userNameView.nameLabel.text = "@\(userResponseModel.data.userName)"
            
            
            // Set Image Directly from User Model
            
            //if let image = await fetchImage(from: userResponseModel.data.userImage) {
            if let profileImage = userResponseModel.data.userImage {
                if let croppedImage = profileImage.croppedToSquare() {
                    self.userProfileLayout.profileImageView.imageView.image = croppedImage
                } else {
                    self.userProfileLayout.profileImageView.imageView.image = profileImage
                }
            } else {
                self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
            }
             
            
            self.userProfileLayout.profileImageView.imageView.makeRounded()
        }
    } catch {
        print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
        print(error)
    }
}
 */



/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    
    private let userProfileLayout = UserProfileLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
 
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        Task{
            do{
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                //self.userResponseModel = userResponseModel
                
                if(userResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                /*
                 //I WANT IT TO BE LIKE THIS
                //Update Data from API
                userNameLabel.text = "@\(userResponseModel.data.userName)"

                if let image = await fetchImage(from: userResponseModel.data.userImage) {
                    if let croppedImage = image.croppedToSquare() {
                        profileImageView.image = croppedImage
                    } else {
                        profileImageView.image = image // Fallback to original if cropping fails
                    }
                } else {
                    profileImageView.image = UIImage(named: "background_9")
                }
            */
            } catch{
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
            }
        }
        
        //fetchUserProfile()
    }
    

    /*
     //THIS IS CONFUSING
    private func fetchUserProfile() {
        let currentUser = userDefaultManager.getLoggedInUser()
        
        Task {
            do {
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if userResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                DispatchQueue.main.async {
                    self.userProfileLayout.profileImageView.updateImage(with: self.fetchImage(from: userResponseModel.data.userImage))
                    self.userProfileLayout.userNameView.updateName("@\(userResponseModel.data.userName)")
                }
                
            } catch {
                print("Error fetching user profile:", error)
            }
        }
    }
    
    private func fetchImage(from urlString: String?) -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(named: "default_profile")
        }
        return image
    }
     */
     
}
*/



/*
class ProfileViewController: UIViewController {
    let postsAPI = PostsAPI()
    let profileAPI = ProfileAPI()
    let loginAPI = LoginAPI()
    let userDefaultManager = UserDefaultManager()
    
    private let userProfileLayout = UserProfileLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        
        view.addSubview(userProfileLayout)
        userProfileLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        Task {
            do {
                let userResponseModel = try await profileAPI.getUserProfileAPI(currentUser: currentUser)
                
                if userResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                
                //STEP 1: Fetch image asynchronously before updating UI
                let profileImage = await fetchImage(from: userResponseModel.data.userImage)

                DispatchQueue.main.async {
                    //STEP 2: Set UI Elements
                    //Step 2A: Set Username
                    self.userProfileLayout.userNameView.nameLabel.text = "@\(userResponseModel.data.userName)"
                    
                    //Step 2B: Set Image with fetched image
                    if let profileImage = profileImage {
                        if let croppedImage = profileImage.croppedToSquare() {
                            self.userProfileLayout.profileImageView.imageView.image = croppedImage
                        } else {
                            self.userProfileLayout.profileImageView.imageView.image = profileImage
                        }
                    } else {
                        self.userProfileLayout.profileImageView.imageView.image = UIImage(named: "background_9")
                    }

                    self.userProfileLayout.profileImageView.imageView.makeRounded()
                }
            } catch {
                print("CATCH ProfileViewController profileAPI.getUserProfileAPI error!")
                print(error)
            }
        }

    }
}
*/

