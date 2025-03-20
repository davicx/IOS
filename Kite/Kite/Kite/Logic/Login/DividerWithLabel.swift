//
//  DividerWithLabel.swift
//  Kite
//
//  Created by David Vasquez on 3/17/25.
//


import UIKit



class DividerWithLabel: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    private let rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(leftLine)
        addSubview(label)
        addSubview(rightLine)
        
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLine.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            leftLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rightLine.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

//USE
/*
 let divider = DividerWithLabel()
 divider.translatesAutoresizingMaskIntoConstraints = false
 parentView.addSubview(divider)

 NSLayoutConstraint.activate([
     divider.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20),
     divider.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20),
     divider.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
     divider.heightAnchor.constraint(equalToConstant: 20)
 ])

 */
