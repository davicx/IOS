//
//  ViewController.swift
//  apiModels
//
//  Created by David Vasquez on 3/13/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
   
    let postAPI = PostAPI()
    let networker = Networker.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getQuoteButton(_ sender: UIButton) {
        print("Get Quote")
        networker.getQuote { (kanye, error) -> (Void) in
          if let _ = error {
            //self.label.text = "Error"
              print("Error")
            return
          }
        print(kanye?.quote)
          //self.label.text = kanye?.quote
        }
        
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        postAPI.getPosts { (userArray, error) -> (Void) in
            for user in userArray! {
                print("\(user.firstName) \(user.lastName)")
            }
            self.nameLabel.text = userArray![0].firstName
        }
        
    }
    
}




////

    /*
    func getUsers() {
        let urlString = "http://localhost:3003/users"
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
                    
                    let userArray = try JSONDecoder().decode([UserModel].self, from: data!)

                    for user in userArray {
                        print("\(user.firstName) \(user.lastName)")
                    }
       
                    //Not the best
                    //Runs in a background queue to update
                    let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]]
                    print("json")
                    print(json[0]["firstName"]!)
                    
                    if let name = json[0]["firstName"] {
                      print("name was successfully unwrapped and is = \(name)")
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.nameLabel.text = json[0]["firstName"] as! String
                    }
        
     
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }
        dataTask.resume()
    }
    
    */
    /*
     let url = URL(string: "https://api.kanye.rest/")!
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      
      let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
          DispatchQueue.main.async {
            completion(nil, error)
          }
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
          DispatchQueue.main.async {
            completion(nil, NetworkerError.badResponse)
          }
          return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
          DispatchQueue.main.async {
            completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
          }
          return
        }
        
        guard let data = data else {
          DispatchQueue.main.async {
            completion(nil, NetworkerError.badData)
          }
          return
        }
        
        do {
          let kanye = try JSONDecoder().decode(Kanye.self, from: data)
          DispatchQueue.main.async {
            completion(kanye, nil)
          }
        } catch let error {
          DispatchQueue.main.async {
            completion(nil, error)
          }
        }
      }
      task.resume()
     */




//Version 1:
/*
func getUsers() {
    let urlString = "http://localhost:3003/users"
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
                
                let userArray = try JSONDecoder().decode([UserModel].self, from: data!)

                for user in userArray {
                    print("\(user.firstName) \(user.lastName)")
                }
                
                
                
                //Not the best
                //Runs in a background queue to update
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]]
                print("json")
                print(json[0]["firstName"]!)
                
                if let name = json[0]["firstName"] {
                  print("name was successfully unwrapped and is = \(name)")
                    
                }
                
                DispatchQueue.main.async {

                    self.nameLabel.text = json[0]["firstName"] as! String
                    
                }
    
 
            } catch {
                print("Error Parsing JSON")
                
            }
        }
    }
    dataTask.resume()
}

*/
