//
//  ImageDisplayCell.swift
//  ImageLayoutExamples
//
//  Created by David Vasquez on 7/19/25.
//

import UIKit


class ImageDisplayCell: UITableViewCell {

    private let displayImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return iv
    }()

    private let modeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        containerStackView.addArrangedSubview(displayImageView)
        containerStackView.addArrangedSubview(modeLabel)
        contentView.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            containerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func configure(imageName: String, contentMode: UIView.ContentMode, labelText: String) {
        displayImageView.image = UIImage(named: imageName)
        displayImageView.contentMode = contentMode
        modeLabel.text = labelText
    }
}

