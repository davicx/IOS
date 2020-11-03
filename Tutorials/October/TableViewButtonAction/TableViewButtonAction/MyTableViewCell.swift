//
//  MyTableViewCell.swift
//  TableViewButtonAction
//
//  Created by David Vasquez on 8/31/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit


protocol MyTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}


class MyTableViewCell: UITableViewCell {

    weak var delegate: MyTableViewCellDelegate?
    
    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    
    private var title: String = ""
    
    @IBAction func didTapButton() {
        delegate?.didTapButton(with: title)
    }
    
    func configure(with title: String) {
        
        button.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.blue, for: .normal)

    }

}
