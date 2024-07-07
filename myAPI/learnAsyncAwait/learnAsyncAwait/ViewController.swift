//
//  ViewController.swift
//  learnAsyncAwait
//
//  Created by David Vasquez on 7/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postFrom: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.image = UIImage(named: "david")
    }
    
    @IBAction func getPost(_ sender: UIButton) {
        
        //STEP 1: Create an array to hold users
        var usersArray = [UserClass]()

        Task{
             do{
                 
                //STEP 2: Use API to get all users
                let users = try await getUser()

                //STEP 3: Add users to current class
                for user in users {
                    var currentUser = UserClass(userID: user.userID)

                    //STEP 4: Get Image from API and add to User
                    let imageUrl = URL(string: users[0].userImage)!
                    let data = try await downloadImageData(from: imageUrl)
                   
                    //Set Class Properties
                    currentUser.userName = user.userName
                    currentUser.biography = user.biography
                    currentUser.userImage = user.userImage
                    currentUser.userImageData = UIImage(data: data)
                
                    usersArray.append(currentUser)
                }
                 
                 //STEP 5: Set Properties
                 postImageView.image = usersArray[0].userImageData
                 postFrom.text = usersArray[0].userName
                 postCaption.text = usersArray[0].biography

             }catch{
                  print(error)
             }
        }
        
    }
    
    
    func getUser() async throws -> [User] {
        let endpoint = "http://localhost:3003/simple/users"
        
        guard let url = URL(string: endpoint) else {
            throw networkError.invalidURL
        }
        
        let apiURL = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: apiURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder ()
            return try decoder.decode([User].self, from: data)
            
        } catch {
            print("Error decoding data")
            print(networkError.invalidData)
        }
        
        return []
        
    }
    
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    
}




enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


/*
//Get Image
Task {
    let imageUrl = URL(string: users[0].userImage)!
    do {
        let data = try await downloadImageData(from: imageUrl)
        let userImage = UIImage(data: data)
        postImageView.image = userImage
       
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
 */

 
//WORKS
/*
 //
 //  ViewController.swift
 //  learnAsyncAwait
 //
 //  Created by David Vasquez on 7/6/24.
 //

 import UIKit

 class ViewController: UIViewController {
     
     @IBOutlet weak var postImageView: UIImageView!
     
     @IBOutlet weak var postCaption: UILabel!
     @IBOutlet weak var postFrom: UILabel!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         postImageView.image = UIImage(named: "david")

         
     }
     
     @IBAction func getPost(_ sender: UIButton) {
         var usersArray = [UserFull]()

         Task{
              do{
                 let users = try await getUser()

                 for user in users {
                     print(user.userName)
                     print(user.userImage)
                     
                     
                 }
                  
                 let imageUrl = URL(string: users[0].userImage)!
                 let data = try await downloadImageData(from: imageUrl)
                 let userImage = UIImage(data: data)
                  
                  
                 postImageView.image = userImage
                 postFrom.text = users[0].userName
                 postCaption.text = users[0].biography

              }catch{
                   print(error)
              }
         }
         
         /*
         //Get Image
         Task {
             let imageUrl = URL(string: users[0].userImage)!
             do {
                 let data = try await downloadImageData(from: imageUrl)
                 let userImage = UIImage(data: data)
                 postImageView.image = userImage
                
             } catch {
                 print("Error: \(error.localizedDescription)")
             }
         }
          */
         
          

     }
     
     
     func getUser() async throws -> [User] {
         let endpoint = "http://localhost:3003/simple/users"
         
         guard let url = URL(string: endpoint) else {
             throw networkError.invalidURL
         }
         
         let apiURL = URLRequest(url: url)
         
         let (data, response) = try await URLSession.shared.data(for: apiURL)
         
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw networkError.invalidResponse
         }
         
         do {
             let decoder = JSONDecoder ()
             return try decoder.decode([User].self, from: data)
             
         } catch {
             print("Error decoding data")
             networkError.invalidData
         }
         
         return []
         
     }
     
     func downloadImageData(from url: URL) async throws -> Data {
         let request = URLRequest(url: url)
         let (data, _) = try await URLSession.shared.data(for: request)
         return data
     }
     
     
 }


 class UserFull {
     var userID: Int
     var userName: String?
     var biography: String?
     var userImage: String?
     var userImageData: UIImage?
     
     init(userID: Int) {
         self.userID = userID
     }
    
 }


 enum networkError: Error {
     case invalidURL
     case invalidResponse
     case invalidData
 }


 /*

  extension UIImageView {
      
      func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
          contentMode = mode
          URLSession.shared.dataTask(with: url) { data, response, error in
              guard
                  let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                  else { return }
              DispatchQueue.main.async() { [weak self] in
                  self?.image = image
              }
          }.resume()
      }
      
      func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
          guard let url = URL(string: link) else { return }
          downloaded(from: url, contentMode: mode)
      }
  }


  class HeroViewController: UIViewController {

      @IBOutlet weak var heroImage: UIImageView!
      @IBOutlet weak var nameLabel: UILabel!
      @IBOutlet weak var attributeLabel: UILabel!
      @IBOutlet weak var legsLabel: UILabel!
      @IBOutlet weak var attackLabel: UILabel!
      

      var hero: HeroStats?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          //print(hero!)
          nameLabel.text = hero?.localized_name
          attributeLabel.text = hero?.primary_attr
          attackLabel.text = hero?.attack_type
          legsLabel.text = "\((hero?.legs)!)"
          
          let imgUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240705T205811Z&X-Amz-Expires=259200&X-Amz-Signature=110084e7a25eedef956d838ec44ca8a3af969e2819e2a24a4d3c0eb042004446&X-Amz-SignedHeaders=host&x-id=GetObject"
          //let imgUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"

          heroImage.downloaded(from: imgUrl)
          
      }
      

  }


  */

 */
