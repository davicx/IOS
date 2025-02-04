//
//  ViewController.swift
//  myAPI
//
//  Created by David Vasquez on 1/30/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getUsers(_ sender: UIButton) {
        getUsers()
    }
    
    @IBAction func getCookieButton(_ sender: UIButton) {
        getCookie()
    }
    
    @IBAction func setCookieButton(_ sender: UIButton) {
        setCookie()
    }
    
    
    func getCookie() {
        let urlString = "http://localhost:3003/cookie/get"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                    
                    let cookie = try JSONDecoder().decode(CookieModel.self, from: data!)
                    print(cookie)

                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }
        dataTask.resume()
    }
    
    func setCookie() {
        let urlString = "http://localhost:3003/cookie/set"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                    
                    let cookie = try JSONDecoder().decode(CookieModel.self, from: data!)
                    print(cookie)

                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }
        dataTask.resume()
    }
    
    func getUsers() {
            let urlString = "http://localhost:3003/users"
            //let urlString = "http://localhost:3003/users/two"
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
                        
        
                        if let httpResponse = response as? HTTPURLResponse {
                      
                            print(httpResponse.statusCode)
                        }
                        
                        let userArray = try JSONDecoder().decode([User].self, from: data!)
     
                        for user in userArray {
                            print("\(user.firstName) \(user.lastName)")
                            print("Done!!")
                        }
                        
                        //print(postArray[0].userName)
                        //print(postArray[1])
                        //let posts = try JSONDecoder().decode(posts.self, from: data!)
                        //let postArray = posts[post]
                        
         
                    } catch {
                        print("Error Parsing JSON")
                        
                    }
                }
            }
            dataTask.resume()
        }


}


    
    


