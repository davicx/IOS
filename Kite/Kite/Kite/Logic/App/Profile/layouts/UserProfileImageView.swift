//
//  UserProfileImageView.swift
//  Kite
//
//  Created by David Vasquez on 3/12/25.
//

import UIKit



class UserProfileImageView: UIView {
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        //backgroundColor = .clear
        backgroundColor = .red
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func updateImage(with image: UIImage?) {
        imageView.image = image
        imageView.makeRounded()
    }
}


/*
class UserProfileImageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red // Placeholder color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
*/
