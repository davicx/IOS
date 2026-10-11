//
//  DesignPostCell.swift
//  Kite
//
//  Instagram-style post layout for design review.
//  All of this layout lives in this file. Styles live in DesignStyleTemp.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class DesignPostCell: UITableViewCell {

    //LOGIC
    struct Preview {
        let id: String
        let username: String
        let audio: String?
        let imageName: String
        let pageCount: Int
        let likeCount: Int
        let caption: String
        let date: Date
    }

    static let previewPosts: [Preview] = [
        Preview(
            id: "design-post-1",
            username: "ghibli.style",
            audio: nil,
            imageName: "background_10",
            pageCount: 4,
            likeCount: 39820,
            caption: "Can you guess this Ghibli movie? 💚\nDouble tap if you find them cute!\nTag someone who needs to see this 👆🏻",
            date: previewDate(year: 2024, month: 11, day: 20)
        ),
        Preview(
            id: "design-post-2",
            username: "ghibli.style",
            audio: "ghibli.style · Original audio",
            imageName: "background_10",
            pageCount: 1,
            likeCount: 1204,
            caption: "Second post, so the white space before the next header is visible.",
            date: previewDate(year: 2024, month: 11, day: 18)
        )
    ]

    private static var expandedPostIDs = Set<String>()
    private static var likedPostIDs = Set<String>()
    private static var savedPostIDs = Set<String>()
    private static var pageByPostID = [String: Int]()

    private var preview: Preview?
    private var lastCaptionWidth: CGFloat = 0
    var onLayoutChange: (() -> Void)?

    //UI COMPONENTS
    private let postHeader = DesignPostHeader()
    private let postMedia = DesignPostMedia()
    private let postActions = DesignPostActions()
    private let postLikes = UILabel()
    private let postCaption = UILabel()
    private let postDate = UILabel()

    private let likeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    //MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = DesignStyleTemp.background
        contentView.backgroundColor = DesignStyleTemp.background
        setupLayout()
        postActions.onLike = { [weak self] in self?.toggleLike() }
        postActions.onSave = { [weak self] in self?.toggleSave() }
        postMedia.onPageChange = { [weak self] page in self?.storePage(page) }
        postMedia.onDoubleTap = { [weak self] in self?.likeFromDoubleTap() }
        let captionTap = UITapGestureRecognizer(target: self, action: #selector(captionTapped))
        postCaption.addGestureRecognizer(captionTap)
        postCaption.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.bounds.width
        guard width > 0, abs(width - lastCaptionWidth) > 0.5 else { return }
        lastCaptionWidth = width
        applyCaption()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        preview = nil
        lastCaptionWidth = 0
        onLayoutChange = nil
        postHeader.prepareForReuse()
        postMedia.prepareForReuse()
        postActions.prepareForReuse()
        postLikes.text = nil
        postCaption.attributedText = nil
        postDate.text = nil
    }

    func configure(with preview: Preview) {
        self.preview = preview
        let liked = Self.likedPostIDs.contains(preview.id)
        let saved = Self.savedPostIDs.contains(preview.id)
        let page = Self.pageByPostID[preview.id] ?? 0
        postHeader.configure(username: preview.username, imageName: preview.imageName, audio: preview.audio)
        postMedia.configure(imageName: preview.imageName, pageCount: preview.pageCount, page: page)
        postActions.configure(pageCount: preview.pageCount, page: page, liked: liked, saved: saved)
        postLikes.text = likeText(preview.likeCount + (liked ? 1 : 0))
        postDate.text = dateFormatter.string(from: preview.date)
        applyCaption()
    }

    //LAYOUT and UI
    private func setupLayout() {
        postLikes.font = DesignStyleTemp.likeCountFont
        postLikes.textColor = DesignStyleTemp.primaryText
        postDate.font = DesignStyleTemp.dateFont
        postDate.textColor = DesignStyleTemp.secondaryText
        postCaption.numberOfLines = 0

        [postHeader, postMedia, postActions, postLikes, postCaption, postDate].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            postHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            postHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postHeader.heightAnchor.constraint(equalToConstant: DesignStyleTemp.headerHeight),

            postMedia.topAnchor.constraint(equalTo: postHeader.bottomAnchor),
            postMedia.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postMedia.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postActions.topAnchor.constraint(equalTo: postMedia.bottomAnchor),
            postActions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postActions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postActions.heightAnchor.constraint(equalToConstant: DesignStyleTemp.actionsHeight),

            postLikes.topAnchor.constraint(equalTo: postActions.bottomAnchor, constant: DesignStyleTemp.likesTop),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
            postLikes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),

            postCaption.topAnchor.constraint(equalTo: postLikes.bottomAnchor, constant: DesignStyleTemp.captionTop),
            postCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
            postCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),

            postDate.topAnchor.constraint(equalTo: postCaption.bottomAnchor, constant: DesignStyleTemp.dateTop),
            postDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DesignStyleTemp.textInset),
            postDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DesignStyleTemp.textInset),
            postDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DesignStyleTemp.postBottom)
        ])
    }

    //ACTIONS
    private func toggleLike() {
        guard let preview else { return }
        if Self.likedPostIDs.contains(preview.id) {
            Self.likedPostIDs.remove(preview.id)
        } else {
            Self.likedPostIDs.insert(preview.id)
        }
        refreshLike(animated: true)
    }

    private func likeFromDoubleTap() {
        guard let preview else { return }
        Self.likedPostIDs.insert(preview.id)
        refreshLike(animated: true)
        postMedia.showLikeHeart()
    }

    private func toggleSave() {
        guard let preview else { return }
        if Self.savedPostIDs.contains(preview.id) {
            Self.savedPostIDs.remove(preview.id)
        } else {
            Self.savedPostIDs.insert(preview.id)
        }
        let saved = Self.savedPostIDs.contains(preview.id)
        postActions.setSaved(saved)
    }

    @objc private func captionTapped() {
        guard let preview, showsMore else { return }
        if Self.expandedPostIDs.contains(preview.id) { return }
        Self.expandedPostIDs.insert(preview.id)
        applyCaption()
        onLayoutChange?()
    }

    //FUNCTIONS
    private func storePage(_ page: Int) {
        guard let preview else { return }
        Self.pageByPostID[preview.id] = page
        postActions.setPage(page, count: preview.pageCount)
    }

    private func refreshLike(animated: Bool) {
        guard let preview else { return }
        let liked = Self.likedPostIDs.contains(preview.id)
        postActions.setLiked(liked, animated: animated)
        postLikes.text = likeText(preview.likeCount + (liked ? 1 : 0))
    }

    private func likeText(_ count: Int) -> String {
        let number = likeFormatter.string(from: NSNumber(value: count)) ?? "\(count)"
        return count == 1 ? "\(number) like" : "\(number) likes"
    }

    private var showsMore: Bool {
        guard let preview else { return false }
        return !Self.expandedPostIDs.contains(preview.id) && captionNeedsMore(preview)
    }

    private func applyCaption() {
        guard let preview else { return }
        let expanded = Self.expandedPostIDs.contains(preview.id)
        if expanded || !captionNeedsMore(preview) {
            postCaption.attributedText = captionString(username: preview.username, caption: preview.caption, more: false)
        } else {
            postCaption.attributedText = collapsedCaption(username: preview.username, caption: preview.caption)
        }
    }

    private func captionNeedsMore(_ preview: Preview) -> Bool {
        let full = captionString(username: preview.username, caption: preview.caption, more: false)
        let width = max(contentView.bounds.width - (DesignStyleTemp.textInset * 2), 1)
        let height = full.boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).height
        let limit = (DesignStyleTemp.captionFont.lineHeight * CGFloat(DesignStyleTemp.maxCaptionLines)) + (DesignStyleTemp.captionLineSpacing * 2)
        return height > limit + 1
    }

    private func collapsedCaption(username: String, caption: String) -> NSAttributedString {
        let more = " ... more"
        var low = 0
        var high = caption.count
        var best = ""
        while low <= high {
            let mid = (low + high) / 2
            let slice = String(caption.prefix(mid)).trimmingCharacters(in: .whitespacesAndNewlines)
            let candidate = captionString(username: username, caption: slice, more: true)
            let width = max(contentView.bounds.width - (DesignStyleTemp.textInset * 2), 1)
            let height = candidate.boundingRect(
                with: CGSize(width: width, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            ).height
            let limit = (DesignStyleTemp.captionFont.lineHeight * CGFloat(DesignStyleTemp.maxCaptionLines)) + (DesignStyleTemp.captionLineSpacing * 2)
            if height <= limit + 1 {
                best = slice
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        if best.isEmpty {
            best = String(caption.prefix(40))
        }
        _ = more
        return captionString(username: username, caption: best, more: true)
    }

    private func captionString(username: String, caption: String, more: Bool) -> NSAttributedString {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: username, attributes: [
            .font: DesignStyleTemp.usernameFont,
            .foregroundColor: DesignStyleTemp.primaryText
        ]))
        text.append(NSAttributedString(string: " " + caption, attributes: [
            .font: DesignStyleTemp.captionFont,
            .foregroundColor: DesignStyleTemp.primaryText
        ]))
        if more {
            text.append(NSAttributedString(string: " ... more", attributes: [
                .font: DesignStyleTemp.moreFont,
                .foregroundColor: DesignStyleTemp.secondaryText
            ]))
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = DesignStyleTemp.captionLineSpacing
        text.addAttribute(.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: text.length))
        return text
    }

    private static func previewDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
}


