//
//  CustomCell.swift
//  SwiftUITableViewwithCustomCells
//
//  Created by David on 7/4/24.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
