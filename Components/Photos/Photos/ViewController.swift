//
//  ViewController.swift
//  Photos
//
//  Created by David Vasquez on 1/9/25.
//

import UIKit

class ViewController: UIViewController {
    let postAPI = PostsAPI()
    var postsArrayNoImage = [Post]()
    var postsArray = [Post]()
    
    var currentUser = "davey"
    var tempLikes = ["sam", "merry"]

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            if let image = await fetchAndReturnImage(from: "http://localhost:3003/images/background_2.png") {
                photoImageView.image = image
            } else {
                print("Failed to load image")
            }
        }
        /*
        Task{

            do{
                //Get Posts from the API
                let postsResponseModel = try await postAPI.getPostsAPI()
                
                //Add Post Images from S3
                postsArrayNoImage = try await createPostsArray(postsResponseModel: postsResponseModel)
                postsArray = try await addPostImageToPostsArray(postsArray: postsArrayNoImage)
                
                //self.postTableView.reloadData()
                let postCaption : String = postsArray[0].postCaption ?? ""

                print(postCaption)
                
            } catch{
                print("yo man error!")
                print(error)
            }
        }
         */
    }

    func fetchAndReturnImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Error fetching image: \(error)")
            return nil
        }
    }

    
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Use URLSession to fetch the image data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
        task.resume()
    }


}

