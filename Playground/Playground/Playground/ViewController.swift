//
//  ViewController.swift
//  Playground
//
//  Created by David Vasquez on 12/11/24.
//

import UIKit


//WISHLIST: One
/*
final class ViewController: UIViewController {

    // MARK: - UI COMPONENTS

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let topBar = UIView()
    private let backButton = UIButton(type: .system)
    private let pageTitleLabel = UILabel()
    private let addButton = UIButton(type: .system)

    private let listHeaderView = UIView()
    private let listImageView = UIImageView()
    private let listTitleLabel = UILabel()
    private let listDescriptionLabel = UILabel()
    private let privateLabel = UILabel()
    private let listMenuButton = UIButton(type: .system)

    private let inviteButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)

    private let segmentContainer = UIView()
    private let postsButton = UIButton(type: .system)
    private let itemsButton = UIButton(type: .system)
    private let selectedLine = UIView()

    private let postsStackView = UIStackView()

    private let bottomBar = UIView()

    // MARK: - MANAGE VIEWS

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupScrollView()
        setupTopBar()
        setupListHeader()
        setupSegmentControl()
        setupPosts()
        setupBottomBar()
    }

    // MARK: - LAYOUT

    private func setupScrollView() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -82),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupTopBar() {

        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemBackground

        view.addSubview(topBar)

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 72)
        ])

        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.systemGray5

        topBar.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: topBar.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )
        backButton.tintColor = .label
        backButton.backgroundColor = UIColor.systemGray6
        backButton.layer.cornerRadius = 25

        topBar.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageTitleLabel.text = "Cool Stuff"
        pageTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        pageTitleLabel.textAlignment = .center

        topBar.addSubview(pageTitleLabel)

        NSLayoutConstraint.activate([
            pageTitleLabel.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            pageTitleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])

        addButton.translatesAutoresizingMaskIntoConstraints = false

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(
            red: 1.0,
            green: 0.18,
            blue: 0.35,
            alpha: 1
        )
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 5

        addButton.configuration = configuration

        topBar.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -20),
            addButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 76),
            addButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupListHeader() {

        listHeaderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listHeaderView)

        NSLayoutConstraint.activate([
            listHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listHeaderView.heightAnchor.constraint(equalToConstant: 180)
        ])

        listImageView.translatesAutoresizingMaskIntoConstraints = false
        listImageView.image = UIImage(systemName: "gift.fill")
        listImageView.tintColor = .white
        listImageView.backgroundColor = UIColor(
            red: 0.93,
            green: 0.12,
            blue: 0.12,
            alpha: 1
        )
        listImageView.contentMode = .scaleAspectFit
        listImageView.layer.cornerRadius = 20
        listImageView.clipsToBounds = true

        listHeaderView.addSubview(listImageView)

        NSLayoutConstraint.activate([
            listImageView.leadingAnchor.constraint(equalTo: listHeaderView.leadingAnchor, constant: 20),
            listImageView.topAnchor.constraint(equalTo: listHeaderView.topAnchor, constant: 18),
            listImageView.widthAnchor.constraint(equalToConstant: 110),
            listImageView.heightAnchor.constraint(equalToConstant: 110)
        ])

        listTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        listTitleLabel.text = "Cool Stuff"
        listTitleLabel.font = .systemFont(ofSize: 25, weight: .bold)

        listHeaderView.addSubview(listTitleLabel)

        NSLayoutConstraint.activate([
            listTitleLabel.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: 16),
            listTitleLabel.topAnchor.constraint(equalTo: listImageView.topAnchor, constant: 4)
        ])

        listDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        listDescriptionLabel.text = "Gift ideas, wants and favorites!"
        listDescriptionLabel.font = .systemFont(ofSize: 16)
        listDescriptionLabel.textColor = .secondaryLabel

        listHeaderView.addSubview(listDescriptionLabel)

        NSLayoutConstraint.activate([
            listDescriptionLabel.leadingAnchor.constraint(equalTo: listTitleLabel.leadingAnchor),
            listDescriptionLabel.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: 3),
            listDescriptionLabel.trailingAnchor.constraint(equalTo: listHeaderView.trailingAnchor, constant: -20)
        ])

        privateLabel.translatesAutoresizingMaskIntoConstraints = false
        privateLabel.text = "🔒  Private List"
        privateLabel.font = .systemFont(ofSize: 15)
        privateLabel.textColor = .secondaryLabel

        listHeaderView.addSubview(privateLabel)

        NSLayoutConstraint.activate([
            privateLabel.leadingAnchor.constraint(equalTo: listTitleLabel.leadingAnchor),
            privateLabel.topAnchor.constraint(equalTo: listDescriptionLabel.bottomAnchor, constant: 7)
        ])

        listMenuButton.translatesAutoresizingMaskIntoConstraints = false
        listMenuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        listMenuButton.tintColor = .label

        listHeaderView.addSubview(listMenuButton)

        NSLayoutConstraint.activate([
            listMenuButton.trailingAnchor.constraint(equalTo: listHeaderView.trailingAnchor, constant: -20),
            listMenuButton.topAnchor.constraint(equalTo: listHeaderView.topAnchor, constant: 16),
            listMenuButton.widthAnchor.constraint(equalToConstant: 36),
            listMenuButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        configureOutlineButton(
            inviteButton,
            title: "Invite Friends",
            image: "person.2"
        )

        configureOutlineButton(
            shareButton,
            title: "Share List",
            image: "square.and.arrow.up"
        )

        let buttonStack = UIStackView(arrangedSubviews: [
            inviteButton,
            shareButton
        ])

        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually

        listHeaderView.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: listTitleLabel.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: listHeaderView.trailingAnchor, constant: -20),
            buttonStack.topAnchor.constraint(equalTo: privateLabel.bottomAnchor, constant: 10),
            buttonStack.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    private func setupSegmentControl() {

        segmentContainer.translatesAutoresizingMaskIntoConstraints = false
        segmentContainer.backgroundColor = UIColor.systemGray6
        segmentContainer.layer.cornerRadius = 14

        contentView.addSubview(segmentContainer)

        NSLayoutConstraint.activate([
            segmentContainer.topAnchor.constraint(equalTo: listHeaderView.bottomAnchor, constant: 4),
            segmentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            segmentContainer.heightAnchor.constraint(equalToConstant: 52)
        ])

        postsButton.translatesAutoresizingMaskIntoConstraints = false
        postsButton.setTitle("Posts", for: .normal)
        postsButton.setTitleColor(.label, for: .normal)
        postsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        itemsButton.translatesAutoresizingMaskIntoConstraints = false
        itemsButton.setTitle("Items", for: .normal)
        itemsButton.setTitleColor(.secondaryLabel, for: .normal)

        segmentContainer.addSubview(postsButton)
        segmentContainer.addSubview(itemsButton)

        NSLayoutConstraint.activate([
            postsButton.leadingAnchor.constraint(equalTo: segmentContainer.leadingAnchor),
            postsButton.topAnchor.constraint(equalTo: segmentContainer.topAnchor),
            postsButton.bottomAnchor.constraint(equalTo: segmentContainer.bottomAnchor),
            postsButton.widthAnchor.constraint(equalTo: segmentContainer.widthAnchor, multiplier: 0.5),

            itemsButton.trailingAnchor.constraint(equalTo: segmentContainer.trailingAnchor),
            itemsButton.topAnchor.constraint(equalTo: segmentContainer.topAnchor),
            itemsButton.bottomAnchor.constraint(equalTo: segmentContainer.bottomAnchor),
            itemsButton.widthAnchor.constraint(equalTo: segmentContainer.widthAnchor, multiplier: 0.5)
        ])

        selectedLine.translatesAutoresizingMaskIntoConstraints = false
        selectedLine.backgroundColor = UIColor(
            red: 1,
            green: 0.18,
            blue: 0.35,
            alpha: 1
        )
        selectedLine.layer.cornerRadius = 1.5

        segmentContainer.addSubview(selectedLine)

        NSLayoutConstraint.activate([
            selectedLine.bottomAnchor.constraint(equalTo: segmentContainer.bottomAnchor),
            selectedLine.centerXAnchor.constraint(equalTo: postsButton.centerXAnchor),
            selectedLine.widthAnchor.constraint(equalToConstant: 100),
            selectedLine.heightAnchor.constraint(equalToConstant: 3)
        ])
    }

    private func setupPosts() {

        postsStackView.translatesAutoresizingMaskIntoConstraints = false
        postsStackView.axis = .vertical
        postsStackView.spacing = 16

        contentView.addSubview(postsStackView)

        NSLayoutConstraint.activate([
            postsStackView.topAnchor.constraint(equalTo: segmentContainer.bottomAnchor, constant: 16),
            postsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            postsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            postsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        let postOne = WishlistPostView(
            username: "davey",
            date: "10 months ago",
            itemName: "Live A Live",
            price: "$49.99",
            description: "Such a unique RPG! Can’t wait to play this one.",
            imageName: "gamecontroller.fill",
            likes: "4",
            comments: "2"
        )

        let postTwo = WishlistPostView(
            username: "sarahm",
            date: "1y ago",
            itemName: "AirPods Max",
            price: "$549.00",
            description: "Great sound and super comfy!",
            imageName: "headphones",
            likes: "3",
            comments: "1"
        )

        postsStackView.addArrangedSubview(postOne)
        postsStackView.addArrangedSubview(postTwo)
    }

    private func setupBottomBar() {

        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .systemBackground

        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOpacity = 0.08
        bottomBar.layer.shadowRadius = 10
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -2)

        view.addSubview(bottomBar)

        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 78)
        ])

        bottomBar.layer.cornerRadius = 32

        let home = makeTab(title: "Home", icon: "house", selected: false)
        let lists = makeTab(title: "Lists", icon: "gift", selected: true)
        let friends = makeTab(title: "Friends", icon: "person.2", selected: false)
        let discover = makeTab(title: "Discover", icon: "safari", selected: false)
        let profile = makeTab(title: "Profile", icon: "person", selected: false)

        let stack = UIStackView(arrangedSubviews: [
            home,
            lists,
            friends,
            discover,
            profile
        ])

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        bottomBar.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 6),
            stack.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -6),
            stack.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 6),
            stack.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -4)
        ])
    }

    // MARK: - FUNCTIONS

    private func configureOutlineButton(
        _ button: UIButton,
        title: String,
        image: String
    ) {

        var configuration = UIButton.Configuration.plain()

        configuration.title = title
        configuration.image = UIImage(systemName: image)
        configuration.imagePadding = 7
        configuration.baseForegroundColor = .label

        button.configuration = configuration

        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 18
    }

    private func makeTab(
        title: String,
        icon: String,
        selected: Bool
    ) -> UIView {

        let container = UIView()

        let imageView = UIImageView(
            image: UIImage(systemName: icon)
        )

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        let selectedColor = UIColor(
            red: 1,
            green: 0.18,
            blue: 0.35,
            alpha: 1
        )

        imageView.tintColor = selected ? selectedColor : .label

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = .systemFont(
            ofSize: 11,
            weight: selected ? .semibold : .regular
        )
        label.textColor = selected ? selectedColor : .label
        label.textAlignment = .center

        container.addSubview(imageView)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 27),
            imageView.heightAnchor.constraint(equalToConstant: 27),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])

        return container
    }
}



private final class  WishlistPostView: UIView {

    private let userImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let dateLabel = UILabel()
    private let menuButton = UIButton(type: .system)

    private let itemImageContainer = UIView()
    private let itemImageView = UIImageView()

    private let itemNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let purchaseButton = UIButton(type: .system)

    private let socialsStack = UIStackView()

    init(
        username: String,
        date: String,
        itemName: String,
        price: String,
        description: String,
        imageName: String,
        likes: String,
        comments: String
    ) {

        super.init(frame: .zero)

        setupView()

        usernameLabel.text = username
        dateLabel.text = date
        itemNameLabel.text = itemName
        priceLabel.text = price
        descriptionLabel.text = description

        itemImageView.image = UIImage(systemName: imageName)

        setupSocials(
            likes: likes,
            comments: comments
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground

        layer.cornerRadius = 22
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 3)

        heightAnchor.constraint(equalToConstant: 420).isActive = true

        setupHeader()
        setupItem()
        setupPurchase()
    }

    private func setupHeader() {

        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.image = UIImage(systemName: "person.crop.circle.fill")
        userImageView.tintColor = .systemBlue
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = 22
        userImageView.clipsToBounds = true

        addSubview(userImageView)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = .systemFont(ofSize: 17, weight: .bold)

        addSubview(usernameLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .secondaryLabel

        addSubview(dateLabel)

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.setImage(
            UIImage(systemName: "ellipsis"),
            for: .normal
        )
        menuButton.tintColor = .label

        addSubview(menuButton)

        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            userImageView.widthAnchor.constraint(equalToConstant: 44),
            userImageView.heightAnchor.constraint(equalToConstant: 44),

            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            usernameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),

            dateLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 8),
            dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            menuButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 36),
            menuButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func setupItem() {

        itemImageContainer.translatesAutoresizingMaskIntoConstraints = false
        itemImageContainer.backgroundColor = UIColor.systemGray6
        itemImageContainer.layer.cornerRadius = 16

        addSubview(itemImageContainer)

        NSLayoutConstraint.activate([
            itemImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            itemImageContainer.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 14),
            itemImageContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.39),
            itemImageContainer.heightAnchor.constraint(equalToConstant: 245)
        ])

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.tintColor = .label
        itemImageView.contentMode = .scaleAspectFit

        itemImageContainer.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: itemImageContainer.leadingAnchor, constant: 16),
            itemImageView.trailingAnchor.constraint(equalTo: itemImageContainer.trailingAnchor, constant: -16),
            itemImageView.topAnchor.constraint(equalTo: itemImageContainer.topAnchor, constant: 16),
            itemImageView.bottomAnchor.constraint(equalTo: itemImageContainer.bottomAnchor, constant: -16)
        ])

        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = .systemFont(ofSize: 21, weight: .bold)
        itemNameLabel.numberOfLines = 2

        addSubview(itemNameLabel)

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        addSubview(priceLabel)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 3

        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageContainer.trailingAnchor, constant: 18),
            itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            itemNameLabel.topAnchor.constraint(equalTo: itemImageContainer.topAnchor, constant: 4),

            priceLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 6),

            descriptionLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 14)
        ])
    }

    private func setupPurchase() {

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false

        var configuration = UIButton.Configuration.filled()

        configuration.title = "Purchase"
        configuration.image = UIImage(systemName: "cart")
        configuration.imagePadding = 9
        configuration.baseBackgroundColor = UIColor(
            red: 1,
            green: 0.18,
            blue: 0.35,
            alpha: 1
        )
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium

        purchaseButton.configuration = configuration

        addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            purchaseButton.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            purchaseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            purchaseButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 18),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        socialsStack.translatesAutoresizingMaskIntoConstraints = false
        socialsStack.axis = .horizontal
        socialsStack.spacing = 22
        socialsStack.alignment = .center

        addSubview(socialsStack)

        NSLayoutConstraint.activate([
            socialsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            socialsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            socialsStack.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupSocials(
        likes: String,
        comments: String
    ) {

        socialsStack.addArrangedSubview(
            socialView(
                icon: "heart",
                value: likes,
                tint: UIColor(
                    red: 1,
                    green: 0.18,
                    blue: 0.35,
                    alpha: 1
                )
            )
        )

        socialsStack.addArrangedSubview(
            socialView(
                icon: "bubble.left",
                value: comments,
                tint: .label
            )
        )

        socialsStack.addArrangedSubview(
            socialView(
                icon: "bookmark",
                value: nil,
                tint: .label
            )
        )
    }

    private func socialView(
        icon: String,
        value: String?,
        tint: UIColor
    ) -> UIView {

        let container = UIView()

        let imageView = UIImageView(
            image: UIImage(systemName: icon)
        )

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tint
        imageView.contentMode = .scaleAspectFit

        container.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 26),
            imageView.heightAnchor.constraint(equalToConstant: 26)
        ])

        if let value {

            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = value
            label.font = .systemFont(ofSize: 15)

            container.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
                label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])

        } else {

            imageView.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ).isActive = true
        }

        return container
    }
}
 */


