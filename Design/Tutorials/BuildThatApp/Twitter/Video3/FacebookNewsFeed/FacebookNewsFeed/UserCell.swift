//
//  UserCell.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/12/24.
//


import UIKit


class UserCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    
    //UI ELEMENTS
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@davey"
        label.font = UIFont.systemFont(ofSize: 14)
        //label.textColor = customlightGray
        label.backgroundColor = .purple
        return label
    }()

    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Wanna go to the garden?!! Wanna go to the garden?!! Wanna go to the garden?!! Wanna go to the garden?!!"
        textView.font = UIFont.systemFont(ofSize: 15)
        //textView.backgroundColor = .clear
        textView.backgroundColor = .yellow
        return textView
    }()
   
    let followButton: UIButton = {
        let button = UIButton()

        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(UIImage(named: "follow"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)

        return button
    }()

    func setupViews() {
        //backgroundColor = .yellow
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        //Disable autoresizing mask
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
               profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
               profileImageView.widthAnchor.constraint(equalToConstant: 50),
               profileImageView.heightAnchor.constraint(equalToConstant: 50)
           ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: -20),
  
           ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            usernameLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            usernameLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
           
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            bioTextView.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor),
            bioTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            bioTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            followButton.widthAnchor.constraint(equalToConstant: 120),
            followButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

let customlightGray = UIColor(r: 130, g: 130, b: 130)
let twitterBlue = UIColor(r: 61, g: 167, b: 244)
let dividerLine = UIColor(r: 230, g: 230, b: 230)



/*

 class UserCell: UICollectionViewCell {
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
     }
     
     func postCurrentUser(user: User) {
         print(user.bioText)
     
         self.nameLabel.text = user.username
         self.bioTextView.text = user.bioText
         self.profileImageView.image = user.profileImage

     }
     
     //UI ELEMENTS
     let profileImageView = createProfileImageView()
     let nameLabel = createLabel()
     let userNameLabel = createUsernameLabel()
     let bioTextView = createBioTextView()
     let followButton = createFollowButton()
     let divider = createDivider()
     

     func setupViews() {
         addSubview(profileImageView)
         addSubview(nameLabel)
         addSubview(userNameLabel)
         addSubview(bioTextView)
         addSubview(followButton)
         addSubview(divider)

         //Disable autoresizing mask
         profileImageView.translatesAutoresizingMaskIntoConstraints = false
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         bioTextView.translatesAutoresizingMaskIntoConstraints = false
         followButton.translatesAutoresizingMaskIntoConstraints = false
         divider.translatesAutoresizingMaskIntoConstraints = false
         
         //Set Layout
         NSLayoutConstraint.activate([
             profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
             profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
             profileImageView.widthAnchor.constraint(equalToConstant: 50),
             profileImageView.heightAnchor.constraint(equalToConstant: 50)
         ])
         
         NSLayoutConstraint.activate([
             nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
             nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
             nameLabel.rightAnchor.constraint(equalTo: followButton.leftAnchor, constant: -12),
             nameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
         
         NSLayoutConstraint.activate([
             userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
             userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
             userNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
             userNameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
         
         NSLayoutConstraint.activate([
             bioTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 0),
             bioTextView.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor),
             bioTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
             bioTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
         ])
         
         NSLayoutConstraint.activate([
             followButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
             followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
             followButton.widthAnchor.constraint(equalToConstant: 120),
             followButton.heightAnchor.constraint(equalToConstant: 34)
         ])
         
         NSLayoutConstraint.activate([
             divider.heightAnchor.constraint(equalToConstant: 1),
             divider.leadingAnchor.constraint(equalTo: leadingAnchor),
             divider.trailingAnchor.constraint(equalTo: trailingAnchor),
             divider.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
     
     }
     
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
      
 }

 //Create Items
 func createProfileImageView() -> UIImageView {
     let imageView = UIImageView()
     //imageView.backgroundColor = .blue
     imageView.image = UIImage(named: "background_1")
     imageView.layer.cornerRadius = 5
     imageView.clipsToBounds = true
     return imageView
 }

 func createLabel() -> UILabel {
     let label = UILabel()
     label.text = "Davey"
     label.font = UIFont.boldSystemFont(ofSize: 16)
     return label
 }

 func createUsernameLabel() -> UILabel {
     let label = UILabel()
     label.text = "@davey"
     label.font = UIFont.systemFont(ofSize: 14)
     label.textColor = customlightGray
     return label
 }

 func createBioTextView() -> UITextView {
     let textView = UITextView()
     textView.text = "Wanna go to the garden?!!"
     textView.font = UIFont.systemFont(ofSize: 15)
     textView.backgroundColor = .clear
     //textView.backgroundColor = .red
     return textView
 }

 func createFollowButton() -> UIButton {
     let button = UIButton()

     button.layer.cornerRadius = 5
     button.layer.borderColor = twitterBlue.cgColor
     button.layer.borderWidth = 1
     button.setTitle("Follow", for: .normal)
     button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
     button.setTitleColor(twitterBlue, for: .normal)
     button.setImage(UIImage(named: "follow"), for: UIControl.State.normal)
     button.imageView?.contentMode = .scaleAspectFit
     button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)

     return button
 }

 func createDivider() -> UIView {
     let view = UIView()
     view.backgroundColor = dividerLine
     
     return view
 }




 
 // Creating a constraint using NSLayoutConstraint
 NSLayoutConstraint(item: button,
                    attribute: .Width,
                    relatedBy: .Equal,
                    toItem: nil,
                    attribute: .NotAnAttribute,
                    multiplier: 1.0,
                    constant: 40.0).isActive = true
  
 // Creating the same constraint using constraintEqualToConstant:
 button.widthAnchor.constraintEqualToConstant(40.0).isActive = true


 */
