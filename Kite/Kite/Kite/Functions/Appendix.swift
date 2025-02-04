//
//  Appendix.swift
//  Kite
//
//  Created by David Vasquez on 12/24/24.
//

import Foundation


//WORKS
/*
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
        
        print("GETTING FROM SECON PAGE!! \(userName) \(fullName) \(biography)")
        userNameField.text = userName
        userFullNameField.text = fullName
        userBiographyTextArea.text = biography
        
    }

    @IBAction func editPhotoButton(_ sender: UIButton) {
        print("Change Me")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let currentUser = userDefaultManager.getLoggedInUser()

        print("save me!")
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
*/

/*
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func imageSelectButton(_ sender: UIButton) {
        print("picked!")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            print("You picked an image! dude!")
            imageView.image = selectedImage
        }

        print("Here some info DUDE \(info)")
        picker.dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("ah never mind dude!")
        picker.dismiss(animated: true)
    }
    
}

*/


/*
if isUserLoggedIn {
    let mainTabBarController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
    
    if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
       let window = sceneDelegate.window {
        window.rootViewController = mainTabBarController
    }

    
} else {
    let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
    
    if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
       let window = sceneDelegate.window {
        window.rootViewController = onboardingViewController
    }

    //performSegue(withIdentifier: Constants.Segue.showLogin, sender: nil)
}

*/


//THIS IS WHAT I DID AND THEN HAVE TO FIX

//
//  LoadingViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 11/22/24.
//

/*
import UIKit


class LoadingViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showInitialView()
    }
     
    private func showInitialView() {
        var isUserLoggedIn = userDefaultManager.getLoggedInUserStatus()
        if isUserLoggedIn {
            PresenterManager.shared.showMainApp()
        } else {
            PresenterManager.shared.showOnboarding()
        }
    }
    private func setupView() {
        
    }
}

*/
/*
class LoadingViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
  
        delay(durationInSeconds: 1.0) {
            self.showInitialView()
        }
    }
    
    private func showInitialView() {
        let isUserLoggedIn = userDefaultManager.getLoggedInUserStatus()
        if isUserLoggedIn {
            print("PresenterManager.shared.showMainApp()")
            //PresenterManager.shared.showMainApp()
        } else {
            //PresenterManager.shared.showOnboarding()
            print("PresenterManager.shared.showOnboarding()")
        }
    }
    
    private func setupView() {
        // Setup your view components here
    }
}

*/

/*
class LoadingViewController: UIViewController {
    let userDefaultManager = UserDefaultManager()
    
    private var isUserLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserLoggedIn = userDefaultManager.getLoggedInUserStatus()
        print("isUserLoggedIn \(isUserLoggedIn)")
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
        delay(durationInSeconds: 1.0) {
            self.showInitialView()
        }
    }
     
    private func showInitialView() {
        if isUserLoggedIn {
            PresenterManager.shared.showMainApp()
        } else {
            PresenterManager.shared.showOnboarding()
        }
    }
    
    private func setupView() {
        //view.backgroundColor = .blue
        //print("Don't need")
    }
}
*/

/*
 
 class LoadingViewController: UIViewController {
     let userDefaultManager = UserDefaultManager()
     override func viewDidLoad() {
         super.viewDidLoad()
         setupView()
     }
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         self.showInitialView()
     }
      
     private func showInitialView() {
         var isUserLoggedIn = userDefaultManager.getLoggedInUserStatus()
         if isUserLoggedIn {
             PresenterManager.shared.showMainApp()
         } else {
             PresenterManager.shared.showOnboarding()
         }
     }
     private func setupView() {}
 }

 */


/*
if isUserLoggedIn {
    let mainTabBarController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController)
    
    if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
       let window = sceneDelegate.window {
        window.rootViewController = mainTabBarController
    }

    
} else {
    let onboardingViewController = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardID.onboardingViewController)
    
    if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
       let window = sceneDelegate.window {
        window.rootViewController = onboardingViewController
    }

    //performSegue(withIdentifier: Constants.Segue.showLogin, sender: nil)
}

*/

