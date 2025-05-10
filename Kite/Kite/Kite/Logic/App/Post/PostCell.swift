//
//  PostCell.swift
//  Kite
//
//  Created by David Vasquez on 4/25/25.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func didTapLikePostButton(in cell: PostCell)
}

class PostCell: UITableViewCell {
    weak var delegate: PostCellDelegate?

    let postImage = UIImageView()
    let postCaptionLabel = UILabel()
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let likeStackView = UIStackView()
    let dividerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostViews()
        setupButtonTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //ACTIONS
    func setupButtonTarget() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    @objc private func likeButtonTapped() {
        delegate?.didTapLikePostButton(in: self)
    }

    //CELL SETUP
    func configurePost(with post: Post) {
        postImage.image = post.postImageData ?? UIImage(named: Constants.Image.fallbackPostImage)
        postCaptionLabel.text = post.postCaption
        likeCountLabel.text = "\(post.simpleLikesArray?.count ?? 0)"

        let imageName = post.isLikedByCurrentUser == true ? "liked" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)

        stopLoading()
    }

    
    //FUNCTIONS
    func startLoading() {
        likeButton.isHidden = true
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        likeButton.isHidden = false
    }
    
    //STYLE
    private func setupPostViews() {
        contentView.addSubview(postImage)
        contentView.addSubview(postCaptionLabel)
        contentView.addSubview(likeStackView)
        contentView.addSubview(dividerView)

        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false

        postCaptionLabel.numberOfLines = 0
        postCaptionLabel.font = .systemFont(ofSize: 16)
        postCaptionLabel.translatesAutoresizingMaskIntoConstraints = false

        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.font = .systemFont(ofSize: 18)
        likeCountLabel.textAlignment = .center

        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        likeStackView.axis = .horizontal
        likeStackView.distribution = .fillEqually
        likeStackView.spacing = 8
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.addArrangedSubview(likeCountLabel)
        likeStackView.addArrangedSubview(likeButton)
        likeStackView.addArrangedSubview(activityIndicator)

        dividerView.backgroundColor = .blue
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),

            postCaptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postCaptionLabel.heightAnchor.constraint(equalToConstant: 200),

            likeStackView.topAnchor.constraint(equalTo: postCaptionLabel.bottomAnchor, constant: 16),
            likeStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            likeStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            likeStackView.heightAnchor.constraint(equalToConstant: 40),

            dividerView.topAnchor.constraint(equalTo: likeStackView.bottomAnchor, constant: 8),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

}
