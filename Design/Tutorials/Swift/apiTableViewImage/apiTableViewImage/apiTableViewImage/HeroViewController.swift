//
//  HeroViewController.swift
//  apiTableViewImage
//
//  Created by David Vasquez on 6/24/24.
//

import UIKit


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


class HeroViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    

    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(hero!)
        nameLabel.text = hero?.localized_name
        attributeLabel.text = hero?.primary_attr
        attackLabel.text = hero?.attack_type
        legsLabel.text = "\((hero?.legs)!)"
        
        let imgUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717975421510-619391449-stars.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAXZAOI335HZSDKHVN%2F20240705%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240705T205811Z&X-Amz-Expires=259200&X-Amz-Signature=110084e7a25eedef956d838ec44ca8a3af969e2819e2a24a4d3c0eb042004446&X-Amz-SignedHeaders=host&x-id=GetObject"
        //let imgUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"

        heroImage.downloaded(from: imgUrl)
        
    }
    

}


