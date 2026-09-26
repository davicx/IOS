//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



class IndividualPostViewCell: UITableViewCell {
    var postCaptionLabel = UILabel()

    func setUser(currentUser: User) {
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.textAlignment = .center
        postCaptionLabel.text = currentUser.userName

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(postCaptionLabel)
        
        configureTitleLabel()
        setTitleLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTitleLabel () {
        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.adjustsFontSizeToFitWidth = true
    }

    
    func setTitleLabelConstraints() {
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postCaptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            postCaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            postCaptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            postCaptionLabel.heightAnchor.constraint(equalToConstant: 80)
            // postCaptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    

}

