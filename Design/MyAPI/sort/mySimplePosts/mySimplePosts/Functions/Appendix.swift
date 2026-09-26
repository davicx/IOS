//
//  Appendix.swift
//  mySimplePosts
//
//  Created by David Vasquez on 7/13/24.
//

import Foundation


/*
 import UIKit

 class IndividualPostViewController: UIViewController {
     
     var selectedVideoTitle: String = ""
     
     @IBOutlet weak var postTextLabel: UILabel!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         print(selectedVideoTitle)
         postTextLabel.text = selectedVideoTitle
     }

 }

 //DATA SEND: Send Data to New Cell
 var videoTitle:String!

 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //print(indexPath)
     let video = videos[indexPath.row]
     //var videoTitleToPass = video.title
     videoTitle = video.title
     //print(videoTitleToPass)
     
     self.performSegue(withIdentifier: "showIndividualVideo", sender: self)
 }

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let secondController = segue.destination as! IndividualPostViewController
     secondController.selectedVideoTitle = videoTitle
     
 }



 */













//APPENDIX














//TABLE VIEW
/*
postTableView.delegate = self
postTableView.dataSource = self

//Function B1: Set the Number of Rows
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postsArray.count
}

//Function B2: Create and configure the Table View Cell
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    let post = postsArray[indexPath.row]
    cell.textLabel?.text = "test"
    return cell
}
 */


/*

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let post = postsArray[indexPath.row]
    
    //cell.textLabel?.text = post.postCaption
    //cell.detailTextLabel?.text = hero.primary_attr.capitalized
    
    
}
 */
/*
 
 

 
 //CELL SELECTION
 //Function C1: Handle Selecting a Cell
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("Cell Clicked")
     performSegue(withIdentifier: "showDetails", sender: self)
 }
 
 
 //Function C2: Prepare and pass data to Individual View
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let destination = segue.destination as? HeroViewController {
         destination.hero = heroes[tableView.indexPathForSelectedRow!.row]
     }
 }
 */
//Functions
/*
@IBAction func getPost(_ sender: UIButton) {
    
    //STEP 1: Create an array to hold posts
    

    Task{
         do{
             
            //STEP 2: Use API to get all users
            let postsResponseModel = try await getPosts()
             print(postsResponseModel.message)
 
                              
            //STEP 3: Add users to current class
            /*
             for post in posts {
                print(post.postCaption)
      
                /*
                var currentUser = Post(postID: user.po)

                //STEP 4: Get Image from API and add to User
                let imageUrl = URL(string: users[0].userImage)!
                let data = try await downloadImageData(from: imageUrl)
               
                //Set Class Properties
                currentUser.userName = user.userName
                currentUser.biography = user.biography
                currentUser.userImage = user.userImage
                currentUser.userImageData = UIImage(data: data)
            
                usersArray.append(currentUser)
                 */
                 
            }
             */
              
             
             //STEP 5: Set Properties
             //postImageView.image = usersArray[0].userImageData
             //postFrom.text = usersArray[0].userName
             //postCaption.text = usersArray[0].biography

         }catch{
              print(error)
         }
    }
    
}

 */

/*
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





 */