import UIKit

final class ViewController: UIViewController {

    // MARK: - COLORS

    private let pink = UIColor(red: 1.00, green: 0.18, blue: 0.35, alpha: 1.0)
    private let pageBackground = UIColor(red: 0.975, green: 0.978, blue: 0.985, alpha: 1.0)
    private let softGray = UIColor(red: 0.95, green: 0.955, blue: 0.965, alpha: 1.0)

    // MARK: - UI COMPONENTS

    private let headerView = UIView()
    private let backButton = UIButton(type: .system)
    private let headerTitle = UILabel()
    private let addButton = UIButton(type: .system)

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // List header
    private let listHeaderView = UIView()
    private let listImageView = UIImageView()
    private let listTitle = UILabel()
    private let listDescription = UILabel()
    private let privateLabel = UILabel()
    private let listMenuButton = UIButton(type: .system)

    private let inviteButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)

    // Segment
    private let segmentView = UIView()
    private let postsButton = UIButton(type: .system)
    private let itemsButton = UIButton(type: .system)
    private let selectedLine = UIView()

    // Posts
    private let postsStack = UIStackView()

    // Bottom nav
    private let bottomBar = UIView()

    // MARK: - MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = pageBackground

        setupHeader()
        setupBottomNavigation()
        setupScrollView()

        setupListHeader()
        setupSegment()
        setupPosts()
    }

    // MARK: - HEADER

    private func setupHeader() {

        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemBackground

        view.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 62)
        ])

        // Back

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            UIImage(
                systemName: "chevron.left",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 20,
                    weight: .medium
                )
            ),
            for: .normal
        )

        backButton.tintColor = .label

        headerView.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 42),
            backButton.heightAnchor.constraint(equalToConstant: 42)
        ])

        // Title

        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.text = "Cool Stuff"
        headerTitle.font = .systemFont(ofSize: 20, weight: .bold)
        headerTitle.textAlignment = .center

        headerView.addSubview(headerTitle)

        NSLayoutConstraint.activate([
            headerTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        // Plus

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = pink
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 13

        addButton.setImage(
            UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 20,
                    weight: .medium
                )
            ),
            for: .normal
        )

        headerView.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18),
            addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 48),
            addButton.heightAnchor.constraint(equalToConstant: 38)
        ])

        // Separator

        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.systemGray5

        headerView.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    // MARK: - SCROLL VIEW

    private func setupScrollView() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.backgroundColor = pageBackground
        scrollView.showsVerticalScrollIndicator = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.bottomAnchor.constraint(
                equalTo: bottomBar.topAnchor,
                constant: -4
            ),

            contentView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),

            contentView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),

            contentView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),

            contentView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),

            contentView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            )
        ])
    }

    // MARK: - LIST HEADER

    private func setupListHeader() {

        listHeaderView.translatesAutoresizingMaskIntoConstraints = false
        listHeaderView.backgroundColor = .systemBackground

        contentView.addSubview(listHeaderView)

        NSLayoutConstraint.activate([
            listHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listHeaderView.heightAnchor.constraint(equalToConstant: 166)
        ])

        // Image

        listImageView.translatesAutoresizingMaskIntoConstraints = false

        listImageView.backgroundColor = UIColor(
            red: 0.75,
            green: 0.25,
            blue: 0.10,
            alpha: 1
        )

        listImageView.image = UIImage(systemName: "gift.fill")
        listImageView.tintColor = .white

        listImageView.contentMode = .scaleAspectFit
        listImageView.layer.cornerRadius = 15
        listImageView.clipsToBounds = true

        listHeaderView.addSubview(listImageView)

        NSLayoutConstraint.activate([
            listImageView.leadingAnchor.constraint(
                equalTo: listHeaderView.leadingAnchor,
                constant: 20
            ),

            listImageView.topAnchor.constraint(
                equalTo: listHeaderView.topAnchor,
                constant: 16
            ),

            listImageView.widthAnchor.constraint(equalToConstant: 76),
            listImageView.heightAnchor.constraint(equalToConstant: 76)
        ])

        // List title

        listTitle.translatesAutoresizingMaskIntoConstraints = false
        listTitle.text = "Cool Stuff"

        listTitle.font = .systemFont(
            ofSize: 21,
            weight: .bold
        )

        listHeaderView.addSubview(listTitle)

        NSLayoutConstraint.activate([
            listTitle.leadingAnchor.constraint(
                equalTo: listImageView.trailingAnchor,
                constant: 14
            ),

            listTitle.topAnchor.constraint(
                equalTo: listImageView.topAnchor,
                constant: 1
            )
        ])

        // Description

        listDescription.translatesAutoresizingMaskIntoConstraints = false

        listDescription.text = "Gift ideas, wants and favorites!"

        listDescription.font = .systemFont(ofSize: 14)

        listDescription.textColor = .secondaryLabel

        listHeaderView.addSubview(listDescription)

        NSLayoutConstraint.activate([
            listDescription.leadingAnchor.constraint(
                equalTo: listTitle.leadingAnchor
            ),

            listDescription.topAnchor.constraint(
                equalTo: listTitle.bottomAnchor,
                constant: 2
            ),

            listDescription.trailingAnchor.constraint(
                equalTo: listHeaderView.trailingAnchor,
                constant: -20
            )
        ])

        // Private

        privateLabel.translatesAutoresizingMaskIntoConstraints = false
        privateLabel.text = "🔒  Private List"
        privateLabel.font = .systemFont(ofSize: 13)
        privateLabel.textColor = .secondaryLabel

        listHeaderView.addSubview(privateLabel)

        NSLayoutConstraint.activate([
            privateLabel.leadingAnchor.constraint(
                equalTo: listTitle.leadingAnchor
            ),

            privateLabel.topAnchor.constraint(
                equalTo: listDescription.bottomAnchor,
                constant: 4
            )
        ])

        // Menu

        listMenuButton.translatesAutoresizingMaskIntoConstraints = false

        listMenuButton.setImage(
            UIImage(
                systemName: "ellipsis",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .bold
                )
            ),
            for: .normal
        )

        listMenuButton.tintColor = .label

        listHeaderView.addSubview(listMenuButton)

        NSLayoutConstraint.activate([
            listMenuButton.trailingAnchor.constraint(
                equalTo: listHeaderView.trailingAnchor,
                constant: -17
            ),

            listMenuButton.topAnchor.constraint(
                equalTo: listHeaderView.topAnchor,
                constant: 13
            ),

            listMenuButton.widthAnchor.constraint(equalToConstant: 36),
            listMenuButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        // Invite / Share

        setupHeaderButton(
            inviteButton,
            title: "Invite Friends",
            icon: "person.2"
        )

        setupHeaderButton(
            shareButton,
            title: "Share List",
            icon: "square.and.arrow.up"
        )

        let buttonStack = UIStackView(
            arrangedSubviews: [
                inviteButton,
                shareButton
            ]
        )

        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually

        listHeaderView.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(
                equalTo: listTitle.leadingAnchor
            ),

            buttonStack.trailingAnchor.constraint(
                equalTo: listHeaderView.trailingAnchor,
                constant: -20
            ),

            buttonStack.topAnchor.constraint(
                equalTo: privateLabel.bottomAnchor,
                constant: 8
            ),

            buttonStack.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    private func setupHeaderButton(
        _ button: UIButton,
        title: String,
        icon: String
    ) {

        var configuration = UIButton.Configuration.plain()

        configuration.title = title

        configuration.image = UIImage(
            systemName: icon
        )

        configuration.imagePadding = 6

        configuration.baseForegroundColor = .label

        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 8,
            bottom: 4,
            trailing: 8
        )

        button.configuration = configuration

        button.titleLabel?.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )

        button.layer.borderWidth = 1

        button.layer.borderColor =
            UIColor.systemGray4.cgColor

        button.layer.cornerRadius = 17
    }

    // MARK: - SEGMENT

    private func setupSegment() {

        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.backgroundColor = softGray
        segmentView.layer.cornerRadius = 12
        segmentView.clipsToBounds = true

        contentView.addSubview(segmentView)

        NSLayoutConstraint.activate([
            segmentView.topAnchor.constraint(
                equalTo: listHeaderView.bottomAnchor,
                constant: 8
            ),

            segmentView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 18
            ),

            segmentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -18
            ),

            segmentView.heightAnchor.constraint(equalToConstant: 48)
        ])

        // Posts

        postsButton.translatesAutoresizingMaskIntoConstraints = false
        postsButton.backgroundColor = .systemBackground
        postsButton.setTitle("Posts", for: .normal)
        postsButton.setTitleColor(.label, for: .normal)

        postsButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )

        segmentView.addSubview(postsButton)

        // Items

        itemsButton.translatesAutoresizingMaskIntoConstraints = false
        itemsButton.setTitle("Items", for: .normal)
        itemsButton.setTitleColor(.secondaryLabel, for: .normal)

        itemsButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )

        segmentView.addSubview(itemsButton)

        NSLayoutConstraint.activate([

            postsButton.leadingAnchor.constraint(
                equalTo: segmentView.leadingAnchor
            ),

            postsButton.topAnchor.constraint(
                equalTo: segmentView.topAnchor
            ),

            postsButton.bottomAnchor.constraint(
                equalTo: segmentView.bottomAnchor
            ),

            postsButton.widthAnchor.constraint(
                equalTo: segmentView.widthAnchor,
                multiplier: 0.5
            ),

            itemsButton.trailingAnchor.constraint(
                equalTo: segmentView.trailingAnchor
            ),

            itemsButton.topAnchor.constraint(
                equalTo: segmentView.topAnchor
            ),

            itemsButton.bottomAnchor.constraint(
                equalTo: segmentView.bottomAnchor
            ),

            itemsButton.widthAnchor.constraint(
                equalTo: segmentView.widthAnchor,
                multiplier: 0.5
            )
        ])

        // Pink line

        selectedLine.translatesAutoresizingMaskIntoConstraints = false
        selectedLine.backgroundColor = pink

        segmentView.addSubview(selectedLine)

        NSLayoutConstraint.activate([
            selectedLine.bottomAnchor.constraint(
                equalTo: segmentView.bottomAnchor
            ),

            selectedLine.centerXAnchor.constraint(
                equalTo: postsButton.centerXAnchor
            ),

            selectedLine.widthAnchor.constraint(equalToConstant: 90),
            selectedLine.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    // MARK: - POSTS

    private func setupPosts() {

        postsStack.translatesAutoresizingMaskIntoConstraints = false
        postsStack.axis = .vertical
        postsStack.spacing = 12

        contentView.addSubview(postsStack)

        NSLayoutConstraint.activate([
            postsStack.topAnchor.constraint(
                equalTo: segmentView.bottomAnchor,
                constant: 12
            ),

            postsStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),

            postsStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),

            postsStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            )
        ])

        let firstPost = CompactWishlistPostView(
            username: "davey",
            date: "10 months ago",
            itemName: "Live A Live",
            price: "$49.99",
            tags: ["Physical", "Nintendo Switch"],
            caption: "Such a unique RPG! Can’t wait to play this one.",
            imageSymbol: "gamecontroller.fill",
            likes: "4",
            comments: "2",
            pink: pink
        )

        let secondPost = CompactWishlistPostView(
            username: "sarahm",
            date: "1y ago",
            itemName: "AirPods Max",
            price: "$549.00",
            tags: ["Tech", "Apple"],
            caption: "Great sound and super comfy!",
            imageSymbol: "headphones",
            likes: "3",
            comments: "1",
            pink: pink
        )

        postsStack.addArrangedSubview(firstPost)
        postsStack.addArrangedSubview(secondPost)
    }

    // MARK: - BOTTOM NAVIGATION

    private func setupBottomNavigation() {

        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .systemBackground

        view.addSubview(bottomBar)

        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            bottomBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            bottomBar.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            bottomBar.heightAnchor.constraint(equalToConstant: 88)
        ])

        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.systemGray5

        bottomBar.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            separator.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        let home = makeTab(
            title: "Home",
            icon: "house",
            selected: false
        )

        let lists = makeTab(
            title: "Lists",
            icon: "gift",
            selected: true
        )

        let friends = makeTab(
            title: "Friends",
            icon: "person.2",
            selected: false
        )

        let discover = makeTab(
            title: "Discover",
            icon: "safari",
            selected: false
        )

        let profile = makeTab(
            title: "Profile",
            icon: "person",
            selected: false
        )

        let stack = UIStackView(
            arrangedSubviews: [
                home,
                lists,
                friends,
                discover,
                profile
            ]
        )

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        bottomBar.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(
                equalTo: bottomBar.leadingAnchor,
                constant: 6
            ),

            stack.trailingAnchor.constraint(
                equalTo: bottomBar.trailingAnchor,
                constant: -6
            ),

            stack.topAnchor.constraint(
                equalTo: bottomBar.topAnchor,
                constant: 5
            ),

            stack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func makeTab(
        title: String,
        icon: String,
        selected: Bool
    ) -> UIView {

        let container = UIView()

        let iconView = UIImageView(
            image: UIImage(
                systemName: icon,
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 21,
                    weight: .regular
                )
            )
        )

        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.tintColor = selected ? pink : .label
        iconView.contentMode = .scaleAspectFit

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = title

        label.font = .systemFont(
            ofSize: 10,
            weight: selected ? .semibold : .regular
        )

        label.textColor = selected ? pink : .label
        label.textAlignment = .center

        container.addSubview(iconView)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(
                equalTo: container.topAnchor,
                constant: 5
            ),

            iconView.centerXAnchor.constraint(
                equalTo: container.centerXAnchor
            ),

            iconView.widthAnchor.constraint(equalToConstant: 26),
            iconView.heightAnchor.constraint(equalToConstant: 26),

            label.topAnchor.constraint(
                equalTo: iconView.bottomAnchor,
                constant: 2
            ),

            label.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),

            label.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            )
        ])

        return container
    }
}


