//
//  getPostsTemp.swift
//  loginSystem
//
//  Created by David Vasquez on 8/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import Foundation

/*
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //This Array holds all the data returned from the JSON Call
    var postModelArray: [PostModel] = []
    
    //This Array is a smaller array of our Post Class
    var postsArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get All Posts
        getPosts(tempInput: "hiya!") { tempPostArray, error in
            DispatchQueue.main.async {
                self.postsArray = filterPostsIntoArray(tempPostArray: tempPostArray)
                self.tableView.reloadData()
                
            }
        }
    }
}



//func getPosts(completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
func getPosts(tempInput: String, completionHandler:@escaping (Array<PostModel>, Error?)->Void ) {
    let parameters = ["user_name": "vasquezd", "user_key": "vasquezd"]
    
    print(tempInput)
    
    guard let url = URL(string: "http://people.oregonstate.edu/~vasquezd/sites/template/site_files/rest/post/get_user_posts.php") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                
                let postModelArray = try JSONDecoder().decode([PostModel].self, from: data)
                completionHandler(postModelArray, nil)
                
            } catch {
                print(error)
            }
        }
        
        }.resume()
}

*/
