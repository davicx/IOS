//
//  GroupCell.swift
//  Kite
//
//  Created by David Vasquez on 6/13/25.
//
// Parents: GroupsViewController

import UIKit


final class GroupCell: UITableViewCell {

    // LOGIC
    private let imageFunctions = ImageFunctions()
    private var configuredGroupID: Int?
    private var coverImageTask: Task<Void, Never>?

    // LAYOUT
    private let cardCornerRadius: CGFloat = 16
    private let coverSize: CGFloat = 92
    private let avatarSize: CGFloat = 28
    private let avatarOverlap: CGFloat = 8
    private let standardCardHeight: CGFloat = 128

    // UI COMPONENTS
    private let cardView = UIView()
    private let coverContainer = UIView()
    private let coverImageView = UIImageView()
    private let fallbackIconView = UIImageView()
    private let detailsStack = UIStackView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let metadataStack = UIStackView()
    private let memberCountIcon = UIImageView()
    private let memberCountLabel = UILabel()
    private let memberCountStack = UIStackView()
    private let creatorLabel = UILabel()
    private let footerRow = UIView()
    private let avatarsContainer = UIView()
    private let membershipBadge = UIView()
    private let membershipIcon = UIImageView()
    private let membershipLabel = UILabel()
    private let rightArrowImageView = UIImageView()

    private var avatarImageViews: [UIImageView] = []
    private var moreCountLabel: UILabel?

    // MANAGE VIEWS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupListCellViews()
        printCellInfo(cellName: "GroupCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageTask?.cancel()
        coverImageTask = nil
        configuredGroupID = nil

        coverImageView.image = nil
        showGroupPlaceholder(true)

        nameLabel.text = nil
        descriptionLabel.text = nil
        descriptionLabel.isHidden = true

        memberCountLabel.text = nil
        memberCountStack.isHidden = true
        creatorLabel.text = nil
        creatorLabel.isHidden = true
        metadataStack.isHidden = true

        clearSmallListUserImages()
        membershipLabel.text = nil
        membershipIcon.image = nil
        membershipBadge.isHidden = true

        cardView.alpha = 1.0
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        cardView.alpha = highlighted ? 0.78 : 1.0
    }

    // LAYOUT
    private func setupListCellViews() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = Colors.screenBackground
        cardView.layer.cornerRadius = cardCornerRadius
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = Colors.newItemCardBorder.cgColor
        cardView.clipsToBounds = true
        contentView.addSubview(cardView)

        coverContainer.translatesAutoresizingMaskIntoConstraints = false
        coverContainer.backgroundColor = Colors.newItemPasteCardBackground
        coverContainer.layer.cornerRadius = 12
        coverContainer.clipsToBounds = true
        coverContainer.isAccessibilityElement = false
        cardView.addSubview(coverContainer)

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.isAccessibilityElement = false
        coverContainer.addSubview(coverImageView)

