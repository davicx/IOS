//
//  UserCell.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/5/24.
//


import UIKit


class UserCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    //UI ELEMENTS
    let profileImageView = createProfileImageView()
    let nameLabel = createLabel()
    let userNameLabel = createUsernameLabel()
    let bioTextView = createBioTextView()
    let followButton = createFollowButton()


    func setupViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(userNameLabel)
        addSubview(bioTextView)
        addSubview(followButton)

        //Disable autoresizing mask
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
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
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

//Create Items
func createProfileImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .blue
    return imageView
}

func createLabel() -> UILabel {
    let label = UILabel()
    label.backgroundColor = .gray
    return label
}

func createUsernameLabel() -> UILabel {
    let label = UILabel()
    label.text = "username"
    label.backgroundColor = .lightGray
    return label
}

func createBioTextView() -> UITextView {
    let textView = UITextView()
    textView.backgroundColor = .black
    return textView
}

func createFollowButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .cyan
    return button
}


//WORKING: No Follow Button
/*
 //
 //  UserCell.swift
 //  FacebookNewsFeed
 //
 //  Created by David Vasquez on 10/5/24.
 //


 import UIKit


 class UserCell: UICollectionViewCell {
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
     }
     
     //UI ELEMENTS
     let profileImageView = createProfileImageView()
     let nameLabel = createLabel()
     let userNameLabel = createUsernameLabel()
     let bioTextView = createBioTextView()
     //let followButton = createFollowButton()


     func setupViews() {
         //backgroundColor = .yellow
         
         addSubview(profileImageView)
         addSubview(nameLabel)
         addSubview(userNameLabel)
         addSubview(bioTextView)
         //addSubview(followButton)

         //Disable autoresizing mask
         profileImageView.translatesAutoresizingMaskIntoConstraints = false
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         bioTextView.translatesAutoresizingMaskIntoConstraints = false
         //followButton.translatesAutoresizingMaskIntoConstraints = false
         
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
             nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
             nameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
         
         NSLayoutConstraint.activate([
             userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
             userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
             userNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
             userNameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
         
         NSLayoutConstraint.activate([
             bioTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
             bioTextView.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor),
             bioTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
             bioTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
         ])
         

     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
      
 }

 /*
  NSLayoutConstraint.activate([
      followButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
      followButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      followButton.widthAnchor.constraint(equalToConstant: 120),
      followButton.heightAnchor.constraint(equalToConstant: 34)
  ])
  
  */
 //Create Items
 func createProfileImageView() -> UIImageView {
     let imageView = UIImageView()
     imageView.backgroundColor = .red
     return imageView
 }

 func createLabel() -> UILabel {
     let label = UILabel()
     label.backgroundColor = .green
     return label
 }

 func createUsernameLabel() -> UILabel {
     let label = UILabel()
     label.text = "username"
     label.backgroundColor = .purple
     return label
 }

 func createBioTextView() -> UITextView {
     let textView = UITextView()
     textView.backgroundColor = .yellow
     return textView
 }

 func createFollowButton() -> UIButton {
     let button = UIButton()
     button.backgroundColor = .cyan
     return button
 }

 */

//APPENDIX

/*
 
 
 import UIKit

 class YourViewController: UIViewController {
     
     let nameLabel = UILabel()
     let usernameLabel = UILabel()
     let bioTextView = UITextView()
     let followButton = UIButton(type: .system)
     let profileImageView = UIImageView() // Assume this is already initialized

     override func viewDidLoad() {
         super.viewDidLoad()

         // Add subviews
         view.addSubview(profileImageView)
         view.addSubview(nameLabel)
         view.addSubview(usernameLabel)
         view.addSubview(bioTextView)
         view.addSubview(followButton)

         // Disable autoresizing mask
         nameLabel.translatesAutoresizingMaskIntoConstraints = false
         usernameLabel.translatesAutoresizingMaskIntoConstraints = false
         bioTextView.translatesAutoresizingMaskIntoConstraints = false
         followButton.translatesAutoresizingMaskIntoConstraints = false

         setupConstraints()
     }

     private func setupConstraints() {
         // Constraints for nameLabel

         // Constraints for usernameLabel


         // Constraints for bioTextView
 

         // Constraints for followButton
         NSLayoutConstraint.activate([
             followButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
             followButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
             followButton.widthAnchor.constraint(equalToConstant: 120),
             followButton.heightAnchor.constraint(equalToConstant: 34)
         ])
     }
 }


 
//OLD
 
 class UserCell: DatasourceCell {
     
     override var datasourceItem: Any? {
         didSet {
 //            nameLabel.text = datasourceItem as? String
         }
     }
     
     let profileImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.backgroundColor = .red
         return imageView
     }()
     

     
     let usernameLabel: UILabel = {
         let label = UILabel()
         label.text = "username"
         label.backgroundColor = .purple
         return label
     }()
     
     let bioTextView: UITextView = {
         let textView = UITextView()
         textView.backgroundColor = .yellow
         return textView
     }()
     
     let followButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .cyan
         return button
     }()
     
     override func setupViews() {
         super.setupViews()
         
         addSubview(profileImageView)
         addSubview(nameLabel)
         addSubview(usernameLabel)
         addSubview(bioTextView)
         addSubview(followButton)
         
         profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
         
         nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
         
         usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
         
         bioTextView.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
         followButton.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
     }
 }


 
 wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
 wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
 wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
 wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
 


 
 let wordLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     return label
 }()




 */