// MARK: - COMPACT POST

private final class CompactWishlistPostView: UIView {

    private let pink: UIColor

    private let avatar = UIImageView()
    private let usernameLabel = UILabel()
    private let dateLabel = UILabel()
    private let menuButton = UIButton(type: .system)

    private let imageContainer = UIView()
    private let itemImage = UIImageView()

    private let itemNameLabel = UILabel()
    private let priceLabel = UILabel()

    private let tagStack = UIStackView()

    private let captionLabel = UILabel()

    private let purchaseButton = UIButton(type: .system)

    private let socialStack = UIStackView()

    init(
        username: String,
        date: String,
        itemName: String,
        price: String,
        tags: [String],
        caption: String,
        imageSymbol: String,
        likes: String,
        comments: String,
        pink: UIColor
    ) {

        self.pink = pink

        super.init(frame: .zero)

        usernameLabel.text = username
        dateLabel.text = date

        itemNameLabel.text = itemName
        priceLabel.text = price

        captionLabel.text = caption

        itemImage.image = UIImage(
            systemName: imageSymbol
        )

        setupView()
        setupHeader()
        setupImage()
        setupItemInfo()
        setupTags(tags)
        setupPurchase()
        setupSocials(
            likes: likes,
            comments: comments
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: VIEW

    private func setupView() {

        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .systemBackground

        layer.cornerRadius = 18
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray5.cgColor

        clipsToBounds = true

        heightAnchor.constraint(
            equalToConstant: 300
        ).isActive = true
    }

    // MARK: HEADER

    private func setupHeader() {

        avatar.translatesAutoresizingMaskIntoConstraints = false

        avatar.image = UIImage(
            systemName: "person.crop.circle.fill"
        )

        avatar.tintColor = .systemBlue
        avatar.contentMode = .scaleAspectFit

        addSubview(avatar)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        usernameLabel.font = .systemFont(
            ofSize: 15,
            weight: .bold
        )

        addSubview(usernameLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .secondaryLabel

        addSubview(dateLabel)

        menuButton.translatesAutoresizingMaskIntoConstraints = false

        menuButton.setImage(
            UIImage(
                systemName: "ellipsis",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 16,
                    weight: .bold
                )
            ),
            for: .normal
        )

        menuButton.tintColor = .label

        addSubview(menuButton)

        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 14
            ),

            avatar.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 11
            ),

            avatar.widthAnchor.constraint(equalToConstant: 34),
            avatar.heightAnchor.constraint(equalToConstant: 34),

            usernameLabel.leadingAnchor.constraint(
                equalTo: avatar.trailingAnchor,
                constant: 8
            ),

            usernameLabel.centerYAnchor.constraint(
                equalTo: avatar.centerYAnchor
            ),

            dateLabel.leadingAnchor.constraint(
                equalTo: usernameLabel.trailingAnchor,
                constant: 7
            ),

            dateLabel.centerYAnchor.constraint(
                equalTo: usernameLabel.centerYAnchor
            ),

            menuButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -13
            ),

