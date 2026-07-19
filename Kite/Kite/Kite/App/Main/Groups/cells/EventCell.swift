//
//  EventCell.swift
//  Kite
//
//  Created by David Vasquez on 7/18/26.
//


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS


import UIKit


class EventCell: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//EXAMPLE
/*
 
 //LOGIC
 //UI COMPONENTS
 //MANAGE VIEWS
 //LAYOUT and UI
 //ACTIONS
 //FUNCTIONS

 final class PostCell: UITableViewCell {

     //UI COMPONENTS
     //Kite
     private let postContent = PostContent()
     
     //Wishlist
     //private let postContent = ItemContent()
     private let postCaption = PostCaption()
     private let postSocials = PostSocials()
     private let mainDivider = MainDivider()

     //MANAGE VIEWS
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         [postContent, postCaption, postSocials, mainDivider].forEach {
             $0.translatesAutoresizingMaskIntoConstraints = false
             contentView.addSubview($0)
         }
         NSLayoutConstraint.activate([
             postContent.topAnchor.constraint(equalTo: contentView.topAnchor),
             postContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             postContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             postCaption.topAnchor.constraint(equalTo: postContent.bottomAnchor),
             postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             postSocials.topAnchor.constraint(equalTo: postCaption.bottomAnchor),
             postSocials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             postSocials.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             mainDivider.topAnchor.constraint(equalTo: postSocials.bottomAnchor),
             mainDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             mainDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             mainDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ])
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     //Configure socials with post so like count (and later like action) use live data.
     func configure(postID: Int) {
         postSocials.configure(postID: postID)

         if let post = PostDataController.shared.getPostByID(postID: postID) {
             postContent.configure(with: post)
             postCaption.configure(with: post)
         }
     }

     func updatePost(with post: Post) {
         postSocials.configure(postID: post.postID)
         postContent.configure(with: post)
         postCaption.configure(with: post)
     }

     func updateItem(with post: Post) {
         postSocials.configure(postID: post.postID)
         postContent.configure(with: post)
         postCaption.configure(with: post)
     }
 }
 */
