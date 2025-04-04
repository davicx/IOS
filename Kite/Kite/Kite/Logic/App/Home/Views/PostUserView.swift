//
//  PostUserView.swift
//  Kite
//
//  Created by David Vasquez on 4/3/25.
//

import UIKit



class PostUserView: UIView {
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Convenience init for auto layout usage
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomDivider)
        bringSubviewToFront(bottomDivider) // Ensures the divider is always visible
        
        NSLayoutConstraint.activate([
            bottomDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomDivider.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomDivider.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomDivider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

