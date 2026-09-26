//
//  FriendTableViewCell.swift
//  TableViewProgrammatic
//
//  Created by David Vasquez on 8/30/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    static let identifier = "FriendTableViewCell"
    
    
    private let _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.tintColor = .blue
        _switch.isOn = true
        return _switch
        
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("hi")
        
        
        //let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //button.backgroundColor = .blue
        //button.setTitle("Test Button", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //self.view.addSubview(button)
        
        //contentView.backgroundColor = .blue
        contentView.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _switch.frame = CGRect(x: 5, y: 5, width: 100, height: contentView.frame.size.height - 10)
    }
    
    /*
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    */
}



/*
override func viewDidLoad() {
    super.viewDidLoad()
    
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    button.backgroundColor = .green
    button.setTitle("Test Button", for: .normal)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    
    self.view.addSubview(button)
}

@objc func buttonAction(sender: UIButton!) {
    print("Button tapped")
}
*/
