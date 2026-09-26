//
//  UserViewController.swift
//  simpleSocial
//
//  Created by David Vasquez on 5/22/25.
//


import UIKit


protocol UserLikeDelegate: AnyObject {
    func didUpdateLikes(for user: User)
}

class UserViewController: UIViewController {

    var user: User! // allow setting this after init
    weak var delegate: UserLikeDelegate?

    let nameLabel = UILabel()
    let likesLabel = UILabel()
    let likeButton = UIButton(type: .system)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Detail"
        view.backgroundColor = .white

        nameLabel.text = user?.userName ?? ""
        likesLabel.text = "Likes: \(user?.totalLikes ?? 0)"
        likeButton.setTitle("Like Me!", for: .normal)

        [nameLabel, likesLabel, likeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            likesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),

            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 20),
        ])

        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
    }

    @objc func didTapLike() {
        user.totalLikes += 1
        likesLabel.text = "Likes: \(user.totalLikes)"
        delegate?.didUpdateLikes(for: user)
    }
}