            menuButton.centerYAnchor.constraint(
                equalTo: avatar.centerYAnchor
            ),

            menuButton.widthAnchor.constraint(equalToConstant: 32),
            menuButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    // MARK: IMAGE

    private func setupImage() {

        imageContainer.translatesAutoresizingMaskIntoConstraints = false

        imageContainer.backgroundColor = UIColor(
            red: 0.95,
            green: 0.95,
            blue: 0.95,
            alpha: 1
        )

        imageContainer.layer.cornerRadius = 12
        imageContainer.clipsToBounds = true

        addSubview(imageContainer)

        NSLayoutConstraint.activate([
            imageContainer.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 14
            ),

            imageContainer.topAnchor.constraint(
                equalTo: avatar.bottomAnchor,
                constant: 10
            ),

            imageContainer.widthAnchor.constraint(
                equalToConstant: 135
            ),

            imageContainer.heightAnchor.constraint(
                equalToConstant: 170
            )
        ])

        itemImage.translatesAutoresizingMaskIntoConstraints = false

        itemImage.contentMode = .scaleAspectFit
        itemImage.tintColor = .label

        imageContainer.addSubview(itemImage)

        NSLayoutConstraint.activate([
            itemImage.leadingAnchor.constraint(
                equalTo: imageContainer.leadingAnchor,
                constant: 14
            ),

            itemImage.trailingAnchor.constraint(
                equalTo: imageContainer.trailingAnchor,
                constant: -14
            ),

            itemImage.topAnchor.constraint(
                equalTo: imageContainer.topAnchor,
                constant: 14
            ),

            itemImage.bottomAnchor.constraint(
                equalTo: imageContainer.bottomAnchor,
                constant: -14
            )
        ])
    }

    // MARK: ITEM INFO

    private func setupItemInfo() {

        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false

        itemNameLabel.font = .systemFont(
            ofSize: 17,
            weight: .bold
        )

        itemNameLabel.numberOfLines = 2

        addSubview(itemNameLabel)

        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.font = .systemFont(
            ofSize: 16,
            weight: .semibold
        )

        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            itemNameLabel.leadingAnchor.constraint(
                equalTo: imageContainer.trailingAnchor,
                constant: 14
            ),

            itemNameLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),

            itemNameLabel.topAnchor.constraint(
                equalTo: imageContainer.topAnchor,
                constant: 2
            ),

            priceLabel.leadingAnchor.constraint(
                equalTo: itemNameLabel.leadingAnchor
            ),

            priceLabel.trailingAnchor.constraint(
                equalTo: itemNameLabel.trailingAnchor
            ),

            priceLabel.topAnchor.constraint(
                equalTo: itemNameLabel.bottomAnchor,
                constant: 3
            )
        ])
    }

    // MARK: TAGS

    private func setupTags(_ tags: [String]) {

        tagStack.translatesAutoresizingMaskIntoConstraints = false

        tagStack.axis = .horizontal
        tagStack.spacing = 5
        tagStack.alignment = .leading

        addSubview(tagStack)

        for (index, title) in tags.enumerated() {

            let label = PaddingLabel()

            label.text = title
            label.font = .systemFont(ofSize: 10)

            if index == 0 {

                label.textColor = .systemGreen
                label.backgroundColor =
                    UIColor.systemGreen.withAlphaComponent(0.10)

                label.layer.borderColor =
                    UIColor.systemGreen.cgColor

                label.layer.borderWidth = 1

            } else {

                label.textColor = .secondaryLabel
                label.backgroundColor = UIColor.systemGray6
            }

            label.layer.cornerRadius = 9
            label.clipsToBounds = true

            tagStack.addArrangedSubview(label)
        }

        NSLayoutConstraint.activate([
            tagStack.leadingAnchor.constraint(
                equalTo: itemNameLabel.leadingAnchor
            ),

            tagStack.topAnchor.constraint(
                equalTo: priceLabel.bottomAnchor,
                constant: 8
            ),

            tagStack.heightAnchor.constraint(
                equalToConstant: 22
            )
        ])

        // Caption

        captionLabel.translatesAutoresizingMaskIntoConstraints = false

        captionLabel.font = .systemFont(ofSize: 13)
        captionLabel.textColor = .label
        captionLabel.numberOfLines = 3

        addSubview(captionLabel)

        NSLayoutConstraint.activate([
            captionLabel.leadingAnchor.constraint(
                equalTo: itemNameLabel.leadingAnchor
            ),

            captionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),

            captionLabel.topAnchor.constraint(
                equalTo: tagStack.bottomAnchor,
                constant: 8
            )
        ])
    }

    // MARK: PURCHASE

    private func setupPurchase() {

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false

        var configuration =
            UIButton.Configuration.filled()

        configuration.title = "Purchase"

        configuration.image = UIImage(
            systemName: "cart"
        )

        configuration.imagePadding = 7

        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = pink

        configuration.cornerStyle = .medium

        configuration.contentInsets =
            NSDirectionalEdgeInsets(
                top: 8,
                leading: 12,
                bottom: 8,
                trailing: 12
            )

        purchaseButton.configuration = configuration

        addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            purchaseButton.leadingAnchor.constraint(
                equalTo: itemNameLabel.leadingAnchor
            ),

            purchaseButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -14
            ),

            purchaseButton.topAnchor.constraint(
                greaterThanOrEqualTo: captionLabel.bottomAnchor,
                constant: 8
            ),

            purchaseButton.bottomAnchor.constraint(
                equalTo: imageContainer.bottomAnchor,
                constant: -2
            ),

            purchaseButton.heightAnchor.constraint(
                equalToConstant: 39
            )
        ])
    }

    // MARK: SOCIALS

    private func setupSocials(
        likes: String,
        comments: String
    ) {

        socialStack.translatesAutoresizingMaskIntoConstraints = false

        socialStack.axis = .horizontal
        socialStack.spacing = 17
        socialStack.alignment = .center

        addSubview(socialStack)

        let like = makeSocial(
            icon: "heart.fill",
            count: likes,
            color: pink
        )

        let comment = makeSocial(
            icon: "bubble.left",
            count: comments,
            color: .label
        )

        let bookmark = makeSocial(
            icon: "bookmark",
            count: nil,
            color: .label
        )

        socialStack.addArrangedSubview(like)
        socialStack.addArrangedSubview(comment)
        socialStack.addArrangedSubview(bookmark)

        NSLayoutConstraint.activate([
            socialStack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),

            socialStack.topAnchor.constraint(
                equalTo: imageContainer.bottomAnchor,
                constant: 10
            ),

            socialStack.heightAnchor.constraint(
                equalToConstant: 27
            )
        ])
    }

    private func makeSocial(
        icon: String,
        count: String?,
        color: UIColor
    ) -> UIView {

        let container = UIView()

        let image = UIImageView(
            image: UIImage(
                systemName: icon,
                withConfiguration:
                    UIImage.SymbolConfiguration(
                        pointSize: 17,
                        weight: .regular
                    )
            )
        )

        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = color
        image.contentMode = .scaleAspectFit

        container.addSubview(image)

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),

            image.centerYAnchor.constraint(
                equalTo: container.centerYAnchor
            ),

            image.widthAnchor.constraint(equalToConstant: 21),
            image.heightAnchor.constraint(equalToConstant: 21)
        ])

        if let count {

            let label = UILabel()

            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = count
            label.font = .systemFont(ofSize: 12)

            container.addSubview(label)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(
                    equalTo: image.trailingAnchor,
                    constant: 4
                ),

                label.trailingAnchor.constraint(
                    equalTo: container.trailingAnchor
                ),

                label.centerYAnchor.constraint(
                    equalTo: image.centerYAnchor
                )
            ])

        } else {

            image.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ).isActive = true
        }

        return container
    }
}


// MARK: - PADDING LABEL

private final class PaddingLabel: UILabel {

    var padding = UIEdgeInsets(
        top: 3,
        left: 7,
        bottom: 3,
        right: 7
    )

    override func drawText(in rect: CGRect) {

        super.drawText(
            in: rect.inset(by: padding)
        )
    }

    override var intrinsicContentSize: CGSize {

        let size = super.intrinsicContentSize

        return CGSize(
            width:
                size.width +
                padding.left +
                padding.right,

            height:
                size.height +
                padding.top +
                padding.bottom
        )
    }
}

