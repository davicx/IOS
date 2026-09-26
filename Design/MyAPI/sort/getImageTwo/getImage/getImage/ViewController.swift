//
//  ViewController.swift
//  getImage
//
//  Created by David on 6/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    
    //Create Classes
    var currentPost = Post(postID: 1)
    let networker = Networker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create New Class
        //let currentPost = Post(postID: 1)
        
        //Set Image from local Assets
        postImage.image = UIImage(named: "city")

    }
    
    
    
    //BUTTONS
    @IBAction func getImageButton(_ sender: UIButton) {
        print("Get an Image")

        getImage { (data, error)  in
          if let error = error {
            print(error)
            return
          }
            print("load Image")
          //self.imageView.image = UIImage(data: data!)
        }
        
    }
    
    @IBAction func getImageNetworker(_ sender: UIButton) {
        networker.getImage(from: currentPost.fileUrl) { (data, error)  in
          if let error = error {
            print(error)
            return
          }

            //Set Directly
            self.postImage.image = UIImage(data: data!)

            //Set from Classs
            //self.currentPost.postImage = UIImage(data: data!)
            //self.postImage.image = self.currentPost.postImage
        }
    }
    
    
    //Function: Get Simple Image
    func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
        let url = URL(string: currentPost.fileUrl)!
        print(url)
        
    }
    
    //Function: Get Simple Image
    func getImageNotAsync() {
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
    
    
}





/*
 
 func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
     //let url = URL(string: "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg")!
     let url = URL(string: "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240704%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240704T220000Z&X-Amz-Expires=3600&X-Amz-Signature=9c76d5df6edc245ebc60bb27b806d982fceacf0324850bcc14333cf446e31b4b&X-Amz-SignedHeaders=host&x-id=GetObject")!
        
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