        fallbackIconView.translatesAutoresizingMaskIntoConstraints = false
        fallbackIconView.image = UIImage(systemName: "gift.fill")
        fallbackIconView.tintColor = Colors.primaryPink
        fallbackIconView.contentMode = .scaleAspectFit
        fallbackIconView.isAccessibilityElement = false
        coverContainer.addSubview(fallbackIconView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Fonts.listNameFont
        nameLabel.textColor = Colors.primaryGrayText
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byTruncatingTail

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Fonts.listDescriptionFont
        descriptionLabel.textColor = Colors.subtleGrayText
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.isHidden = true

        memberCountIcon.translatesAutoresizingMaskIntoConstraints = false
        memberCountIcon.image = UIImage(systemName: "person.2")
        memberCountIcon.tintColor = Colors.subtleGrayText
        memberCountIcon.contentMode = .scaleAspectFit

        memberCountLabel.translatesAutoresizingMaskIntoConstraints = false
        memberCountLabel.font = Fonts.regular13
        memberCountLabel.textColor = Colors.subtleGrayText

        memberCountStack.translatesAutoresizingMaskIntoConstraints = false
        memberCountStack.axis = .horizontal
        memberCountStack.alignment = .center
        memberCountStack.spacing = Layout.spacingXS
        memberCountStack.addArrangedSubview(memberCountIcon)
        memberCountStack.addArrangedSubview(memberCountLabel)

        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorLabel.font = Fonts.regular13
        creatorLabel.textColor = Colors.subtleGrayText
        creatorLabel.numberOfLines = 1
        creatorLabel.lineBreakMode = .byTruncatingTail

        metadataStack.translatesAutoresizingMaskIntoConstraints = false
        metadataStack.axis = .horizontal
        metadataStack.alignment = .center
        metadataStack.spacing = Layout.spacingM
        metadataStack.addArrangedSubview(memberCountStack)
        metadataStack.addArrangedSubview(creatorLabel)

        NSLayoutConstraint.activate([
            memberCountIcon.widthAnchor.constraint(equalToConstant: 15),
            memberCountIcon.heightAnchor.constraint(equalToConstant: 15)
        ])

        avatarsContainer.translatesAutoresizingMaskIntoConstraints = false
        avatarsContainer.isHidden = true

        membershipIcon.translatesAutoresizingMaskIntoConstraints = false
        membershipIcon.tintColor = Colors.secondaryGrayText
        membershipIcon.contentMode = .scaleAspectFit

        membershipLabel.translatesAutoresizingMaskIntoConstraints = false
        membershipLabel.font = Fonts.regular12
        membershipLabel.textColor = Colors.secondaryGrayText

        membershipBadge.translatesAutoresizingMaskIntoConstraints = false
        membershipBadge.backgroundColor = Colors.newItemInfoBackground
        membershipBadge.layer.cornerRadius = 8
        membershipBadge.clipsToBounds = true
        membershipBadge.isHidden = true

        let badgeStack = UIStackView(arrangedSubviews: [membershipIcon, membershipLabel])
        badgeStack.translatesAutoresizingMaskIntoConstraints = false
        badgeStack.axis = .horizontal
        badgeStack.alignment = .center
        badgeStack.spacing = Layout.spacingXS
        membershipBadge.addSubview(badgeStack)

        footerRow.translatesAutoresizingMaskIntoConstraints = false
        footerRow.addSubview(avatarsContainer)
        footerRow.addSubview(membershipBadge)

        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        detailsStack.axis = .vertical
        detailsStack.alignment = .fill
        detailsStack.spacing = Layout.spacingS
        detailsStack.addArrangedSubview(nameLabel)
        detailsStack.addArrangedSubview(descriptionLabel)
        detailsStack.addArrangedSubview(metadataStack)
        detailsStack.addArrangedSubview(footerRow)
        detailsStack.setCustomSpacing(Layout.spacingXS, after: nameLabel)
        cardView.addSubview(detailsStack)

        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        rightArrowImageView.image = UIImage(systemName: "chevron.right")
        rightArrowImageView.tintColor = Colors.secondaryGrayText
        rightArrowImageView.contentMode = .scaleAspectFit
        rightArrowImageView.isAccessibilityElement = false
        cardView.addSubview(rightArrowImageView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.spacingL),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.spacingL),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: standardCardHeight),

            coverContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Layout.spacingM),
            coverContainer.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            coverContainer.widthAnchor.constraint(equalToConstant: coverSize),
            coverContainer.heightAnchor.constraint(equalToConstant: coverSize),

            coverImageView.topAnchor.constraint(equalTo: coverContainer.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: coverContainer.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: coverContainer.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: coverContainer.bottomAnchor),

            fallbackIconView.centerXAnchor.constraint(equalTo: coverContainer.centerXAnchor),
            fallbackIconView.centerYAnchor.constraint(equalTo: coverContainer.centerYAnchor),
            fallbackIconView.widthAnchor.constraint(equalToConstant: 26),
            fallbackIconView.heightAnchor.constraint(equalToConstant: 26),

            rightArrowImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Layout.spacingM),
            rightArrowImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 14),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 16),

            detailsStack.leadingAnchor.constraint(equalTo: coverContainer.trailingAnchor, constant: Layout.spacingM),
            detailsStack.trailingAnchor.constraint(equalTo: rightArrowImageView.leadingAnchor, constant: -Layout.spacingS),
            detailsStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            detailsStack.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: Layout.spacingM),
            detailsStack.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -Layout.spacingM),

            footerRow.heightAnchor.constraint(greaterThanOrEqualToConstant: avatarSize),

            avatarsContainer.leadingAnchor.constraint(equalTo: footerRow.leadingAnchor),
            avatarsContainer.centerYAnchor.constraint(equalTo: footerRow.centerYAnchor),
            avatarsContainer.heightAnchor.constraint(equalToConstant: avatarSize),

            membershipBadge.trailingAnchor.constraint(equalTo: footerRow.trailingAnchor),
            membershipBadge.centerYAnchor.constraint(equalTo: footerRow.centerYAnchor),
            membershipBadge.leadingAnchor.constraint(greaterThanOrEqualTo: avatarsContainer.trailingAnchor, constant: Layout.spacingS),
            membershipBadge.heightAnchor.constraint(equalToConstant: 24),

            badgeStack.topAnchor.constraint(equalTo: membershipBadge.topAnchor, constant: 4),
            badgeStack.bottomAnchor.constraint(equalTo: membershipBadge.bottomAnchor, constant: -4),
            badgeStack.leadingAnchor.constraint(equalTo: membershipBadge.leadingAnchor, constant: 8),
            badgeStack.trailingAnchor.constraint(equalTo: membershipBadge.trailingAnchor, constant: -8),

            membershipIcon.widthAnchor.constraint(equalToConstant: 12),
            membershipIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

    // FUNCTIONS
    func setupGroupListCell(
        with group: GroupModel,
        currentUser: String,
        memberProfiles: [String: User] = [:]
    ) {
        configuredGroupID = group.groupID

        nameLabel.text = group.groupName

        let descriptionText = getListDescriptionText(for: group.groupDescription)
        if let descriptionText = descriptionText {
            descriptionLabel.text = descriptionText
            descriptionLabel.isHidden = false
        } else {
            descriptionLabel.text = nil
            descriptionLabel.isHidden = true
        }

        let uniqueMembers = getActiveListMembers(from: group.activeGroupMembers)
        let memberCount = uniqueMembers.count
        if memberCount > 0 {
            memberCountLabel.text = memberCount == 1 ? "1 member" : "\(memberCount) members"
            memberCountStack.isHidden = false
        } else {
            memberCountStack.isHidden = true
        }

        if let createdBy = group.createdBy, !createdBy.isEmpty {
            if createdBy.caseInsensitiveCompare(currentUser) == .orderedSame {
                creatorLabel.text = "Created by you"
            } else {
                creatorLabel.text = "Created by \(createdBy)"
            }
            creatorLabel.isHidden = false
        } else {
            creatorLabel.text = nil
            creatorLabel.isHidden = true
        }

        metadataStack.isHidden = memberCountStack.isHidden && creatorLabel.isHidden

        getListUsers(uniqueMembers: uniqueMembers, currentUser: currentUser, createdBy: group.createdBy)
        setupSmallListUserImages(uniqueMembers: uniqueMembers, memberProfiles: memberProfiles)
        loadGroupImage(from: group.groupImage, forGroupID: group.groupID)
    }

    private func getListDescriptionText(for raw: String) -> String? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return nil }
        if trimmed.caseInsensitiveCompare("this is my new group so cool") == .orderedSame {
            return nil
        }
        return trimmed
    }

    private func getActiveListMembers(from members: [String]) -> [String] {
        var seen = Set<String>()
        var unique: [String] = []
        for member in members {
            let key = member.lowercased()
            if seen.contains(key) { continue }
            seen.insert(key)
            unique.append(member)
        }
        return unique
    }

    private func getListUsers(
        uniqueMembers: [String],
        currentUser: String,
        createdBy: String?
    ) {
        let othersExist = uniqueMembers.contains {
            $0.caseInsensitiveCompare(currentUser) != .orderedSame
        }
        let isOwner = (createdBy ?? "").caseInsensitiveCompare(currentUser) == .orderedSame

        if othersExist {
            membershipLabel.text = "Shared"
            membershipIcon.image = UIImage(systemName: "person.2.fill")
            membershipBadge.isHidden = false
        } else if isOwner {
            membershipLabel.text = "Only me"
            membershipIcon.image = UIImage(systemName: "person.fill")
            membershipBadge.isHidden = false
        } else if !uniqueMembers.isEmpty {
            membershipLabel.text = "Shared"
            membershipIcon.image = UIImage(systemName: "person.2.fill")
            membershipBadge.isHidden = false
        } else {
            membershipBadge.isHidden = true
        }
    }

    private func setupSmallListUserImages(uniqueMembers: [String], memberProfiles: [String: User]) {
        clearSmallListUserImages()

        let profiles = uniqueMembers.compactMap { username -> (String, UIImage)? in
            guard let user = memberProfiles[username.lowercased()],
                  let image = user.profileImage else {
                return nil
            }
            return (username, image)
        }

        guard !profiles.isEmpty else {
            avatarsContainer.isHidden = true
            return
        }

        avatarsContainer.isHidden = false
        let visible = Array(profiles.prefix(3))
        let overflow = max(0, uniqueMembers.count - visible.count)

        var previousView: UIView?
        for (index, entry) in visible.enumerated() {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = entry.1
            ImageStyle.userProfileImage(imageView: imageView, diameter: avatarSize)
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.isAccessibilityElement = false
            avatarsContainer.addSubview(imageView)
            avatarImageViews.append(imageView)

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: avatarSize),
                imageView.heightAnchor.constraint(equalToConstant: avatarSize),
                imageView.centerYAnchor.constraint(equalTo: avatarsContainer.centerYAnchor),
                imageView.leadingAnchor.constraint(
                    equalTo: avatarsContainer.leadingAnchor,
                    constant: CGFloat(index) * (avatarSize - avatarOverlap)
                )
            ])
            previousView = imageView
            avatarsContainer.bringSubviewToFront(imageView)
        }

        // Keep earliest avatars visually behind later ones
        for imageView in avatarImageViews {
            avatarsContainer.bringSubviewToFront(imageView)
        }

        if overflow > 0, let previousView = previousView {
            let moreLabel = UILabel()
            moreLabel.translatesAutoresizingMaskIntoConstraints = false
            moreLabel.text = "+\(overflow)"
            moreLabel.font = Fonts.regular12
            moreLabel.textColor = Colors.secondaryGrayText
            moreLabel.textAlignment = .center
            moreLabel.backgroundColor = Colors.buttonGrayBackground
            moreLabel.layer.cornerRadius = avatarSize / 2
            moreLabel.clipsToBounds = true
            moreLabel.layer.borderWidth = 1.5
            moreLabel.layer.borderColor = UIColor.white.cgColor
            moreLabel.isAccessibilityElement = false
            avatarsContainer.addSubview(moreLabel)
            moreCountLabel = moreLabel

            NSLayoutConstraint.activate([
                moreLabel.widthAnchor.constraint(equalToConstant: avatarSize),
                moreLabel.heightAnchor.constraint(equalToConstant: avatarSize),
                moreLabel.centerYAnchor.constraint(equalTo: avatarsContainer.centerYAnchor),
                moreLabel.leadingAnchor.constraint(
                    equalTo: previousView.trailingAnchor,
                    constant: -avatarOverlap
                ),
                moreLabel.trailingAnchor.constraint(equalTo: avatarsContainer.trailingAnchor)
            ])
        } else if let last = avatarImageViews.last {
            last.trailingAnchor.constraint(equalTo: avatarsContainer.trailingAnchor).isActive = true
        }
    }

    private func clearSmallListUserImages() {
        avatarImageViews.forEach { $0.removeFromSuperview() }
        avatarImageViews.removeAll()
        moreCountLabel?.removeFromSuperview()
        moreCountLabel = nil
        avatarsContainer.isHidden = true
    }

    private func loadGroupImage(from urlString: String?, forGroupID groupID: Int) {
        coverImageTask?.cancel()
        coverImageView.image = nil
        showGroupPlaceholder(true)

        guard let urlString = urlString,
              !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              urlString.lowercased() != "empty",
              urlString.lowercased() != "needgroupimage",
              urlString.lowercased() != "needgroupname" else {
            return
        }

        coverImageTask = Task {
            let image = await imageFunctions.fetchImage(from: urlString)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard self.configuredGroupID == groupID else { return }
                if let image = image {
                    self.coverImageView.image = image
                    self.showGroupPlaceholder(false)
                } else {
                    self.showGroupPlaceholder(true)
                }
            }
        }
    }

    private func showGroupPlaceholder(_ show: Bool) {
        fallbackIconView.isHidden = !show
        coverContainer.backgroundColor = Colors.newItemPasteCardBackground
        if show {
            coverImageView.image = nil
        }
    }
}
