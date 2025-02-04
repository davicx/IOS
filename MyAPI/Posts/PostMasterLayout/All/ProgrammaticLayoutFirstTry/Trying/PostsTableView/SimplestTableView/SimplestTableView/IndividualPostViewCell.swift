//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit


//https://stackoverflow.com/questions/25180443/adjust-uilabel-height-to-text
//https://www.tutorialspoint.com/how-to-give-dynamic-height-to-uilabel-programmatically-in-swift
class IndividualPostViewCell: UITableViewCell {


    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    func setUser(currentUser: User) {
        userNameLabel.backgroundColor = .blue
        userImage.backgroundColor = .green
        userNameLabel.numberOfLines = 0
    
        userNameLabel.text = currentUser.userName
        userImage.image = currentUser.userImage

    }
    

    //userLabel.text = currentUser.userName
    //userImageView.image = currentUser.userImage
    //userLabel.adjustsFontForContentSizeCategory
    
    //let font = UIFont(name: "Helvetica", size: 20.0)
    //var height = heightForView(text: "This is just a load of text", font: font!, width: 100.0)


    //userLabel.numberOfLines = 0

    
    //userLabel.numberOfLines = 500
    //userLabel.sizeToFit()
    /*
     func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        //label.numberOfLines = 0
        //label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //label.font = font
        //label.text = text

        //label.sizeToFit()
        //return label.frame.height
    }
     */

}


/*
 class MyTableViewCell: UITableViewCell {

     let myLabel: UILabel = {
         let label = UILabel()
         label.numberOfLines = 0  // Allows for multiple lines
         label.lineBreakMode = .byWordWrapping
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(myLabel)
         
         // Add constraints
         NSLayoutConstraint.activate([
             myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
         ])
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
 */
