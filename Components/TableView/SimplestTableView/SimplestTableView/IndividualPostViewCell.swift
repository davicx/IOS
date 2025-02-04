//
//  IndividualPostViewCell.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit

class IndividualPostViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    
    func setUser(currentUser: String) {
        userLabel.text = currentUser

    }

}
