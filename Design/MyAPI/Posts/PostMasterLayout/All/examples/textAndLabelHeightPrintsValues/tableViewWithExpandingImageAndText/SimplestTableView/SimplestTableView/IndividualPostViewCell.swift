//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit

class IndividualPostViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    func setUser(currentUser: User) {
        userLabel.text = currentUser.userName
        userLabel.numberOfLines = 0
        
        userImageView.image = currentUser.userImage

    }

}


/*
 class IndividualPostViewCell: UITableViewCell {

     @IBOutlet weak var userLabel: UILabel!
     
     func setUser(currentUser: String) {
         userLabel.text = currentUser
         userLabel.numberOfLines = 0

     }

 }
 */