//UI COMPONENTS

private final class DesignPostHeader: UIView {

    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let audioIcon = UIImageView()
    private let audioLabel = UILabel()
    private let audioRow = UIStackView()
    private let nameStack = UIStackView()
    private let menuButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DesignStyleTemp.background

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = DesignStyleTemp.avatarSize / 2

        usernameLabel.font = DesignStyleTemp.usernameFont
        usernameLabel.textColor = DesignStyleTemp.primaryText

        audioIcon.image = UIImage(systemName: "music.note")
        audioIcon.tintColor = DesignStyleTemp.secondaryText
        audioIcon.contentMode = .scaleAspectFit
        audioLabel.font = DesignStyleTemp.audioFont
        audioLabel.textColor = DesignStyleTemp.secondaryText

        audioRow.axis = .horizontal
        audioRow.spacing = 4
        audioRow.alignment = .center
        audioRow.addArrangedSubview(audioIcon)
        audioRow.addArrangedSubview(audioLabel)

        nameStack.axis = .vertical
        nameStack.spacing = 1
        nameStack.alignment = .leading
        nameStack.addArrangedSubview(usernameLabel)
        nameStack.addArrangedSubview(audioRow)

        menuButton.setImage(DesignStyleTemp.outlineIcon("ellipsis"), for: .normal)
        menuButton.tintColor = DesignStyleTemp.primaryText

