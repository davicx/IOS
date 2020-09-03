//
//  FriendViewCell.swift
//  makeButtonClickable
//
//  Created by David Vasquez on 9/1/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

protocol addFriendProtocol {
    func addFriendClick(index: Int, friendName: String)
}

class FriendViewCell: UITableViewCell {

    var cellDelegate: addFriendProtocol?
    var index: IndexPath?
    var selectedFriendName: String?
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var addFriendButtonOutlet: UIButton!
    
    @IBAction func addFriendButton(_ sender: UIButton) {
        cellDelegate?.addFriendClick(index: index!.row, friendName: selectedFriendName!)
        flipButton(withString: "", on: sender)
    }
    
    func configure(with title: String) {
        addFriendButtonOutlet.setTitle(title, for: .normal)
    }
    
    func flipButton(withString addFriend: String, on button: UIButton) {
        //print(button.currentTitle!)
        
        if button.currentTitle == "Add" {
            button.setTitle("Remove", for: UIControl.State.normal)
        } else {
            button.setTitle("Add", for: UIControl.State.normal)
        }
        
    }

    


}


/*
 override func awakeFromNib() {
 super.awakeFromNib()
 // Initialization code
 }
 */