/*
//PRE LOAD Background place holders
class ViewController: UIViewController {

    private let skeletonBar = UIView()
    private let contentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground

        setupSkeleton()
        setupContentLabel()
        startLoadingDemo()
    }

    private func setupSkeleton() {
        styleSkeletonBar(skeletonBar, width: 120, height: 14)
        skeletonBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skeletonBar)

        NSLayoutConstraint.activate([
            skeletonBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skeletonBar.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupContentLabel() {
        contentLabel.text = "davidvasquez"
        contentLabel.font = Fonts.userName
        contentLabel.textColor = Colors.primaryText
        contentLabel.textAlignment = .center
        contentLabel.alpha = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func styleSkeletonBar(_ bar: UIView, width: CGFloat, height: CGFloat) {
        bar.backgroundColor = UIColor(hex: "#E5E5E5")
        bar.layer.cornerRadius = height / 2
        bar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bar.widthAnchor.constraint(equalToConstant: width),
            bar.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    private func startLoadingDemo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else { return }

            UIView.animate(withDuration: 0.25) {
                self.skeletonBar.alpha = 0
                self.contentLabel.alpha = 1
            } completion: { _ in
                self.skeletonBar.isHidden = true
            }
        }
    }
}

//WISHLIST: Two
 
  import UIKit

  final class ViewController: UIViewController {

      // MARK: - UI COMPONENTS

      private let scrollView = UIScrollView()
      private let contentView = UIView()

      private let navigationView = UIView()
      private let backButton = UIButton(type: .system)
      private let navigationTitle = UILabel()
      private let addItemButton = UIButton(type: .system)

      private let listInfoView = UIView()
      private let listImageView = UIImageView()
      private let listNameLabel = UILabel()
      private let listDescriptionLabel = UILabel()
      private let listStatsLabel = UILabel()
      private let listMenuButton = UIButton(type: .system)

      private let postsStackView = UIStackView()

      private let bottomNavigation = UIView()

      // MARK: - MANAGE VIEWS

      override func viewDidLoad() {
          super.viewDidLoad()

          view.backgroundColor = UIColor.systemGray6

          setupNavigation()
          setupScrollView()
          setupListInfo()
          setupPosts()
          setupBottomNavigation()
      }

      // MARK: - LAYOUT

      private func setupNavigation() {

          navigationView.translatesAutoresizingMaskIntoConstraints = false
          navigationView.backgroundColor = .systemBackground

          view.addSubview(navigationView)

          NSLayoutConstraint.activate([
              navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
              navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              navigationView.heightAnchor.constraint(equalToConstant: 72)
          ])

          backButton.translatesAutoresizingMaskIntoConstraints = false

          backButton.setImage(
              UIImage(
                  systemName: "chevron.left",
                  withConfiguration: UIImage.SymbolConfiguration(
                      pointSize: 23,
                      weight: .medium
                  )
              ),
              for: .normal
          )

          backButton.tintColor = .label
          backButton.backgroundColor = UIColor.systemGray6
          backButton.layer.cornerRadius = 25

          navigationView.addSubview(backButton)

          NSLayoutConstraint.activate([
              backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 20),
              backButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
              backButton.widthAnchor.constraint(equalToConstant: 50),
              backButton.heightAnchor.constraint(equalToConstant: 50)
          ])

          navigationTitle.translatesAutoresizingMaskIntoConstraints = false
          navigationTitle.text = "Cool Stuff"
          navigationTitle.font = .systemFont(ofSize: 25, weight: .bold)
          navigationTitle.textAlignment = .center

          navigationView.addSubview(navigationTitle)

          NSLayoutConstraint.activate([
              navigationTitle.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
              navigationTitle.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor)
          ])

          addItemButton.translatesAutoresizingMaskIntoConstraints = false

          var configuration = UIButton.Configuration.filled()

          configuration.title = "Add Item"
          configuration.image = UIImage(systemName: "plus")
          configuration.imagePadding = 8
          configuration.baseBackgroundColor = wishlistPink
          configuration.baseForegroundColor = .white
          configuration.cornerStyle = .medium

          addItemButton.configuration = configuration

          navigationView.addSubview(addItemButton)

          NSLayoutConstraint.activate([
              addItemButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -18),
              addItemButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
              addItemButton.heightAnchor.constraint(equalToConstant: 46)
          ])
      }

      private func setupScrollView() {

          scrollView.translatesAutoresizingMaskIntoConstraints = false
          contentView.translatesAutoresizingMaskIntoConstraints = false

          view.addSubview(scrollView)
          scrollView.addSubview(contentView)

          NSLayoutConstraint.activate([
              scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
              scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -84),

              contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
              contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
              contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
              contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

              contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
          ])
      }

      private func setupListInfo() {

          listInfoView.translatesAutoresizingMaskIntoConstraints = false
          listInfoView.backgroundColor = .systemBackground

          contentView.addSubview(listInfoView)

          NSLayoutConstraint.activate([
              listInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
              listInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              listInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              listInfoView.heightAnchor.constraint(equalToConstant: 176)
          ])

          listImageView.translatesAutoresizingMaskIntoConstraints = false
          listImageView.backgroundColor = UIColor(
              red: 0.94,
              green: 0.08,
              blue: 0.08,
              alpha: 1
          )

          listImageView.image = UIImage(systemName: "gift.fill")
          listImageView.tintColor = .white
          listImageView.contentMode = .scaleAspectFit
          listImageView.layer.cornerRadius = 55
          listImageView.clipsToBounds = true

          listInfoView.addSubview(listImageView)

          NSLayoutConstraint.activate([
              listImageView.leadingAnchor.constraint(equalTo: listInfoView.leadingAnchor, constant: 28),
              listImageView.centerYAnchor.constraint(equalTo: listInfoView.centerYAnchor),
              listImageView.widthAnchor.constraint(equalToConstant: 110),
              listImageView.heightAnchor.constraint(equalToConstant: 110)
          ])

          listNameLabel.translatesAutoresizingMaskIntoConstraints = false
          listNameLabel.text = "Cool Stuff"
          listNameLabel.font = .systemFont(ofSize: 28, weight: .bold)

          listInfoView.addSubview(listNameLabel)

          NSLayoutConstraint.activate([
              listNameLabel.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: 22),
              listNameLabel.topAnchor.constraint(equalTo: listImageView.topAnchor, constant: 10)
          ])

          listDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
          listDescriptionLabel.text = "Items I’m loving and want!"
          listDescriptionLabel.font = .systemFont(ofSize: 17)
          listDescriptionLabel.textColor = .secondaryLabel

          listInfoView.addSubview(listDescriptionLabel)

          NSLayoutConstraint.activate([
              listDescriptionLabel.leadingAnchor.constraint(equalTo: listNameLabel.leadingAnchor),
              listDescriptionLabel.topAnchor.constraint(equalTo: listNameLabel.bottomAnchor, constant: 5),
              listDescriptionLabel.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor, constant: -20)
          ])

          listStatsLabel.translatesAutoresizingMaskIntoConstraints = false
          listStatsLabel.text = "12 items  •  3 friends"
          listStatsLabel.font = .systemFont(ofSize: 16)
          listStatsLabel.textColor = .secondaryLabel

          listInfoView.addSubview(listStatsLabel)

          NSLayoutConstraint.activate([
              listStatsLabel.leadingAnchor.constraint(equalTo: listNameLabel.leadingAnchor),
              listStatsLabel.topAnchor.constraint(equalTo: listDescriptionLabel.bottomAnchor, constant: 7)
          ])

          listMenuButton.translatesAutoresizingMaskIntoConstraints = false
          listMenuButton.setImage(
              UIImage(
                  systemName: "ellipsis",
                  withConfiguration: UIImage.SymbolConfiguration(
                      pointSize: 23,
                      weight: .bold
                  )
              ),
              for: .normal
          )

          listMenuButton.tintColor = .label

          listInfoView.addSubview(listMenuButton)

          NSLayoutConstraint.activate([
              listMenuButton.trailingAnchor.constraint(equalTo: listInfoView.trailingAnchor, constant: -20),
              listMenuButton.topAnchor.constraint(equalTo: listInfoView.topAnchor, constant: 28),
              listMenuButton.widthAnchor.constraint(equalToConstant: 40),
              listMenuButton.heightAnchor.constraint(equalToConstant: 40)
          ])
      }

      private func setupPosts() {

          postsStackView.translatesAutoresizingMaskIntoConstraints = false
          postsStackView.axis = .vertical
          postsStackView.spacing = 14

          contentView.addSubview(postsStackView)

          NSLayoutConstraint.activate([
              postsStackView.topAnchor.constraint(equalTo: listInfoView.bottomAnchor, constant: 12),
              postsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
              postsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
              postsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
          ])

          let firstPost = SimpleWishlistPostView(
              username: "davey",
              date: "10 months ago",
              itemName: "Live A Live – Nintendo Switch",
              price: "$49.99",
              caption: "Unique RPG with multiple story paths and a great retro feel.",
              image: "gamecontroller.fill",
              likes: "1",
              comments: "2"
          )

          let secondPost = SimpleWishlistPostView(
              username: "alex",
              date: "1 year ago",
              itemName: "Sony WH-1000XM5",
              price: "$399.00",
              caption: "Best noise canceling headphones. Perfect for travel and work.",
              image: "headphones",
              likes: "3",
              comments: "1"
          )

          postsStackView.addArrangedSubview(firstPost)
          postsStackView.addArrangedSubview(secondPost)
      }

      private func setupBottomNavigation() {

          bottomNavigation.translatesAutoresizingMaskIntoConstraints = false
          bottomNavigation.backgroundColor = .systemBackground
          bottomNavigation.layer.cornerRadius = 34

          bottomNavigation.layer.shadowColor = UIColor.black.cgColor
          bottomNavigation.layer.shadowOpacity = 0.08
          bottomNavigation.layer.shadowRadius = 12
          bottomNavigation.layer.shadowOffset = CGSize(width: 0, height: -2)

          view.addSubview(bottomNavigation)

          NSLayoutConstraint.activate([
              bottomNavigation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
              bottomNavigation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
              bottomNavigation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
              bottomNavigation.heightAnchor.constraint(equalToConstant: 76)
          ])

          let home = createNavigationItem(
              title: "Home",
              icon: "house",
              selected: false
          )

          let lists = createNavigationItem(
              title: "Lists",
              icon: "list.bullet",
              selected: true
          )

          let discover = createNavigationItem(
              title: "Discover",
              icon: "magnifyingglass",
              selected: false
          )

          let profile = createNavigationItem(
              title: "Profile",
              icon: "person",
              selected: false
          )

          let stack = UIStackView(arrangedSubviews: [
              home,
              lists,
              discover,
              profile
          ])

          stack.translatesAutoresizingMaskIntoConstraints = false
          stack.axis = .horizontal
          stack.distribution = .fillEqually

          bottomNavigation.addSubview(stack)

          NSLayoutConstraint.activate([
              stack.leadingAnchor.constraint(equalTo: bottomNavigation.leadingAnchor),
              stack.trailingAnchor.constraint(equalTo: bottomNavigation.trailingAnchor),
              stack.topAnchor.constraint(equalTo: bottomNavigation.topAnchor),
              stack.bottomAnchor.constraint(equalTo: bottomNavigation.bottomAnchor)
          ])
      }

      // MARK: - FUNCTIONS

      private var wishlistPink: UIColor {
          UIColor(
              red: 1.0,
              green: 0.16,
              blue: 0.34,
              alpha: 1
          )
      }

      private func createNavigationItem(
          title: String,
          icon: String,
          selected: Bool
      ) -> UIView {

          let container = UIView()

          if selected {
              container.backgroundColor = wishlistPink.withAlphaComponent(0.12)
              container.layer.cornerRadius = 28
          }

          let imageView = UIImageView(
              image: UIImage(systemName: icon)
          )

          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.contentMode = .scaleAspectFit
          imageView.tintColor = selected ? wishlistPink : .label

          container.addSubview(imageView)

          let label = UILabel()

          label.translatesAutoresizingMaskIntoConstraints = false
          label.text = title
          label.textAlignment = .center
          label.font = .systemFont(
              ofSize: 12,
              weight: selected ? .semibold : .regular
          )

          label.textColor = selected ? wishlistPink : .label

          container.addSubview(label)

          NSLayoutConstraint.activate([
              imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
              imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
              imageView.widthAnchor.constraint(equalToConstant: 28),
              imageView.heightAnchor.constraint(equalToConstant: 28),

              label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
              label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
              label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
          ])

          return container
      }
  }


  // MARK: - SIMPLE POST

  private final class SimpleWishlistPostView: UIView {

      private let avatarImageView = UIImageView()

      private let usernameLabel = UILabel()
      private let dateLabel = UILabel()

      private let menuButton = UIButton(type: .system)

      private let itemImageContainer = UIView()
      private let itemImageView = UIImageView()

      private let itemNameLabel = UILabel()
      private let priceLabel = UILabel()
      private let captionLabel = UILabel()

      private let purchaseButton = UIButton(type: .system)

      private let socialStack = UIStackView()

      private let pink = UIColor(
          red: 1,
          green: 0.16,
          blue: 0.34,
          alpha: 1
      )

      init(
          username: String,
          date: String,
          itemName: String,
          price: String,
          caption: String,
          image: String,
          likes: String,
          comments: String
      ) {

          super.init(frame: .zero)

          usernameLabel.text = username
          dateLabel.text = date
          itemNameLabel.text = itemName
          priceLabel.text = price
          captionLabel.text = caption

          itemImageView.image = UIImage(systemName: image)

          setupLayout()

          setupSocials(
              likes: likes,
              comments: comments
          )
      }

      required init?(coder: NSCoder) {
          fatalError()
      }

      private func setupLayout() {

          translatesAutoresizingMaskIntoConstraints = false

          backgroundColor = .systemBackground

          layer.cornerRadius = 24
          clipsToBounds = true

          heightAnchor.constraint(
              equalToConstant: 455
          ).isActive = true

          setupPostHeader()
          setupItemImage()
          setupItemContent()
          setupPurchaseButton()
          setupSocialStack()
      }

      private func setupPostHeader() {

          avatarImageView.translatesAutoresizingMaskIntoConstraints = false
          avatarImageView.image = UIImage(
              systemName: "person.crop.circle.fill"
          )

          avatarImageView.tintColor = .systemBlue
          avatarImageView.contentMode = .scaleAspectFill
          avatarImageView.clipsToBounds = true
          avatarImageView.layer.cornerRadius = 22

          addSubview(avatarImageView)

          usernameLabel.translatesAutoresizingMaskIntoConstraints = false
          usernameLabel.font = .systemFont(
              ofSize: 18,
              weight: .bold
          )

          addSubview(usernameLabel)

          dateLabel.translatesAutoresizingMaskIntoConstraints = false
          dateLabel.font = .systemFont(ofSize: 15)
          dateLabel.textColor = .secondaryLabel

          addSubview(dateLabel)

          menuButton.translatesAutoresizingMaskIntoConstraints = false

          menuButton.setImage(
              UIImage(
                  systemName: "ellipsis",
                  withConfiguration: UIImage.SymbolConfiguration(
                      pointSize: 21,
                      weight: .bold
                  )
              ),
              for: .normal
          )

          menuButton.tintColor = .label

          addSubview(menuButton)

          NSLayoutConstraint.activate([
              avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
              avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
              avatarImageView.widthAnchor.constraint(equalToConstant: 44),
              avatarImageView.heightAnchor.constraint(equalToConstant: 44),

              usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
              usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),

              dateLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 9),
              dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),

              menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
              menuButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
              menuButton.widthAnchor.constraint(equalToConstant: 40),
              menuButton.heightAnchor.constraint(equalToConstant: 40)
          ])
      }

      private func setupItemImage() {

          itemImageContainer.translatesAutoresizingMaskIntoConstraints = false
          itemImageContainer.backgroundColor = UIColor.systemGray6
          itemImageContainer.layer.cornerRadius = 16
          itemImageContainer.clipsToBounds = true

          addSubview(itemImageContainer)

          NSLayoutConstraint.activate([
              itemImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
              itemImageContainer.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
              itemImageContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.38),
              itemImageContainer.heightAnchor.constraint(equalToConstant: 260)
          ])

          itemImageView.translatesAutoresizingMaskIntoConstraints = false
          itemImageView.tintColor = .label
          itemImageView.contentMode = .scaleAspectFit

          itemImageContainer.addSubview(itemImageView)

          NSLayoutConstraint.activate([
              itemImageView.leadingAnchor.constraint(equalTo: itemImageContainer.leadingAnchor, constant: 20),
              itemImageView.trailingAnchor.constraint(equalTo: itemImageContainer.trailingAnchor, constant: -20),
              itemImageView.topAnchor.constraint(equalTo: itemImageContainer.topAnchor, constant: 20),
              itemImageView.bottomAnchor.constraint(equalTo: itemImageContainer.bottomAnchor, constant: -20)
          ])
      }

      private func setupItemContent() {

          itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
          itemNameLabel.font = .systemFont(
              ofSize: 21,
              weight: .bold
          )

          itemNameLabel.numberOfLines = 2

          addSubview(itemNameLabel)

          priceLabel.translatesAutoresizingMaskIntoConstraints = false
          priceLabel.font = .systemFont(
              ofSize: 20,
              weight: .semibold
          )

          addSubview(priceLabel)

          captionLabel.translatesAutoresizingMaskIntoConstraints = false
          captionLabel.font = .systemFont(ofSize: 16)
          captionLabel.textColor = .secondaryLabel
          captionLabel.numberOfLines = 4

          addSubview(captionLabel)

          NSLayoutConstraint.activate([
              itemNameLabel.leadingAnchor.constraint(equalTo: itemImageContainer.trailingAnchor, constant: 20),
              itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
              itemNameLabel.topAnchor.constraint(equalTo: itemImageContainer.topAnchor, constant: 4),

              priceLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
              priceLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
              priceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 7),

              captionLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
              captionLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
              captionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16)
          ])
      }

      private func setupPurchaseButton() {

          purchaseButton.translatesAutoresizingMaskIntoConstraints = false

          var configuration = UIButton.Configuration.filled()

          configuration.title = "Purchase"

          configuration.image = UIImage(
              systemName: "cart"
          )

          configuration.imagePadding = 9

          configuration.baseForegroundColor = .white
          configuration.baseBackgroundColor = pink
          configuration.cornerStyle = .medium

          purchaseButton.configuration = configuration

          addSubview(purchaseButton)

          NSLayoutConstraint.activate([
              purchaseButton.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
              purchaseButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
              purchaseButton.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 20),
              purchaseButton.heightAnchor.constraint(equalToConstant: 48),
              purchaseButton.widthAnchor.constraint(equalToConstant: 170)
          ])
      }

      private func setupSocialStack() {

          socialStack.translatesAutoresizingMaskIntoConstraints = false
          socialStack.axis = .horizontal
          socialStack.spacing = 22
          socialStack.alignment = .center

          addSubview(socialStack)

          NSLayoutConstraint.activate([
              socialStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
              socialStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
              socialStack.heightAnchor.constraint(equalToConstant: 32)
          ])
      }

      private func setupSocials(
          likes: String,
          comments: String
      ) {

          socialStack.addArrangedSubview(
              createSocialItem(
                  icon: "heart",
                  count: likes,
                  tint: pink
              )
          )

          socialStack.addArrangedSubview(
              createSocialItem(
                  icon: "bubble.left",
                  count: comments,
                  tint: .label
              )
          )

          socialStack.addArrangedSubview(
              createSocialItem(
                  icon: "bookmark",
                  count: nil,
                  tint: .label
              )
          )
      }

      private func createSocialItem(
          icon: String,
          count: String?,
          tint: UIColor
      ) -> UIView {

          let container = UIView()

          let iconView = UIImageView(
              image: UIImage(
                  systemName: icon,
                  withConfiguration: UIImage.SymbolConfiguration(
                      pointSize: 22,
                      weight: .regular
                  )
              )
          )

          iconView.translatesAutoresizingMaskIntoConstraints = false
          iconView.tintColor = tint
          iconView.contentMode = .scaleAspectFit

          container.addSubview(iconView)

          NSLayoutConstraint.activate([
              iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
              iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
              iconView.widthAnchor.constraint(equalToConstant: 28),
              iconView.heightAnchor.constraint(equalToConstant: 28)
          ])

          if let count {

              let countLabel = UILabel()

              countLabel.translatesAutoresizingMaskIntoConstraints = false
              countLabel.text = count
              countLabel.font = .systemFont(ofSize: 16)

              container.addSubview(countLabel)

              NSLayoutConstraint.activate([
                  countLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
                  countLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                  countLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
              ])

          } else {

              iconView.trailingAnchor.constraint(
                  equalTo: container.trailingAnchor
              ).isActive = true
          }

          return container
      }
  }
  */


