//
//  SimpleTopView.swift
//  Kite
//
//  Created by David Vasquez on 3/11/25.
//


import UIKit


class SimpleTopView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hi"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

