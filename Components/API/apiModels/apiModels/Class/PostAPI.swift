//
//  postAPI.swift
//  apiModels
//
//  Created by David Vasquez on 3/14/23.
//

import Foundation

class PostAPI{
 
    func getPosts(completion: @escaping ([UserModel]?, Error?) -> (Void)) {
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
   
                    DispatchQueue.main.async {
                        //self.nameLabel.text = json[0]["firstName"] as! String
                        completion(userArray, nil)
                    }
        
     
                } catch {
                    print("Error Parsing JSON")
                    
                }
            }
        }
        dataTask.resume()
    }

    
}