//STYLE
/*
class ViewController: UIViewController {

    let titleLabel = UILabel()
    let profileContainerView = UIView()
    let dividerView = UIView()
    let actionButton = UIButton(type: .system)
    let usernameTextField = UITextField()
    let colorView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("HelloStyleWorldViewController")

        setupViews()
        setupConstraints()
    }

    func setupViews() {

        view.backgroundColor = .white

        //Text
        titleLabel.text = "Hello Style World"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        //Using Style
        Text.postBodyText(label: titleLabel)
        view.addSubview(titleLabel)

        //Element
        profileContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileContainerView)

        //Divider
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        Elements.postDivider(view: dividerView)
        view.addSubview(dividerView)

        //Button
        actionButton.setTitle("Accept", for: .normal)

        //style
        Buttons.acceptFriendButton(button: actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)

        //Input Field
        usernameTextField.placeholder = "Username"
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)

        //Color View
        colorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            //Text
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //Element
            profileContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileContainerView.widthAnchor.constraint(equalToConstant: 140),
            profileContainerView.heightAnchor.constraint(equalToConstant: 200),

            //Divider
            dividerView.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: 30),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            //Button
            actionButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 220),
            actionButton.heightAnchor.constraint(equalToConstant: 44),

            //Input Field
            usernameTextField.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 30),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 260),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),

            //Color View
            colorView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40)

        ])
    }

}
*/







