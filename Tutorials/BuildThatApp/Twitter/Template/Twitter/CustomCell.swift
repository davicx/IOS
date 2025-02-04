//
//  CustomCell.swift
//  Twitter
//
//  Created by David Vasquez on 10/4/24.
//


import UIKit


class PostCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init (frame: frame)
        
        setupViews()
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    //LAYOUT
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView

    }()

    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = .red
        
        return label
    }()
    
    func setupViews() {
        print("Setup")
        self.backgroundColor = .white
        addSubview(nameLabel)
        addSubview(imageView)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints using NSLayoutAnchor
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
}
