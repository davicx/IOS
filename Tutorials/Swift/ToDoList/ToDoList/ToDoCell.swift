//
//  ToDoCell.swift
//  ToDoList
//
//  Created by David Vasquez on 7/27/24.
//

import UIKit

class ToDoCell: UITableViewCell {

    
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

struct Todo {
    var title: String
    var isMarked: Bool
}