/*
final class ViewController: UIViewController {

    // MARK: - UI COMPONENTS

    private let containerView = UIView()

    private let imageView = UIImageView()
    private let holderView = UIView()

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        showHolder()

        simulateLoading()
    }

    // MARK: - SETUP

    private func setupViews() {
        view.backgroundColor = .systemBackground

        containerView.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12

        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.backgroundColor = UIColor(
            red: 0.92,   // Instagram-like gray
            green: 0.92,
            blue: 0.92,
            alpha: 1.0
        )
        holderView.layer.cornerRadius = 12
        holderView.clipsToBounds = true

        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(holderView)
    }

    // MARK: - LAYOUT

    private func layoutViews() {
        NSLayoutConstraint.activate([
            // 20pt margins
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            // Fill container
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            // Gray overlay
            holderView.topAnchor.constraint(equalTo: containerView.topAnchor),
            holderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            holderView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }

    // MARK: - STATE

    private func showHolder() {
        holderView.isHidden = false
        imageView.isHidden = true
    }

    private func showImage() {
        holderView.isHidden = true
        imageView.isHidden = false
    }

    // MARK: - SIMULATION (3 second delay)

    private func simulateLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadImage()
        }
    }

    private func loadImage() {
        imageView.image = UIImage(named: "background_1")
        showImage()
    }
}
*/

/*
import UIKit
import ObjectiveC


private var placeholderKey: UInt8 = 0

// MARK: - ViewController (Storyboard)

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        // Show skeleton immediately
        view.showLoadingPlaceholder()

        // Simulate loading (3 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.view.hideLoadingPlaceholder()
        }
    }
}

// MARK: - Loading Placeholder View (Shimmer)

final class LoadingPlaceholderView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = false

        // Instagram-style gray
        backgroundColor = UIColor(
            red: 0.92,
            green: 0.92,
            blue: 0.92,
            alpha: 1.0
        )

        gradientLayer.colors = [
            UIColor(white: 0.85, alpha: 1.0).cgColor,
            UIColor(white: 0.95, alpha: 1.0).cgColor,
            UIColor(white: 0.85, alpha: 1.0).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]

        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    func startShimmer() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.2
        animation.repeatCount = .infinity

        gradientLayer.add(animation, forKey: "shimmer")
    }

    func stopShimmer() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}

// MARK: - UIView Extension

extension UIView {

    private var loadingPlaceholder: LoadingPlaceholderView? {
        get {
            return objc_getAssociatedObject(self, &placeholderKey) as? LoadingPlaceholderView
        }
        set {
            objc_setAssociatedObject(self, &placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showLoadingPlaceholder(cornerRadius: CGFloat = 12) {
        if loadingPlaceholder != nil { return }

        let placeholder = LoadingPlaceholderView()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.layer.cornerRadius = cornerRadius
        placeholder.clipsToBounds = true

        addSubview(placeholder)

        NSLayoutConstraint.activate([
            placeholder.topAnchor.constraint(equalTo: topAnchor),
            placeholder.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholder.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholder.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        bringSubviewToFront(placeholder)

        placeholder.startShimmer()

        loadingPlaceholder = placeholder
    }

    func hideLoadingPlaceholder() {
        loadingPlaceholder?.stopShimmer()
        loadingPlaceholder?.removeFromSuperview()
        loadingPlaceholder = nil
    }
}

*/

/*


*/
/*
struct StoreItem {
    let name: String
    let price: String
}

class ViewController: UIViewController {

    // MARK: - Data
    private var stores: [StoreItem] = [
        StoreItem(name: "Amazon", price: "$20"),
        StoreItem(name: "Target", price: "$18")
    ]

    // MARK: - UI
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)

    private let addContainerView = UIView()
    private let storeTextField = UITextField()
    private let priceTextField = UITextField()
    private let submitButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    private var addContainerHeightConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTableView()
        setupAddButton()
        setupAddContainer()
        setupConstraints()
    }

    // MARK: - Setup
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
    }

    private func setupAddButton() {
        addButton.setTitle("+ New Store", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        view.addSubview(addButton)
    }

    private func setupAddContainer() {
        addContainerView.backgroundColor = .secondarySystemBackground
        addContainerView.layer.cornerRadius = 12
        addContainerView.clipsToBounds = true
        view.addSubview(addContainerView)

        storeTextField.placeholder = "Store name"
        storeTextField.borderStyle = .roundedRect

        priceTextField.placeholder = "Price"
        priceTextField.borderStyle = .roundedRect

        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)

        [storeTextField, priceTextField, submitButton, cancelButton].forEach {
            addContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addContainerView.translatesAutoresizingMaskIntoConstraints = false

        addContainerHeightConstraint = addContainerView.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            // Add button
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Table
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addContainerView.topAnchor, constant: -8),

            // Add container
            addContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addContainerHeightConstraint,

            // Store field
            storeTextField.topAnchor.constraint(equalTo: addContainerView.topAnchor, constant: 12),
            storeTextField.leadingAnchor.constraint(equalTo: addContainerView.leadingAnchor, constant: 12),
            storeTextField.trailingAnchor.constraint(equalTo: addContainerView.trailingAnchor, constant: -12),

            // Price field
            priceTextField.topAnchor.constraint(equalTo: storeTextField.bottomAnchor, constant: 8),
            priceTextField.leadingAnchor.constraint(equalTo: storeTextField.leadingAnchor),
            priceTextField.trailingAnchor.constraint(equalTo: storeTextField.trailingAnchor),

            // Buttons
            submitButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 12),
            submitButton.leadingAnchor.constraint(equalTo: addContainerView.leadingAnchor, constant: 12),
            submitButton.bottomAnchor.constraint(equalTo: addContainerView.bottomAnchor, constant: -12),

            cancelButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: addContainerView.trailingAnchor, constant: -12)
        ])
    }

    // MARK: - Actions
    @objc private func didTapAdd() {
        showAddArea(true)
    }

    @objc private func didTapCancel() {
        showAddArea(false)
        clearInputs()
    }

    @objc private func didTapSubmit() {
        guard
            let name = storeTextField.text, !name.isEmpty,
            let price = priceTextField.text, !price.isEmpty
        else { return }

        stores.append(StoreItem(name: name, price: price))
        tableView.reloadData()

        clearInputs()
        showAddArea(false)
    }

    private func showAddArea(_ show: Bool) {
        addContainerHeightConstraint.constant = show ? 160 : 0

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    private func clearInputs() {
        storeTextField.text = nil
        priceTextField.text = nil
    }
}

// MARK: - Table DataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = stores[indexPath.row]
        cell.textLabel?.text = "\(item.name) \(item.price)"
        return cell
    }
}

*/


