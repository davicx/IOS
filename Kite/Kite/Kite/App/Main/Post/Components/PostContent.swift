//
//  PostContent.swift
//  Kite
//
//  Created by David Vasquez on 2/23/26.
//

import UIKit


final class PostContent: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
        let label = UILabel()
        label.text = "PostContent"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