        [avatarImageView, nameStack, menuButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignStyleTemp.headerLeading),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: DesignStyleTemp.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: DesignStyleTemp.avatarSize),

            nameStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: DesignStyleTemp.avatarToUsername),
            nameStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameStack.trailingAnchor.constraint(lessThanOrEqualTo: menuButton.leadingAnchor, constant: -8),

            audioIcon.widthAnchor.constraint(equalToConstant: 12),
            audioIcon.heightAnchor.constraint(equalToConstant: 12),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.headerTrailing),
            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            menuButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(username: String, imageName: String, audio: String?) {
        usernameLabel.text = username
        avatarImageView.image = UIImage(named: imageName)
        audioLabel.text = audio
        audioRow.isHidden = audio == nil
    }

    func prepareForReuse() {
        avatarImageView.image = nil
        usernameLabel.text = nil
        audioLabel.text = nil
        audioRow.isHidden = true
    }
}


private final class DesignPostMedia: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var onPageChange: ((Int) -> Void)?
    var onDoubleTap: (() -> Void)?

    private var imageName = "background_10"
    private var pageCount = 1
    private var currentPage = 0
    private var pendingPage = 0

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DesignPostMediaPageCell.self, forCellWithReuseIdentifier: "DesignPostMediaPageCell")
        return collectionView
    }()

    private let pageCounter = UILabel()
    private let likeHeart = UIImageView()
    private var heightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DesignStyleTemp.background
        clipsToBounds = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)

        pageCounter.font = DesignStyleTemp.pageCounterFont
        pageCounter.textColor = .white
        pageCounter.textAlignment = .center
        pageCounter.backgroundColor = DesignStyleTemp.pageCounterBackground
        pageCounter.layer.cornerRadius = DesignStyleTemp.pageCounterHeight / 2
        pageCounter.clipsToBounds = true
        pageCounter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pageCounter)

        likeHeart.image = DesignStyleTemp.outlineIcon("heart.fill")
        likeHeart.tintColor = .white
        likeHeart.alpha = 0
        likeHeart.translatesAutoresizingMaskIntoConstraints = false
        addSubview(likeHeart)

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        collectionView.addGestureRecognizer(doubleTap)

        heightConstraint = heightAnchor.constraint(equalToConstant: 262)
        heightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pageCounter.topAnchor.constraint(equalTo: topAnchor, constant: DesignStyleTemp.pageCounterTop),
            pageCounter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.pageCounterTrailing),
            pageCounter.heightAnchor.constraint(equalToConstant: DesignStyleTemp.pageCounterHeight),

            likeHeart.centerXAnchor.constraint(equalTo: centerXAnchor),
            likeHeart.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeHeart.widthAnchor.constraint(equalToConstant: 88),
            likeHeart.heightAnchor.constraint(equalToConstant: 88)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
        guard width > 0 else { return }
        let height = width / DesignStyleTemp.mediaAspect
        if heightConstraint?.constant != height {
            heightConstraint?.constant = height
        }
        let pageSize = CGSize(width: width, height: bounds.height)
        if layout.itemSize != pageSize {
            layout.itemSize = pageSize
            layout.invalidateLayout()
        }
        let offset = CGFloat(pendingPage) * width
        if abs(collectionView.contentOffset.x - offset) > 1, !collectionView.isDragging {
            collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
        }
    }

    func configure(imageName: String, pageCount: Int, page: Int) {
        self.imageName = imageName
        self.pageCount = max(pageCount, 1)
        currentPage = min(page, self.pageCount - 1)
        pendingPage = currentPage
        pageCounter.isHidden = self.pageCount < 2
        pageCounter.text = "  \(currentPage + 1)/\(self.pageCount)  "
        collectionView.reloadData()
        setNeedsLayout()
    }

    func prepareForReuse() {
        imageName = ""
        pageCount = 1
        currentPage = 0
        pendingPage = 0
        pageCounter.isHidden = true
        likeHeart.alpha = 0
    }

    func showLikeHeart() {
        likeHeart.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        likeHeart.alpha = 0
        UIView.animate(withDuration: 0.15, animations: {
            self.likeHeart.alpha = 1
            self.likeHeart.transform = .identity
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0.35, options: [], animations: {
                self.likeHeart.alpha = 0
            })
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignPostMediaPageCell", for: indexPath) as! DesignPostMediaPageCell
        cell.configure(imageName: imageName)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePage(from: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updatePage(from: scrollView)
        }
    }

    private func updatePage(from scrollView: UIScrollView) {
        let width = max(scrollView.bounds.width, 1)
        let page = min(max(Int(round(scrollView.contentOffset.x / width)), 0), pageCount - 1)
        currentPage = page
        pendingPage = page
        pageCounter.text = "  \(page + 1)/\(pageCount)  "
        onPageChange?(page)
    }

    @objc private func doubleTapped() {
        onDoubleTap?()
    }
}


