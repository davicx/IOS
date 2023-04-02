//
//  tempCode.swift
//  designLoginThree
//
//  Created by David on 4/1/23.
//

import Foundation

//
//  RegisterUserModel.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 8/11/22.
//


import Foundation

struct RegisterUserModel: Codable {
    let emailStatus: Int
    let emailMessages: [String]
    let usernameStatus: Int
    let usernameMessages: [String]
    let fullNameStatus: Int
    let fullNameMessages: [String]
    let passwordStatus: Int
    let passwordMessages: [String]
    let validUserRegistration: Int
    let UserRegistrationMessages: [String]
    let userName: String
    let userID: Int
}


import Foundation

struct LoginResponseModel: Codable {
    let validUser: Bool
    let passwordCorrect: Bool
    let accessToken: String
    let refreshToken: String
}


/*
 {
     "emailStatus": 1,
     "emailMessages": [
         "Appears to be a valid email"
     ],
     "usernameStatus": 1,
     "usernameMessages": [
         "Username looks good!"
     ],
     "fullNameStatus": 1,
     "fullNameMessages": [
         "fullname looks good!"
     ],
     "passwordStatus": 1,
     "passwordMessages": [
         "Password looks good!"
     ],
     "validUserRegistration": 1,
     "UserRegistrationMessages": [
         "you succesfully registered frodo77877 with the ID 23"
     ],
     "userName": "frodo77877",
     "userID": 23
 }
 */

//VIEW CONTROLLER
//
//  ViewController.swift
//  myAPI
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/21/22.
//

import UIKit
//https://www.appsdeveloperblog.com/http-get-request-example-in-swift/
//https://stackoverflow.com/questions/31464785/swift-how-to-remember-cookies-for-further-http-requests

