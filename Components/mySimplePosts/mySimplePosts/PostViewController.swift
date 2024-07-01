//
//  PostViewController.swift
//  mySimplePosts
//
//  Created by David on 6/30/24.
//

import UIKit



class PostViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postFromLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postToLabel: UILabel!
    
    var post: PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captionLabel.text = post?.postCaption
        postFromLabel.text = post?.postFrom
        commentLabel.text = post?.postTo
        postToLabel.text = post?.postTime
        
        let imgUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"
        //print(post?.fileUrl)
        
        //let postImageURL: String? = nil
        
        //let imgUrl = post?.fileUrl ?? "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"
        
        print(imgUrl)

   
        
        
        //let postImage = post?.fileUrl

        postImage.downloaded(from: imgUrl)
 
    }
    

}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

