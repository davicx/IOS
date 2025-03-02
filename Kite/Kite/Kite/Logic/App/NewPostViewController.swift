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
    
    @IBAction func NewPostButton(_ sender: UIButton) {
        print("New Post!!")
        let groupID = 564
        let postTo = "564"
        
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


//CHAT
/*
 import UIKit

 class MakePostViewController: UIViewController {
     
     let userDefaultManager = UserDefaultManager()
     let postAPI = PostAPI()
     
     @IBOutlet weak var postImageView: UIImageView!
     @IBOutlet weak var captionTextField: UITextField!
     @IBOutlet weak var postButton: UIButton!
     
     var selectedImage: UIImage?
     
     override func viewDidLoad() {
         super.viewDidLoad()
         postImageView.isUserInteractionEnabled = true
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
         postImageView.addGestureRecognizer(tapGesture)
     }
     
     @objc func selectImage() {
         let picker = UIImagePickerController()
         picker.sourceType = .photoLibrary
         picker.delegate = self
         picker.allowsEditing = true
         present(picker, animated: true)
     }
     
     @IBAction func makePostButtonTapped(_ sender: UIButton) {
         guard let postImage = selectedImage, let caption = captionTextField.text, !caption.isEmpty else {
             print("Image and caption are required")
             return
         }
         
         Task {
             do {
                 let currentUser = userDefaultManager.getLoggedInUser()
                 let response = try await postAPI.makePhotoPost(postImage: postImage, postFrom: currentUser, postTo: "some_destination", postCaption: caption, groupID: 1, listID: 1)
                 print("Post successful: \(response)")
                 navigationController?.popViewController(animated: true)
             } catch {
                 print("Failed to make post: \(error)")
             }
         }
     }
 }

 extension MakePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let selectedImage = info[.editedImage] as? UIImage {
             postImageView.image = selectedImage
             self.selectedImage = selectedImage
         }
         picker.dismiss(animated: true)
     }
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true)
     }
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 */
/*
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


 */
/*
 //
 //  ViewController.swift
 //  sendFormDataToAPI
 //
 //  Created by David Vasquez on 8/11/24.
 //

 import UIKit


 class ViewController: UIViewController {

     let url: URL = URL(string: "http://localhost:3003/simple/post/photo")!
     let imageOne: UIImage = UIImage(named: "lake")!
     let imageTwo: UIImage = UIImage(named: "lake_png")!
     
     @IBOutlet weak var imageView: UIImageView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
     }
     
     
     @IBAction func newPhotoPostButton(_ sender: UIButton) {
         print("hi")

         imageView.image = imageOne
         
         Task{
             do{
                 //Get Posts from the API
                 let newPostResponseModel = try await uploadPhotoPost(postImage: imageOne, postFrom: "davey", postTo: "sam", postCaption: "Hiya!!", groupID: 72, listID: 0)
      
                 print(" ")
                 print("RETURNED")
                 print(newPostResponseModel)
                 print("SUCCESS")
             } catch{
                 print("yo man error!")
                 print(error)
             }
         }
    
    
     }
     
     func uploadPhotoPost(postImage: UIImage, postFrom: String, postTo: String, postCaption: String, groupID: Int, listID: Int) async throws -> NewPostResponseModel {
         let postType = "photo"
         let masterSite = "kite"
         let notificationMessage = "Posted a Photo"
         let notificationType = "new_post_photo"
         let notificationLink = "http://localhost:3003/posts/group/72"
         
             
         //STEP 1: Create the URL
         let endpoint = "http://localhost:3003/post/photo/local"
         
         guard let url = URL(string: endpoint) else {
             throw networkError.invalidURL
         }
         
         //STEP 2: Create the Request
         var request = URLRequest(url: url)
         let boundary = UUID().uuidString
         request.httpMethod = "POST"
         request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         
         //STEP 3: Create the Form Data and Photo
         let body = NSMutableData()

     
         //Post Type
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"postType\"\r\n\r\n")
         body.appendString("\(postType)\r\n")
             
         //Master Site
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"masterSite\"\r\n\r\n")
         body.appendString("\(masterSite)\r\n")

         //Post From
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"postFrom\"\r\n\r\n")
         body.appendString("\(postFrom)\r\n")
         
         //Post To
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"postTo\"\r\n\r\n")
         body.appendString("\(postTo)\r\n")
        
         //Group ID
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"groupID\"\r\n\r\n")
         body.appendString("\(groupID)\r\n")
         
         //List ID
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"listID\"\r\n\r\n")
         body.appendString("\(listID)\r\n")
         
         //Post Caption
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"postCaption\"\r\n\r\n")
         body.appendString("\(postCaption)\r\n")
         
         //Notification Message
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"notificationMessage\"\r\n\r\n")
         body.appendString("\(notificationMessage)\r\n")
         
         //Notification Type
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"notificationType\"\r\n\r\n")
         body.appendString("\(notificationType)\r\n")
         
         //Notification Link
         body.appendString("--\(boundary)\r\n")
         body.appendString("Content-Disposition: form-data; name=\"notificationLink\"\r\n\r\n")
         body.appendString("\(notificationLink)\r\n")
     
         if let imageData = postImage.jpegData(compressionQuality: 1.0) {
             body.appendString("--\(boundary)\r\n")
             body.appendString("Content-Disposition: form-data; name=\"postImage\"; filename=\"image.jpg\"\r\n")
             body.appendString("Content-Type: image/jpeg\r\n\r\n")
             body.append(imageData)
             body.appendString("\r\n")
         }
         
         body.appendString("--\(boundary)--\r\n")
         
         request.httpBody = body as Data
         
         //STEP 4: Handle the Response
         let (data, response) = try await URLSession.shared.data(for: request)
                
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw networkError.invalidResponse
         }
         
         do {
             let decoder = JSONDecoder ()
             let newPostResponseModel = try decoder.decode(NewPostResponseModel.self, from: data)

             print("API")
             print(newPostResponseModel)
             print("API")
             return newPostResponseModel
             
         } catch {
             let newPostResponseModel = NewPostResponseModel()
             print("Error decoding data")
             print(newPostResponseModel)
             return newPostResponseModel
             
         }
     }

 }



 // Extension to NSMutableData for convenience
 extension NSMutableData {
     func appendString(_ string: String) {
         if let data = string.data(using: .utf8) {
             append(data)
         }
     }
 }



 enum networkError: Error {
     case invalidURL
     case invalidResponse
     case invalidData
 }

 */