/*
struct Posts: Codable {
    let posts: [PostModel]
}
*/
/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //makePost(postCaption: "hiya there!")
        //getPosts()
        //getPostsGET()
        //setCookie()
        
    }

    @IBAction func simpleGetPostsButton(_ sender: UIButton) {
        print("simpleGetPostsButton")
        getGroupPosts()
    }
    
    @IBAction func simpleMakePostButton(_ sender: UIButton) {
        print("simpleMakePostButton")
    }
    
    @IBAction func getPostsHeaderButton(_ sender: UIButton) {
        print("getPostsWithHeaders")
        getPostsWithHeaders()
    }

    @IBAction func setCookieButton(_ sender: UIButton) {
        print("setCookieButton")
        setCookie()
    }
    
    @IBAction func getCookieButton(_ sender: UIButton) {
        print("getCookieButton")
        getCookie()
    }
    
    @IBAction func loginUserButton(_ sender: UIButton) {
        loginUser()
        print("loginUserButton")
    }
    
    @IBAction func registerUserButton(_ sender: UIButton) {
        print("registerUserButton")
        registerUser()
    }
    
    
    @IBAction func verifyUserButton(_ sender: UIButton) {
        print("verifyUserButton")
        verifyUser()
    }
    
    
    //Function 1: Get Group Posts (GET)
    func getGroupPosts() {
        let urlString = "http://localhost:3003/posts/group/77"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Parse JSON
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    //print(response)

                    print("START")
                    let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
                    //print(postArray)
 
                    for post in postArray {
                        print("\(post.postFrom) \(post.postCaption)")
                    }
                    
                    print("END")
                     
                    //print(postArray[0].userName)
                    //print(postArray[1])
                    //let posts = try JSONDecoder().decode(posts.self, from: data!)
                    //let postArray = posts[post]
                    //print(response)
             
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }
        dataTask.resume()
    }

    
    //Function 2: Make Simple Post (POST)
    
    //Function 3: Get Posts and Send Header
    func getPostsWithHeaders() {
        let urlString = "http://localhost:3003/posts/simple"
        let token = "myToken!!"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
       
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    /*
                    let posts = try decoder.decode(Posts.self, from: data)
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                     */
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }.resume()
    }
 
    //Function 4: Set Cookie
    //http://localhost:3003/cookie/set
    func setCookie() {
        let urlString = "http://localhost:3003/cookie/set"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
   
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    //print(response)
                    if let response = response as? HTTPURLResponse {
                       
                        // Read all HTTP Response Headers
                        print(response)
                        //print("All headers: \(response.allHeaderFields)")
                        
                        // Read a specific HTTP Response Header by name
                        print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                        print("Specific header: \(response.value(forHTTPHeaderField: "Set-Cookie") ?? " header not found")")
                    }
                    
                    //let decoder = JSONDecoder()
                    //let posts = try decoder.decode(Posts.self, from: data)
                    //let postArray = posts.posts
                    
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }.resume()
    }

    
    //Function 5: Get Cookie
    func getCookie() {
        let urlString = "http://localhost:3003/cookie/get"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
   
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    print(response)
                    //let decoder = JSONDecoder()
                    //let posts = try decoder.decode(Posts.self, from: data)
                    //let postArray = posts.posts
                    
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }.resume()
    }
    
    //Function 6: Login User
    func loginUser() {
        guard let urlString = URL(string: "http://localhost:3003/login") else { return }
        
        let parameters = [
            "userName": "davey",
            "password": "password"
        ]
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    print(response)
                    let loginUserResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    print(loginUserResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
      
    }
    
    
    
    //Function 7: Register User
    func registerUser() {
        guard let urlString = URL(string: "http://localhost:3003/register") else { return }
        
        let parameters = [
            "userName": "frodo777",
            "fullName": "frodo b",
            "email": "frodo@gmail.com",
            "password": "password"
        ]
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    //print(response)
                    let registerUserResponse = try JSONDecoder().decode(RegisterUserModel.self, from: data)
                    print(registerUserResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
      
    }
    
    //Function 8: Verify User
    func verifyUser() {
        guard let urlString = URL(string: "http://localhost:3003/verify") else { return }
        let token = "myToken!!"
        let parameters = [
            "userName": "davey"
        ]
        
        
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    print(response)
                    let verifyUserResponse = try JSONDecoder().decode(VerifyResponseModel.self, from: data)
                    print(verifyUserResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
      
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    //ORGANIZE
    
    //Function 2: Make Simple Post (POST)
    func makePost(postCaption: String){
        let token = "myToken!!"
        
        let parameters = [
            "postFrom": "davey",
            "postTo": "sam",
            "postCaption": postCaption
        ]
        
        guard let url = URL(string: "http://localhost:3003/post/text") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                    print(postResponse)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
         
    }
    
    

    //Function 1: Get Simple Posts (GET)
    func getPosts() {
        let urlString = "http://localhost:3003/posts/simple"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            /*
            let username = "username"
            let password = "password"
            let loginString = "\(username):\(password)"

            guard let loginData = loginString.data(using: String.Encoding.utf8) else {
                return
            }
            let base64LoginString = loginData.base64EncodedString()

            request.httpMethod = "GET"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            */
            
            //Parse JSON
            if error == nil && data != nil {
                //let decoder = JSONDecoder()

                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(Posts.self, from: data!)
                    /*
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                     */
                    //print(postArray[0].userName)
                    //print(postArray[1])
                    //let posts = try JSONDecoder().decode(posts.self, from: data!)
                    //let postArray = posts[post]
                    print(response)
             
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }
        dataTask.resume()
    }
    
    
    
    
    
    
    
    func getPostsGET() {
        let token = "myToken!!"
        let urlString = "http://localhost:3003/posts/simple"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
       
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    /*
                    let posts = try decoder.decode(Posts.self, from: data)
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                     */
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }.resume()
    }
    
    /*
    
    //Function 4: Set Cookie

    
    func sendLogin() {
        let username = "username"
        let password = "password"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        //request.httpMethod = "GET"
        //request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
    }
    */
    /*
    func temp() {
        func makeRequest(parameters: String, url:String){
            var postData:NSData = parameters.dataUsingEncoding(NSASCIIStringEncoding)!
            var postLength:NSString = String(postData.length )
            var request = NSMutableURLRequest(URL: NSURL(string: url)!)
            var session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"

            var error:NSError?
            //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(postData, options: nil, error: &error)
            request.HTTPBody = postData
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in

                println("Response:\(response)")

                // Other stuff goes here

        })
        let task = session.dataTask(with: request) { data, response, error in
            guard
                let url = response?.url,
                let httpResponse = response as? HTTPURLResponse,
                let fields = httpResponse.allHeaderFields as? [String: String]
            else { return }

            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
            HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
            for cookie in cookies {
                var cookieProperties = [HTTPCookiePropertyKey: Any]()
                cookieProperties[.name] = cookie.name
                cookieProperties[.value] = cookie.value
                cookieProperties[.domain] = cookie.domain
                cookieProperties[.path] = cookie.path
                cookieProperties[.version] = cookie.version
                cookieProperties[.expires] = Date().addingTimeInterval(31536000)

                let newCookie = HTTPCookie(properties: cookieProperties)
                HTTPCookieStorage.shared.setCookie(newCookie!)

                print("name: \(cookie.name) value: \(cookie.value)")
            }
        }
        task.resume()

    }

     */
    
    
    
    
    //Function 4: Get Cookie
    /*
    func getPostsGET() {
        let token = "myToken!!"
        let urlString = "http://localhost:3003/posts/simple"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
       
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(Posts.self, from: data)
                    let postArray = posts.posts
                    for post in postArray {
                        print("\(post.userName) \(post.caption)")
                    }
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
            
        }.resume()
    }
    */
}








/*
//
//  ViewController.swift
//  learningJSON
//
//  Created by David Vasquez on 5/16/21.
//  Copyright © 2021 David Vasquez. All rights reserved.
//
//https://jsonplaceholder.typicode.com/posts

import Foundation

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Parse JSON
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    //let postList = try decoder.decode(PostModel.self, from: data!)
                    let postList = try JSONDecoder().decode([PostModel].self, from: data!)
                    print(postList[0])
                    print(postList[1])

                } catch {
                    print("Error Parsing JSON")
                    
                }
                

            }
            
        }
        dataTask.resume()
    }
}

*/


//
//  ViewController.swift
//  getUser
//
//  Created by David Vasquez on 5/27/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//
/*
import UIKit

import Foundation

class User {
    var userID:Int?
    var firstName = ""
    var lastName = ""
    var city = ""
    var userImage = ""
    
    init(userID: Int) {
        self.userID = userID
    }
    
}

import Foundation





class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    //Create the Logged in User
    var loggedInUser = User(userID: 0)
    var tempUser = User(userID: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getUserButton(_ sender: Any) {
        getCurrentUser { returnedUserObject, error in
            DispatchQueue.main.async {
                self.loggedInUser.firstName = returnedUserObject.firstName
                self.loggedInUser.lastName = returnedUserObject.lastName
                self.loggedInUser.userImage = returnedUserObject.lastName
            }
        }
    }

    @IBAction func printUserInfo(_ sender: Any) {
        print("Current User \(loggedInUser.firstName) \(loggedInUser.lastName)")
        print("Temp User \(tempUser.firstName) \(tempUser.lastName)")
        
    }
    
    @IBAction func setUser(_ sender: Any) {
        setCurrentUser()
        
    }
    
    
    
    
    //FUNCTION: Get User Info (Trigger through a Button)
    func getCurrentUser(completionHandler:@escaping (User, Error?)->Void ) {
        
        //Get JSON
        let urlString = "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/user.php"
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let returned_user_array = try decoder.decode(UserModel.self, from: data!)
                    
                    //Create a User Object to Return
                    let innerTempUserObject = User(userID: 0)
                    
                    innerTempUserObject.firstName = returned_user_array.first_name
                    innerTempUserObject.lastName = returned_user_array.last_name
                    innerTempUserObject.userImage = returned_user_array.user_image
                   
                    //Can also just set inside here
                    self.tempUser.firstName = returned_user_array.first_name
                    self.tempUser.lastName = returned_user_array.last_name
                    completionHandler(innerTempUserObject, nil)
                    
                } catch {
                    print("Error in JSON Parsing")
                    //completionHandler(nil, error)
                }
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
    //FUNCTION: Set User Info on Page Load
    func setCurrentUser() {
        let urlString = "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/user.php"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let returned_user_array = try decoder.decode(UserModel.self, from: data!)
                    
                    //print("Inside Do: \(currentUsersArray.first_name)")
                    DispatchQueue.main.async {
                        
                        //USER: Set Name and Username
                        self.userName.text = ("\(returned_user_array.first_name) \(returned_user_array.last_name)")
                        self.loggedInUser.firstName = returned_user_array.first_name
                        self.loggedInUser.lastName = returned_user_array.last_name
                        
                        //USER: Set User Image
                        let baseURL = "http://people.oregonstate.edu/~vasquezd/sites/user_uploads/user_image/"
                        let urlKey = returned_user_array.user_image
                        
                        //Load Image
                        if let url = URL(string: urlKey) {
                            do {
                                let data = try Data(contentsOf: url)
                                self.userImage.image = UIImage(data: data)
                                
                            } catch let err {
                                print("error ", err)
                                
                            }
                        }
                    }
                    
                } catch {
                    print("Error in JSON Parsing")
                }
            }
        }
        dataTask.resume()
    }
}
*/


//SIMPLE VIEW CONTROLLER
//
//  SimpleViewController.swift
//  myAPI
//
//  Created by David on 3/5/23.
//

import UIKit

class SimpleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func simpleOneButton(_ sender: UIButton) {
        print("hi!")
        simpleGET()
    }
    
    func simpleGET() {
        let urlString = "http://localhost:3003/post"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "postCaption": "hiya!"
        ]
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch let error {
            print("Error occured parsing to json")
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("error!!", error)
                return
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        print("JSON")
                        print(response)
                        print(json)
                    }
                } catch let error {
                    print("error!!", error)
                }
            }
        }.resume()
        
    }
}

/*
let urlString = "http://localhost:3003/posts/group/77"
let url = URL(string: urlString)

guard url != nil else {
    return
}

let session = URLSession.shared
let dataTask = session.dataTask(with: url!) { (data, response, error) in
    
    //Parse JSON
    if error == nil && data != nil {
        do {
            let decoder = JSONDecoder()
            //print(response)

            print("START")
            let postArray = try JSONDecoder().decode([PostModel].self, from: data!)
            //print(postArray)

            for post in postArray {
                print("\(post.postFrom) \(post.postCaption)")
            }
            
            print("END")
             
            //print(postArray[0].userName)
            //print(postArray[1])
            //let posts = try JSONDecoder().decode(posts.self, from: data!)
            //let postArray = posts[post]
            //print(response)
     
        } catch {
            print("Error Parsing JSON")
            
        }
    }
}
dataTask.resume()
*/

 */
