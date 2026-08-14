//
//  PostHeaderLayout.swift
//  Kite
//
//  Created by David Vasquez on 7/15/25.
//

import UIKit



/*
class PostHeaderLayout: UIView {

    private let headerView: UIView = componentFunctions.createHeaderView()


    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Layout
        setupHeader()
        
        setupGroupImage()
        setupGroupName()
        setupGroupMenu()
        
        //Actions
        setupMenu()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT
    //Setup Main Header
    private func setupHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)

        headerView.addSubview(postHeaderGroupImageView)
        headerView.addSubview(postHeaderGroupNameView)
        headerView.addSubview(postHeaderGroupMenuView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            postHeaderGroupImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            postHeaderGroupImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            postHeaderGroupImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            postHeaderGroupImageView.widthAnchor.constraint(equalToConstant: 60),

            postHeaderGroupMenuView.topAnchor.constraint(equalTo: headerView.topAnchor),
            postHeaderGroupMenuView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            postHeaderGroupMenuView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            postHeaderGroupMenuView.widthAnchor.constraint(equalToConstant: 40),

            postHeaderGroupNameView.topAnchor.constraint(equalTo: headerView.topAnchor),
            postHeaderGroupNameView.leadingAnchor.constraint(equalTo: postHeaderGroupImageView.trailingAnchor),
            postHeaderGroupNameView.trailingAnchor.constraint(equalTo: postHeaderGroupMenuView.leadingAnchor),
            postHeaderGroupNameView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ])
    }

    
    //Setup Group Image
    private func setupGroupImage() {
        postHeaderGroupImageView.addSubview(groupImageView)
        
        //Group Image View inside Group Image Container (Move 2 left 2 down)
        NSLayoutConstraint.activate([
            groupImageView.centerXAnchor.constraint(equalTo: postHeaderGroupImageView.centerXAnchor, constant: 0),
            groupImageView.centerYAnchor.constraint(equalTo: postHeaderGroupImageView.centerYAnchor, constant: 0),
            groupImageView.widthAnchor.constraint(equalToConstant: 46),
            groupImageView.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    //Setup Group Name
    private func setupGroupName() {
        //Add labels to Group Name View
        postHeaderGroupNameView.addSubview(groupTitleLabel)
        postHeaderGroupNameView.addSubview(groupSubtitleLabel)
        
        NSLayoutConstraint.activate([
            // Move title DOWN by 4
            groupTitleLabel.topAnchor.constraint(equalTo: postHeaderGroupNameView.topAnchor, constant: -4),
            groupTitleLabel.leadingAnchor.constraint(equalTo: postHeaderGroupNameView.leadingAnchor, constant: 8),
            groupTitleLabel.trailingAnchor.constraint(equalTo: postHeaderGroupNameView.trailingAnchor, constant: -8),

            // Move subtitle UP by using negative spacing between the labels
            groupSubtitleLabel.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor, constant: -22),
            groupSubtitleLabel.leadingAnchor.constraint(equalTo: postHeaderGroupNameView.leadingAnchor, constant: 8),
            groupSubtitleLabel.trailingAnchor.constraint(equalTo: postHeaderGroupNameView.trailingAnchor, constant: -8),
            groupSubtitleLabel.bottomAnchor.constraint(equalTo: postHeaderGroupNameView.bottomAnchor),

            groupTitleLabel.heightAnchor.constraint(equalTo: groupSubtitleLabel.heightAnchor)
        ])

    }

    //Setup Group Menu
    private func setupGroupMenu() {
        postHeaderGroupMenuView.addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24),

        ])
    }
    

    //ACTIONS
    //Menu
    private func setupMenu() {
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { _ in
            print("Edit tapped")
        }

        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            print("Delete tapped")
        }

        let menu = UIMenu(title: "", children: [editAction, deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    //LABELS AND UI
    //LABELS: Group Image
    let postHeaderGroupImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let groupImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_20"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24 // Half of 48 for round shape
        return imageView
    }()
    
    //LABELS: Group Name
    let postHeaderGroupNameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let postHeaderGroupMenuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Group Name Labels
    private let groupTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Group Title"
        return label
    }()

    private let groupSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtitle"
        return label
    }()


    //LABELS: Group Menu
    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu-horizontal")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    //SETUP
    func configure(with post: Post) {
        //Set group image
        if let image = post.groupImageData {
            groupImageView.image = image
        }

        //Set title (group name from post data)
        if let groupName = post.groupName {
            groupTitleLabel.text = groupName
        } else {
            groupTitleLabel.text = "Group Name"
        }

        //Set subtitle (time message)
        if let time = post.timeMessage {
            groupSubtitleLabel.text = time
        }
    }
}


*/