/*
final class ViewController: UIViewController {

    // MARK: - UI

    private let searchContainer = UIView()
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    private let searchPlaceholderLabel = UILabel()

    private let separator = UIView()

    private let rowButton = UIButton(type: .system) // makes the row tappable

    private let avatarCircle = UIView()
    private let avatarIcon = UIImageView(image: UIImage(systemName: "paperplane.fill")) // stand-in for origami logo

    private let nameLabel = UILabel()
    private let handleLabel = UILabel()
    private let dateLabel = UILabel()

    private let previewLabel = UILabel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        buildSearchBar()
        buildRow()
        layoutUI()
    }

    // MARK: - Build

    private func buildSearchBar() {
        // Container (rounded light gray pill)
        searchContainer.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        searchContainer.layer.cornerRadius = 22
        searchContainer.layer.masksToBounds = true

        // Icon
        searchIcon.tintColor = UIColor(white: 0.55, alpha: 1.0)
        searchIcon.contentMode = .scaleAspectFit

        // Placeholder text
        searchPlaceholderLabel.text = "Search for people and groups"
        searchPlaceholderLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        searchPlaceholderLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)

        view.addSubview(searchContainer)
        searchContainer.addSubview(searchIcon)
        searchContainer.addSubview(searchPlaceholderLabel)
    }

    private func buildRow() {
        // Row button (no blue highlight)
        rowButton.backgroundColor = .clear
        rowButton.tintColor = .clear
        rowButton.showsTouchWhenHighlighted = false
        rowButton.adjustsImageWhenHighlighted = false

        // Optional: subtle highlight on touch (very light)
        rowButton.setBackgroundImage(imageWithColor(UIColor(white: 0.95, alpha: 1.0)), for: .highlighted)

        // Avatar circle
        avatarCircle.backgroundColor = UIColor.systemBlue
        avatarCircle.layer.cornerRadius = 28
        avatarCircle.layer.masksToBounds = true

        avatarIcon.tintColor = .white
        avatarIcon.contentMode = .scaleAspectFit

        // Name, handle, date
        nameLabel.text = "AzizDjan"
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .black

        handleLabel.text = "@A_AzizDjan"
        handleLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        handleLabel.textColor = UIColor(white: 0.55, alpha: 1.0)

        dateLabel.text = "12/2/19"
        dateLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        dateLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        dateLabel.textAlignment = .right

        // Preview line
        previewLabel.text = "You: You’re very welcome AzizDjan!"
        previewLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        previewLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        previewLabel.numberOfLines = 1

        // Separator line
        separator.backgroundColor = UIColor(white: 0.85, alpha: 1.0)

        view.addSubview(rowButton)
        view.addSubview(separator)

        rowButton.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarIcon)

        rowButton.addSubview(nameLabel)
        rowButton.addSubview(handleLabel)
        rowButton.addSubview(dateLabel)
        rowButton.addSubview(previewLabel)

        // Tap action (optional)
        rowButton.addTarget(self, action: #selector(rowTapped), for: .touchUpInside)
    }

    // MARK: - Layout

    private func layoutUI() {
        [searchContainer, searchIcon, searchPlaceholderLabel,
         rowButton, avatarCircle, avatarIcon,
         nameLabel, handleLabel, dateLabel, previewLabel,
         separator].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        // Search pill
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            searchContainer.heightAnchor.constraint(equalToConstant: 52),

            searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 16),
            searchIcon.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),

            searchPlaceholderLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 10),
            searchPlaceholderLabel.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor, constant: 0),
            searchPlaceholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: searchContainer.trailingAnchor, constant: -14)
        ])

        // Row button area
        NSLayoutConstraint.activate([
            rowButton.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 14),
            rowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rowButton.heightAnchor.constraint(equalToConstant: 108)
        ])

        // Separator line (under search area like screenshot)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: rowButton.topAnchor, constant: -8),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])

        // Avatar
        NSLayoutConstraint.activate([
            avatarCircle.leadingAnchor.constraint(equalTo: rowButton.leadingAnchor, constant: 22),
            avatarCircle.centerYAnchor.constraint(equalTo: rowButton.centerYAnchor),
            avatarCircle.widthAnchor.constraint(equalToConstant: 56),
            avatarCircle.heightAnchor.constraint(equalToConstant: 56),

            avatarIcon.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            avatarIcon.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),
            avatarIcon.widthAnchor.constraint(equalToConstant: 28),
            avatarIcon.heightAnchor.constraint(equalToConstant: 28)
        ])

        // Top line: Name + Handle (left), Date (right)
        // We place name and handle on same baseline-ish, like the screenshot.
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarCircle.trailingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: rowButton.topAnchor, constant: 18),

            handleLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            handleLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),

            dateLabel.trailingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: -22),
            dateLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),

            // Make sure text doesn't collide with date
            handleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10)
        ])

        // Preview line
        NSLayoutConstraint.activate([
            previewLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            previewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            previewLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: dateLabel.leadingAnchor,
                constant: -12
            )
        ])

    }

    // MARK: - Actions

    @objc private func rowTapped() {
        print("Row tapped")
    }

    // MARK: - Helpers

    private func imageWithColor(_ color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
*/

/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let commentView = UserCommentTemplate()
        commentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentView)
        
        commentView.configure(
            userName: "Bilbo",
            commentText: "This looks great! Love how reusable this is. This looks great! Love how reusable this is.",
            image: UIImage(named: "background_1")
        )
        
        NSLayoutConstraint.activate([
            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
}*/





//CALENDAR
/*
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    private var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.translatesAutoresizingMaskIntoConstraints = false

        // Basic style
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.weekdayTextColor = .systemBlue

        // Colors
        calendar.appearance.todayColor = .systemRed
        calendar.appearance.selectionColor = .systemBlue
        calendar.appearance.eventDefaultColor = .systemGreen
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleWeekendColor = .systemGray

        view.addSubview(calendar)

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    // Example delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
}
*/



//Basic
/*
class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    private var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Create calendar
        calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.translatesAutoresizingMaskIntoConstraints = false

        // Add to view
        view.addSubview(calendar)

        // Constraints
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    // Example delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
}
*/

/*
//SCROLL VIEW
class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupUsers()
        setupBlueView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // StackView inside ScrollView
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func setupUsers() {
        for i in 1...7 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "background_\(i)")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 50 // Half of 100
            imageView.layer.masksToBounds = true
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            stackView.addArrangedSubview(imageView)
        }
    }
    
    private func setupBlueView() {
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .systemBlue
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
 */




//MENU
/*
class ViewController: UIViewController {
    
    // Menu image (replace with your asset name if you want)
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.3.horizontal") // SF Symbol "hamburger" menu
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true // required for taps
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(menuImageView)
        
        // Center the menu icon
        NSLayoutConstraint.activate([
            menuImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 60),
            menuImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        menuImageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapMenu() {
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Animate "bounce" effect
        UIView.animate(withDuration: 0.15,
                       animations: {
            self.menuImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.menuImageView.transform = .identity
            }
        }
        
        print("Menu tapped!")
    }
}

*/


/*

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let segmentedControl = UISegmentedControl(items: ["Hobbits", "Elves"])

    let hobbitNames = ["Frodo", "Samwise", "Merry", "Pippin"]
    let elvenNames = ["Legolas", "Elrond", "Galadriel", "Thranduil"]

    var currentData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupSegmentedControl()
        setupTableView()

        // Default selection
        segmentedControl.selectedSegmentIndex = 0
        currentData = hobbitNames
    }

    @objc private func segmentChanged() {
        currentData = segmentedControl.selectedSegmentIndex == 0 ? hobbitNames : elvenNames
        tableView.reloadData()
    }

    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemBlue
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Create a wrapper view to size the header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        segmentedControl.frame = CGRect(x: 16, y: 8, width: view.frame.width - 32, height: 34)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentData[indexPath.row]
        return cell
    }
}
*/

//WORKS
/*
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct User {
        let username: String
        let fullName: String
        let imageName: String
        var isFollowing: Bool
    }

    class UserCell: UITableViewCell {
        static let identifier = "UserCell"

        let profileImageView = UIImageView()
        let usernameLabel = UILabel()
        let fullNameLabel = UILabel()
        let followButton = UIButton(type: .system)

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 24
            profileImageView.clipsToBounds = true

            usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false

            fullNameLabel.font = UIFont.systemFont(ofSize: 14)
            fullNameLabel.textColor = .gray
            fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

            followButton.translatesAutoresizingMaskIntoConstraints = false
            followButton.layer.cornerRadius = 6
            followButton.clipsToBounds = true
            followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

            contentView.addSubview(profileImageView)
            contentView.addSubview(usernameLabel)
            contentView.addSubview(fullNameLabel)
            contentView.addSubview(followButton)

            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 48),
                profileImageView.heightAnchor.constraint(equalToConstant: 48),

                usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

                fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
                fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

                followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        func configure(with user: User) {
            profileImageView.image = UIImage(named: user.imageName)
            usernameLabel.text = user.username
            fullNameLabel.text = user.fullName
            let title = user.isFollowing ? "Following" : "Follow"
            followButton.setTitle(title, for: .normal)
            followButton.backgroundColor = user.isFollowing ? .white : UIColor.systemRed
            followButton.setTitleColor(user.isFollowing ? .black : .white, for: .normal)
            followButton.layer.borderWidth = user.isFollowing ? 1 : 0
            followButton.layer.borderColor = user.isFollowing ? UIColor.lightGray.cgColor : nil
        }
    }

    private let tableView = UITableView()
    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Followers"

        setupUsers()
        setupTableView()
    }

    private func setupUsers() {
        let imageNames = ["background_1", "background_2", "background_3"]
        for i in 0..<10 {
            users.append(User(
                username: "user\(i)",
                fullName: "Full Name \(i)",
                imageName: imageNames[i % 3],
                isFollowing: i % 2 == 0
            ))
        }
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(with: user)
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    @objc private func followButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        users[index].isFollowing.toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

 */
/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
 */



/*
class ViewController: UIViewController {
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        //setupConstraints()
        setBackgroundImage()
    }
    
    
    private func setBackgroundImage() {
         let backgroundImage = UIImageView(frame: view.bounds)
         backgroundImage.image = UIImage(named: "background_2")
         backgroundImage.contentMode = .scaleAspectFill
         backgroundImage.clipsToBounds = true
         backgroundImage.translatesAutoresizingMaskIntoConstraints = false

         view.insertSubview(backgroundImage, at: 0) // Places it behind all other views

         NSLayoutConstraint.activate([
             backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
             backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
    
    
    
    
    // MARK: - UI Elements
    // Status Bar Elements
    private let statusBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:41"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signalIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right") // Signal icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wifiIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wifi") // Wi-Fi icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let batteryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "battery.75") // Battery icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Main Content
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Evently"
        label.font = UIFont(name: "Billabong", size: 50) ?? UIFont.systemFont(ofSize: 50) // Approx Instagram font
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder") // Replace with your image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "jacob_w"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0) // Instagram blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let switchAccountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Switch accounts"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(statusBarView)
        statusBarView.addSubview(timeLabel)
        statusBarView.addSubview(signalIcon)
        statusBarView.addSubview(wifiIcon)
        statusBarView.addSubview(batteryIcon)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(loginButton)
        view.addSubview(switchAccountsLabel)
        view.addSubview(signUpLabel)
        
        // Add tap gesture to switch accounts label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchAccountsTapped))
        switchAccountsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        // Status Bar Constraints
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 20), // Status bar height
            
            timeLabel.centerXAnchor.constraint(equalTo: statusBarView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            
            signalIcon.trailingAnchor.constraint(equalTo: wifiIcon.leadingAnchor, constant: -8),
            signalIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            signalIcon.widthAnchor.constraint(equalToConstant: 15),
            signalIcon.heightAnchor.constraint(equalToConstant: 15),
            
            wifiIcon.trailingAnchor.constraint(equalTo: batteryIcon.leadingAnchor, constant: -8),
            wifiIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            wifiIcon.widthAnchor.constraint(equalToConstant: 15),
            wifiIcon.heightAnchor.constraint(equalToConstant: 15),
            
            batteryIcon.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor, constant: -8),
            batteryIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            batteryIcon.widthAnchor.constraint(equalToConstant: 25),
            batteryIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        // Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: statusBarView.bottomAnchor, constant: 100) // Adjusted for image
        ])
        
        // Profile Image Constraints
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Username Label Constraints
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
        ])
        
        // Login Button Constraints
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Switch Accounts Label Constraints
        NSLayoutConstraint.activate([
            switchAccountsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchAccountsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
        
        // Sign Up Label Constraints
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func switchAccountsTapped() {
        print("Switch accounts tapped")
        // Add switch accounts logic here
    }
}
*/
