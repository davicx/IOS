//
//  CustomTableViewCell.swift
//  SingleViewVariableHeight
//
//  Created by David Vasquez on 10/1/24.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    private let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue // Change color for visibility
        view.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(subView)
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4) // 4-point bottom space
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with height: CGFloat) {
        // Any additional configuration can be done here
    }
}


//WORKING 1
/*
class CustomTableViewCell: UITableViewCell {
    
    private let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(subView)
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4) // 4-point bottom space
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with height: CGFloat) {
        // Any additional configuration can be done here
    }
}
*/
