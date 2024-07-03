//
//  ViewController.swift
//  getImage
//
//  Created by David on 6/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    
    var currentPost = Post(postID: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func getImageButton(_ sender: UIButton) {
 
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //FUNCTIONS: Doesnt work on new Code
    func getImageOld() {
        if let url = URL(string: currentPost.fileUrl) {
            do {
       
                let data = try Data(contentsOf: url)
                currentPost.postImage = UIImage(data: data)
                self.postImage.image = currentPost.postImage
            } catch let err {
                print("error ", err)
                
            }
        }
    }
    
    
    func getImageFromURLOld(inputFileURL: String) {
        if let url = URL(string: inputFileURL) {
            do {
                let data = try Data(contentsOf: url)
                self.postImage.image = UIImage(data: data)
            } catch let err {
                print("error ", err)
                
            }
        }
    }
    
}






/*

 override func viewDidLoad() {
     super.viewDidLoad()
     
     /*
     networker.getImage { (data, error)  in
       if let error = error {
         print(error)
         return
       }
       
       self.imageView.image = UIImage(data: data!)
     }
     
      */
 
 }
 
 
 func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
     let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg/440px-Kanye_West_at_the_2009_Tribeca_Film_Festival-2_%28cropped%29.jpg")!
        
        let task = session.downloadTask(with: url) { (localUrl: URL?, response: URLResponse?, error: Error?) in
          
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
          
          guard let localUrl = localUrl else {
            DispatchQueue.main.async {
              completion(nil, NetworkerError.badData)
            }
            return
          }
          
          do {
            let data = try Data(contentsOf: localUrl)
            DispatchQueue.main.async {
              completion(data, nil)
            }
          } catch let error {
            DispatchQueue.main.async {
              completion(nil, error)
            }
          }
        }
        task.resume()
 }

 
 */
