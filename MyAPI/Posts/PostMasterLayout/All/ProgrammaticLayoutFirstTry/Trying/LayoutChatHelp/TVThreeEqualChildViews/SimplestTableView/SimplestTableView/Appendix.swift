//
//  Appendix.swift
//  SimplestTableView
//
//  Created by David Vasquez on 9/23/24.
//

import Foundation


/*
 private let postImageView: UIImageView = {
     let imageView = UIImageView()
     imageView.contentMode = .scaleAspectFill
     imageView.clipsToBounds = true
     return imageView
 }()
 
 private let bottomBorder: UIView = {
         let view = UIView()
         view.backgroundColor = .red
         return view
     }()
 
 
 setupBottomBorder()
 
 
 private func setupBottomBorder() {
     contentView.addSubview(bottomBorder)
     bottomBorder.translatesAutoresizingMaskIntoConstraints = false
     
     NSLayoutConstraint.activate([
         bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         bottomBorder.heightAnchor.constraint(equalToConstant: 1) // Set height for the border
     ])
 }

 */


//Leading = Left
//Trailing = Right (This must be negative)
/*
func setImageConstraints() {
    postImageView.translatesAutoresizingMaskIntoConstraints = false

    
    NSLayoutConstraint.activate([
            
        postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        postImageView.heightAnchor.constraint(equalToConstant: 400), // Set your desired height
        postImageView.widthAnchor.constraint(equalToConstant: 400) // Set your desired height
    ])
    //postImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    //postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
    //postImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
    //postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier:16/9).isActive = true
}
*/

/*
func configure(with image: UIImage?, width: CGFloat, height: CGFloat) {

    postImageView.image = image
    
    // Update the image view's height constraint
    postImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    // Optionally adjust the width if needed, but it's full width by default
    // You could adjust if the layout requires it
}
*/
/*
 private func setupImageView() {
     contentView.addSubview(customImageView)
     customImageView.translatesAutoresizingMaskIntoConstraints = false

     NSLayoutConstraint.activate([
         customImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
         customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         customImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         customImageView.heightAnchor.constraint(equalToConstant: 200) // Set your desired height
     ])
 }

 */




/*
 
 import UIKit

 class CustomTableViewCell: UITableViewCell {

     private let customImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         return imageView
     }()

     private let bottomBorder: UIView = {
         let view = UIView()
         view.backgroundColor = .lightGray
         return view
     }()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupImageView()
         setupBottomBorder()
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setupImageView()
         setupBottomBorder()
     }

     private func setupImageView() {
         contentView.addSubview(customImageView)
         customImageView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             customImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             customImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             customImageView.heightAnchor.constraint(equalToConstant: 200) // Placeholder height
         ])
     }

     private func setupBottomBorder() {
         contentView.addSubview(bottomBorder)
         bottomBorder.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             bottomBorder.heightAnchor.constraint(equalToConstant: 1)
         ])
     }


     func configure(with image: UIImage?, width: CGFloat, height: CGFloat) {
         customImageView.image = image
         
         // Update the image view's height constraint
         customImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
         
         // Optionally adjust the width if needed, but it's full width by default
         // You could adjust if the layout requires it
     }
 }


 
 */
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
//APPENDIX
/*
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


 //
 */

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
