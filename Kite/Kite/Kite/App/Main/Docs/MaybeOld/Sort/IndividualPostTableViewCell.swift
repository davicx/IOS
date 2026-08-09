//
//  IndividualPostTableViewCell.swift
//  Kite
//
//  Created by David Vasquez on 7/7/25.
//

import UIKit

/*
class IndividualPostTableViewCell: UITableViewCell {
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(postLabel)
        
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with post: Post) {
        let postID = post.postID
        let caption = post.postCaption ?? "No caption"
        postLabel.text = "ID: \(postID) - \(caption)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postLabel.text = nil
    }
}
*/
