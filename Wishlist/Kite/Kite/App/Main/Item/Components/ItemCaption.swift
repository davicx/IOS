//
//  ItemCaption.swift
//  Kite
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

// Author row, caption, and the comments link. The username is not repeated in the caption.
final class ItemCaption: UIView {

    //UI COMPONENTS
    private let author = ItemHeader()
    private let textStack = UIStackView()
    private let captionLabel = UILabel()
    private let simpleTextView = UITextView()
    private let linkButton = UIButton(type: .system)
    private let commentsLabel = UILabel()
    private var midnight = false
    private var textTop: NSLayoutConstraint!
    private var commentsTop: NSLayoutConstraint!
    private var commentsHeight: NSLayoutConstraint!
    private var linkDestination: URL?

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        clipsToBounds = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        author.translatesAutoresizingMaskIntoConstraints = false
        author.clipsToBounds = false
        addSubview(author)

        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .fill
        textStack.spacing = Layout.spacingXS
        addSubview(textStack)

        captionLabel.numberOfLines = 0
        captionLabel.font = Fonts.postCaptionFont
        captionLabel.textColor = Colors.primaryText
        textStack.addArrangedSubview(captionLabel)

        simpleTextView.isEditable = false
        simpleTextView.isScrollEnabled = false
        simpleTextView.isSelectable = true
        simpleTextView.backgroundColor = .clear
        simpleTextView.textContainerInset = .zero
        simpleTextView.textContainer.lineFragmentPadding = 0
        simpleTextView.dataDetectorTypes = []
        simpleTextView.linkTextAttributes = [
            .foregroundColor: Colors.primaryBlue,
            .underlineStyle: 0
        ]
        simpleTextView.font = Fonts.regular16
        simpleTextView.textColor = Colors.primaryText
        simpleTextView.isHidden = true
        textStack.addArrangedSubview(simpleTextView)

        linkButton.contentHorizontalAlignment = .leading
        linkButton.titleLabel?.font = Fonts.itemLinkFont
        linkButton.setTitleColor(Colors.primaryBlue, for: .normal)
        linkButton.tintColor = Colors.primaryBlue
        linkButton.isHidden = true
        linkButton.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        textStack.addArrangedSubview(linkButton)

        commentsLabel.font = Fonts.regular13
        commentsLabel.textColor = Colors.secondaryText
        commentsLabel.numberOfLines = 1
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentsLabel)

        textTop = textStack.topAnchor.constraint(equalTo: author.authorColumn.bottomAnchor, constant: Layout.spacingXS)
        commentsTop = commentsLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: Layout.spacingS)
        commentsHeight = commentsLabel.heightAnchor.constraint(equalToConstant: 0)
        let avatarLimit = author.avatarBottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Layout.spacingM)
        avatarLimit.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: topAnchor),
            author.leadingAnchor.constraint(equalTo: leadingAnchor),
            author.trailingAnchor.constraint(equalTo: trailingAnchor),

            textTop,
            textStack.leadingAnchor.constraint(equalTo: author.authorColumn.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: author.authorColumn.trailingAnchor),

            commentsTop,
            commentsLabel.leadingAnchor.constraint(equalTo: author.authorColumn.leadingAnchor),
            commentsLabel.trailingAnchor.constraint(equalTo: author.authorColumn.trailingAnchor),
            commentsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.spacingM),
            avatarLimit
        ])
    }

    func applyMidnight(_ on: Bool) {
        midnight = on
        backgroundColor = on ? MidnightColors.cardBackground : Colors.screenBackground
        captionLabel.textColor = on ? MidnightColors.primaryText : Colors.primaryText
        simpleTextView.textColor = on ? MidnightColors.primaryText : Colors.primaryText
        let link = on ? MidnightColors.link : Colors.primaryBlue
        simpleTextView.linkTextAttributes = [
            .foregroundColor: link,
            .underlineStyle: 0
        ]
        linkButton.setTitleColor(link, for: .normal)
        linkButton.tintColor = link
        commentsLabel.textColor = on ? MidnightColors.secondaryText : Colors.secondaryText
        author.applyMidnight(on)
    }

    //FUNCTIONS
    func prepareForReuse() {
        author.prepareForReuse()
        linkDestination = nil
        linkButton.setTitle(nil, for: .normal)
        linkButton.isHidden = true
        simpleTextView.text = nil
        simpleTextView.isHidden = true
        captionLabel.text = nil
        captionLabel.isHidden = true
        commentsLabel.text = nil
        commentsLabel.isHidden = false
        commentsTop.constant = Layout.spacingS
        commentsHeight.isActive = false
        textTop.constant = 0
    }

    func configure(with post: Post, simple: Bool = false, showsMenu: Bool = true, showsComments: Bool = true) {
        author.setMenuHidden(!showsMenu)
        author.configure(with: post)

        let caption = post.postCaption ?? ""
        let trimmedCaption = caption.trimmingCharacters(in: .whitespacesAndNewlines)
        linkDestination = nil
        linkButton.setTitle(nil, for: .normal)
        linkButton.isHidden = true
        simpleTextView.text = nil
        simpleTextView.isHidden = true
        captionLabel.text = nil
        captionLabel.isHidden = true

        if simple {
            simpleTextView.isHidden = trimmedCaption.isEmpty
            simpleTextView.attributedText = simpleCaptionText(trimmedCaption)
            if let destination = openableURL(from: post.itemLink), let domain = displayDomain(from: destination) {
                linkDestination = destination
                linkButton.setTitle("\(domain) ↗", for: .normal)
                linkButton.isHidden = false
            }
        } else if !trimmedCaption.isEmpty {
            captionLabel.isHidden = false
            captionLabel.text = caption.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        let hasText = !captionLabel.isHidden || !simpleTextView.isHidden || !linkButton.isHidden
        textTop.constant = hasText ? Layout.spacingXS : 0

        let commentCount = post.commentsArray?.count ?? 0
        commentsLabel.isHidden = !showsComments
        commentsHeight.isActive = !showsComments
        commentsTop.constant = showsComments ? Layout.spacingS : 0
        commentsLabel.text = showsComments
            ? (commentCount > 0 ? "View all \(commentCount) comments" : "View comments")
            : nil
    }

    @objc private func linkTapped() {
        guard let linkDestination else { return }
        UIApplication.shared.open(linkDestination)
    }

    private func simpleCaptionText(_ caption: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        let result = NSMutableAttributedString(
            string: caption,
            attributes: [
                .font: Fonts.regular16,
                .foregroundColor: midnight ? MidnightColors.primaryText : Colors.primaryText,
                .paragraphStyle: paragraph
            ]
        )
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return result
        }
        let range = NSRange(caption.startIndex..., in: caption)
        detector.enumerateMatches(in: caption, options: [], range: range) { match, _, _ in
            guard let match, let url = match.url else { return }
            result.addAttribute(.link, value: url, range: match.range)
            result.addAttribute(.foregroundColor, value: midnight ? MidnightColors.link : Colors.primaryBlue, range: match.range)
        }
        return result
    }

    private func displayDomain(from url: URL) -> String? {
        guard var host = url.host, !host.isEmpty else { return nil }
        if host.hasPrefix("www.") {
            host = String(host.dropFirst(4))
        }
        return host
    }

    private func openableURL(from raw: String?) -> URL? {
        let trimmed = raw?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !trimmed.isEmpty else { return nil }
        let withScheme = trimmed.contains("://") ? trimmed : "https://\(trimmed)"
        guard let url = URL(string: withScheme), let scheme = url.scheme?.lowercased(), scheme == "http" || scheme == "https" else {
            return nil
        }
        return url
    }
}
