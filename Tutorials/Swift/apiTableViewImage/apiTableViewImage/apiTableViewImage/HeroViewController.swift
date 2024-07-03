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
        
        let imgUrl = "https://insta-app-bucket-tutorial.s3.us-west-2.amazonaws.com/images/postImage-1717890765111-678334753-stars.jpg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjELD%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMiJHMEUCIQCCie39FBZMZ7D8QchHKpsaz3q7Il%2BB5mdadvS5SjvRJgIgcU9QAV1C2HNCbax8vm0V%2Fe4O4Bn6r56rPW%2BflZoGRtcq5AIIaRAAGgw1MzQ3NTMzNjk4NTAiDOr%2BJf6vl5NgR64msCrBAljBfZodNGY7mknZlvPbACk%2BWNwaOgmnK3FFjHDUNtUhe1u9lS5rQnTwim0i4do790ZJsedwXOBgprRAWYKFywdCPY523yFMjq2dbffQKhyzfYoG%2BQimoe2c%2FeBiX24dT07WlI4qQ%2Fj9Yk%2BtZRSUeUCffJyQs%2FqmMD3EmSvW4LfRtjXvExyB%2Bjxza3zJUi6Jce3YD78KWyB52x82qaDXfT8mWTNZMursj7aVCzoYp0mwIOXfimgcIUpB1PYIi7CGdTdILh74Zg9NzmSBXpEl7UsuQo5PDE3GrRTYCHJi%2B80Kbq6p6p%2BNRbasmZtmaCzZcnUuVqQMhUxpYx%2BuqdJNcNxZ3vnOTc0hwYycBCYNulUYIz%2FsMrsh3GgCES2lk34kn8nVACpCZ9uaf4C%2FkfklpfMiFIKd2aKaGqBZcqmctlIE6TD39Iy0BjqzAqX9TzAyHeMcOOXc0YVqTjnEIxHAq1bi3fzWTnklD0OQfwzfwzsXu25y42xUnIVREJJGcwtrDkx4qlI%2Bzxad1G20FzRKOrgzdYB0FeO0wuM1tRS5TW1dR8TPdXlohFMWyON5QZCxd57e3apAcGjCamX3iWgnphSBxJOPHSGQSEoWXWzniIZW8F9Qt3IZ%2BPQyVRxE1eweH0zzcBJfsG1avpDqOmRQOs62PnPjX%2BIXcI8SBWUr6Lg%2FIck3U%2Bc%2Bwwl3kLagHINNyj1p%2FYjuCcmaK5DMZhSSdHFenLqCIULd3LCiAX9wFmvWok8TX9qfbNpPtffFMjhLfEtVDqW9gOD47ipm26zt4W1sqLdBbcxxMOiGUMMA2ZLjOAHX57h9SkSoVPkICdD5IFd%2Bxp1DnlhkIYqWoEg%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240701T232409Z&X-Amz-SignedHeaders=host&X-Amz-Expires=14400&X-Amz-Credential=ASIAXZAOI335B73FUW7M%2F20240701%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=e8acc6cf2698e40f2312458d6c4090d74f6f803df4d2f41f741c770edf893f9d"
        //let imgUrl = "https://149455152.v2.pressablecdn.com/wp-content/uploads/2013/05/Howls-Moving-Castle.jpg"


        heroImage.downloaded(from: imgUrl)
        
    }
    

}

