//
//  LoginViewController.swift
//  designLoginThree
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/30/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        let userName = userNameInput.text!
        let password = passwordInput.text!
        
        print("login \(userName)")
        //setCookie()
        getCookie()
        goToGroups()
        
    }
    
    //Go to Groups
    func goToGroups() {
        //Goes to Logged In
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "AppMain") as! UITabBarController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

    
    
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
                   
                    let decoder = JSONDecoder()
                    let jsonResponse = try decoder.decode(SetCookieModel.self, from: data)
                    print(jsonResponse.userName)
                    print(jsonResponse.accessToken)
                    print(jsonResponse.outcome)
                    
                    // Read all HTTP Response Headers
                    //print(response)
                    //print("All headers: \(response.allHeaderFields)")
                    
                    // Read a specific HTTP Response Header by name
                    //print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
                    //print("Specific header: \(response.value(forHTTPHeaderField: "Set-Cookie") ?? " header not found")")
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
                //print(response)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(GetCookieModel.self, from: data)
                print(jsonResponse.userName)
                print(jsonResponse.accessToken)
                //let postArray = posts.posts
                
            } catch {
                print("Error Parsing JSON")
                
            }
        }
        
    }.resume()
}
