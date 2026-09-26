//
//  VideoCell.swift
//  UITableViewTutorialCustomCellsProgrammatic
//
//  Created by David Vasquez on 9/16/24.
//

import UIKit

class VideoCell: UITableViewCell {
    var videoImageView = UIImageView()
    var videoTitleLabel = UILabel ()
    
    
    func setVideo(video: Video) {
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(videoImageView)
        addSubview(videoTitleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        videoImageView.layer.cornerRadius = 10
        videoImageView.clipsToBounds = true
    }
    
    func configureTitleLabel () {
        videoTitleLabel.numberOfLines = 0
        videoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    //Leading = Left
    //Trailing = Right (This must be negative)
    func setImageConstraints () {
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
        videoImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier:16/9).isActive = true
    }
    
    func setTitleLabelConstraints () {
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        videoTitleLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        //Pin This to the image
        videoTitleLabel.leadingAnchor.constraint(equalTo:videoImageView.trailingAnchor,constant:20).isActive = true
        videoTitleLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
        videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}


