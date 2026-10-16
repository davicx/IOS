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

// Username and post caption in one line of text, then the comments entry.
final class ItemCaption: UIView {

    //UI COMPONENTS
    private let captionLabel = UILabel()
    private let commentsLabel = UILabel()

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.screenBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //LAYOUT and UI
    private func setupViews() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.numberOfLines = 0
        captionLabel.textColor = Colors.primaryText
        addSubview(captionLabel)

        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.font = Fonts.regular13
        commentsLabel.textColor = Colors.secondaryText
        commentsLabel.numberOfLines = 1
        addSubview(commentsLabel)

        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.spacingXS),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.spacingM),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.spacingM),

            commentsLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: Layout.spacingXS),
            commentsLabel.leadingAnchor.constraint(equalTo: captionLabel.leadingAnchor),
            commentsLabel.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            commentsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //FUNCTIONS
    func configure(with post: Post) {
        let username = post.postFrom?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let caption = post.postCaption?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if username.isEmpty && caption.isEmpty {
            captionLabel.attributedText = nil
            captionLabel.isHidden = true
        } else {
            captionLabel.isHidden = false
            captionLabel.attributedText = captionText(username: username, caption: caption)
        }

        let commentCount = post.commentsArray?.count ?? 0
        commentsLabel.text = commentCount > 0 ? "View all \(commentCount) comments" : "View comments"
    }

    private func captionText(username: String, caption: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 3

        let result = NSMutableAttributedString()
        if !username.isEmpty {
            result.append(NSAttributedString(
                string: username,
                attributes: [
                    .font: Fonts.semibold14,
                    .foregroundColor: Colors.primaryText,
                    .paragraphStyle: paragraph
                ]
            ))
        }
        if !caption.isEmpty {
            if result.length > 0 {
                result.append(NSAttributedString(string: " "))
            }
            result.append(NSAttributedString(
                string: caption,
                attributes: [
                    .font: Fonts.postCaptionFont,
                    .foregroundColor: Colors.primaryText,
                    .paragraphStyle: paragraph
                ]
            ))
        }
        return result
    }
}
