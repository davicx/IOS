//
//  ViewController.swift
//  mySimplePosts
//
//  Created by David on 6/30/24.
//

import UIKit


//WORKS
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }


    //FUNCTIONS:
    //Function A1: Download JSON from API
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://localhost:3003/posts/group/70")
        //let url = URL(string: "http://localhost:3003/simple/hero")
        
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {

                    if let data = data {
                       do {
                           
                           let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data)
                           let postsArray = postResponse.data
         
                           self.posts = postsArray
                       } catch {
                           print(error)
                       }
                   }
     
                    DispatchQueue.main.async {
                        completed()
                    }
                    
     
                }
                catch {
                    print(err)
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
    
    //TABLE VIEW
    //Function B1: Set the Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //Function B2: Create and configure the Table View Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        //print(post)
        //cell.textLabel?.text = posts.localized_name.capitalized
        cell.textLabel?.text = post.postCaption
        cell.detailTextLabel?.text = post.postFrom
        
        return cell
    }
    
    //CELL SELECTION
    //Function C1: Handle Selecting a Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Clicked")
        performSegue(withIdentifier: "showPosts", sender: self)
    }
    
    
    //Function C2: Prepare and pass data to Individual View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostViewController {
            destination.post = posts[tableView.indexPathForSelectedRow!.row]
        }
    }
 
}



//print(posts)
//print("\(friendResponse.request_to) \(friendResponse.request_from)")
//print(PostResponseModel.data.loggedInUser)
//print(postResponse.message)
//print("\(friendResponse.request_from)")
//for post in posts {
//    print(post.postCaption)
//}
//print(posts[0].postCaption)
//completionHandler(postModelArray, nil)



//let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
//let postResponse = try JSONDecoder().decode(PostResponseModel.self, from: data!)
//let postsArray = postResponse.data

//
//self.posts = try JSONDecoder().decode([PostResponseModel].self, from: data!)
//self.posts = postResponsedata


//
