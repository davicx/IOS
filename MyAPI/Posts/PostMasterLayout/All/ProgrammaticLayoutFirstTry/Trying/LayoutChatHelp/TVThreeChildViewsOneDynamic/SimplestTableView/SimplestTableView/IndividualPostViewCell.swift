//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



class IndividualPostViewCell: UITableViewCell {
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setupViews() {
        addSubview(redView)
        addSubview(blueView)
        addSubview(whiteView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: topAnchor),
            redView.leadingAnchor.constraint(equalTo: leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 80),
            
            blueView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            whiteView.topAnchor.constraint(equalTo: blueView.bottomAnchor),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 8),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func configure(with blueHeight: CGFloat) {
        blueView.heightAnchor.constraint(equalToConstant: blueHeight).isActive = true
        layoutIfNeeded() // Ensure layout is updated immediately
    }
    
}


//NEW

//APPENDIX
/*
 //
 //  IndividualPostViewCell.swift
 //  SimplestTableView
 //
 //  Created by David Vasquez on 8/29/24.
 //

 import UIKit


 class IndividualPostViewCell: UITableViewCell {
     var postImageView = UIImageView()
     var postCaptionLabel = UILabel()

     func setUser(currentUser: User) {
         postCaptionLabel.numberOfLines = 0
         postImageView.image = currentUser.userImage
         postCaptionLabel.text = currentUser.userName
     }

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(postImageView)
         addSubview(postCaptionLabel)
         
         configureImageView()
         configureTitleLabel()
         
         setImageConstraints()
         setTitleLabelConstraints()
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func configureImageView() {
         postImageView.layer.cornerRadius = 10
         postImageView.clipsToBounds = true
     }
     
     func configureTitleLabel () {
         postCaptionLabel.numberOfLines = 0
         postCaptionLabel.adjustsFontSizeToFitWidth = true
     }
     
     
     
     //Leading = Left
     //Trailing = Right (This must be negative)
     func setImageConstraints () {
         postImageView.translatesAutoresizingMaskIntoConstraints = false
         postImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
         postImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
         postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier:16/9).isActive = true
          
     }
     
     func setTitleLabelConstraints () {
         postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
         postCaptionLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         //Pin This to the image
         postCaptionLabel.leadingAnchor.constraint(equalTo:postImageView.trailingAnchor,constant:20).isActive = true
         postCaptionLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
         postCaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
     }
     

 }


 /*
  private func setupImageView() {
      contentView.addSubview(postImageView)
      postImageView.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
          postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
          postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
          postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
          postImageView.heightAnchor.constraint(equalToConstant: 100) // Placeholder height
      ])
  }
  
  
  func setUpLabel() {
      postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
      postCaptionLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
      postCaptionLabel.leadingAnchor.constraint(equalTo:postImageView.trailingAnchor,constant:20).isActive = true
      postCaptionLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
      postCaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
  }
  */


 */