private final class DesignPostMediaPageCell: UICollectionViewCell {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}


private final class DesignPostActions: UIView {

    var onLike: (() -> Void)?
    var onSave: (() -> Void)?

    private let likeButton = UIButton(type: .system)
    private let commentButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let leftStack = UIStackView()
    private let dotsStack = UIStackView()
    private var pageCount = 1
    private var page = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DesignStyleTemp.background

        configureIconButton(likeButton, name: "heart")
        configureIconButton(commentButton, name: "bubble.right")
        configureIconButton(shareButton, name: "paperplane")
        configureIconButton(saveButton, name: "bookmark")
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        leftStack.axis = .horizontal
        leftStack.spacing = DesignStyleTemp.actionGap
        leftStack.alignment = .center
        leftStack.addArrangedSubview(likeButton)
        leftStack.addArrangedSubview(commentButton)
        leftStack.addArrangedSubview(shareButton)

        dotsStack.axis = .horizontal
        dotsStack.spacing = DesignStyleTemp.dotSpacing
        dotsStack.alignment = .center

        [leftStack, dotsStack, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            leftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignStyleTemp.actionLeading),
            leftStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            likeButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            likeButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            commentButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            commentButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            shareButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            shareButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),

            dotsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotsStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignStyleTemp.actionLeading),
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget),
            saveButton.heightAnchor.constraint(equalToConstant: DesignStyleTemp.touchTarget)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(pageCount: Int, page: Int, liked: Bool, saved: Bool) {
        self.pageCount = pageCount
        self.page = page
        setLiked(liked, animated: false)
        setSaved(saved)
        rebuildDots()
    }

    func setPage(_ page: Int, count: Int) {
        self.page = page
        pageCount = count
        rebuildDots()
    }

    func setLiked(_ liked: Bool, animated: Bool) {
        let name = liked ? "heart.fill" : "heart"
        likeButton.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
        likeButton.tintColor = liked ? DesignStyleTemp.liked : DesignStyleTemp.primaryText
        if animated {
            likeButton.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            UIView.animate(withDuration: 0.15) {
                self.likeButton.transform = .identity
            }
        }
    }

    func setSaved(_ saved: Bool) {
        let name = saved ? "bookmark.fill" : "bookmark"
        saveButton.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
        saveButton.tintColor = DesignStyleTemp.primaryText
    }

    func prepareForReuse() {
        dotsStack.arrangedSubviews.forEach {
            dotsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        setLiked(false, animated: false)
        setSaved(false)
    }

    private func configureIconButton(_ button: UIButton, name: String) {
        button.setImage(DesignStyleTemp.outlineIcon(name), for: .normal)
        button.tintColor = DesignStyleTemp.primaryText
    }

    private func rebuildDots() {
        dotsStack.arrangedSubviews.forEach {
            dotsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        guard pageCount > 1 else {
            dotsStack.isHidden = true
            return
        }
        dotsStack.isHidden = false
        let visible = min(pageCount, DesignStyleTemp.maxDots)
        let activeIndex: Int
        if pageCount <= DesignStyleTemp.maxDots {
            activeIndex = page
        } else {
            activeIndex = min(page * (visible - 1) / max(pageCount - 1, 1), visible - 1)
        }
        for index in 0..<visible {
            let dot = UIView()
            dot.backgroundColor = index == activeIndex ? DesignStyleTemp.activePage : DesignStyleTemp.inactivePage
            dot.layer.cornerRadius = DesignStyleTemp.dotSize / 2
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
            dot.heightAnchor.constraint(equalToConstant: DesignStyleTemp.dotSize).isActive = true
            dotsStack.addArrangedSubview(dot)
        }
    }

    @objc private func likeTapped() {
        onLike?()
    }

    @objc private func saveTapped() {
        onSave?()
    }
}
