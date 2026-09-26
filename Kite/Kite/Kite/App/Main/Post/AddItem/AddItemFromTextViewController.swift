//
//  AddItemFromTextViewController.swift
//  Kite
//
//  Created by David Vasquez on 8/21/26.
//

import UIKit


final class AddItemFromTextViewController: UIViewController {

    /// Filled here → Review creates the item (Step 7). Do not call create from this screen.
    var draft = ItemDraft.empty(groupID: 0)
    var listName: String = "List"

    // UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerIconBackground = UIView()
    private let headerIconView = UIImageView()
    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    private let pasteTextView = UITextView()
    private let pastePlaceholderLabel = UILabel()

    private let examplesTitleLabel = UILabel()
    private let examplesStack = UIStackView()

    private let continueButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 14
    private let textViewMinHeight: CGFloat = 160

    // MANAGE VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Paste"
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
        setupKeyboardDismiss()
    }

    // LAYOUT
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        setupHeader()
        setupPasteField()
        setupExamples()
        setupContinueButton()

        let side = Layout.spacingXXL
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            headerIconBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            headerIconBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            headerIconBackground.widthAnchor.constraint(equalToConstant: 36),
            headerIconBackground.heightAnchor.constraint(equalToConstant: 36),

            headerIconView.centerXAnchor.constraint(equalTo: headerIconBackground.centerXAnchor),
            headerIconView.centerYAnchor.constraint(equalTo: headerIconBackground.centerYAnchor),
            headerIconView.widthAnchor.constraint(equalToConstant: 18),
            headerIconView.heightAnchor.constraint(equalToConstant: 18),

            headerTitleLabel.leadingAnchor.constraint(equalTo: headerIconBackground.trailingAnchor, constant: Layout.spacingS),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerIconBackground.centerYAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            headerSubtitleLabel.topAnchor.constraint(equalTo: headerIconBackground.bottomAnchor, constant: Layout.spacingS),
            headerSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            headerSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            pasteTextView.topAnchor.constraint(equalTo: headerSubtitleLabel.bottomAnchor, constant: Layout.spacingXL),
            pasteTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            pasteTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            pasteTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: textViewMinHeight),

            pastePlaceholderLabel.topAnchor.constraint(equalTo: pasteTextView.topAnchor, constant: Layout.spacingM),
            pastePlaceholderLabel.leadingAnchor.constraint(equalTo: pasteTextView.leadingAnchor, constant: Layout.spacingL),
            pastePlaceholderLabel.trailingAnchor.constraint(equalTo: pasteTextView.trailingAnchor, constant: -Layout.spacingL),

            examplesTitleLabel.topAnchor.constraint(equalTo: pasteTextView.bottomAnchor, constant: Layout.spacingXL),
            examplesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            examplesTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            examplesStack.topAnchor.constraint(equalTo: examplesTitleLabel.bottomAnchor, constant: Layout.spacingM),
            examplesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            examplesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            continueButton.topAnchor.constraint(equalTo: examplesStack.bottomAnchor, constant: Layout.spacingXXL),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    private func setupHeader() {
        headerIconBackground.translatesAutoresizingMaskIntoConstraints = false
        headerIconBackground.backgroundColor = Colors.newItemPasteIconBackground
        headerIconBackground.layer.cornerRadius = 18
        contentView.addSubview(headerIconBackground)

        headerIconView.translatesAutoresizingMaskIntoConstraints = false
        headerIconView.image = UIImage(systemName: "link")
        headerIconView.tintColor = Colors.primaryPink
        headerIconView.contentMode = .scaleAspectFit
        headerIconBackground.addSubview(headerIconView)

        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLabel.text = "Add from text"
        headerTitleLabel.font = Fonts.semibold17
        headerTitleLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(headerTitleLabel)

        headerSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerSubtitleLabel.text = "Paste a link, description, or anything you have. You’ll review the details next."
        headerSubtitleLabel.font = Fonts.regular14
        headerSubtitleLabel.textColor = Colors.subtleGrayText
        headerSubtitleLabel.numberOfLines = 0
        contentView.addSubview(headerSubtitleLabel)
    }

    private func setupPasteField() {
        pasteTextView.translatesAutoresizingMaskIntoConstraints = false
        pasteTextView.font = Fonts.regular16
        pasteTextView.textColor = Colors.primaryGrayText
        pasteTextView.backgroundColor = Colors.screenBackground
        pasteTextView.layer.cornerRadius = fieldCornerRadius
        pasteTextView.layer.borderWidth = 1
        pasteTextView.layer.borderColor = Colors.newItemCardBorder.cgColor
        pasteTextView.textContainerInset = UIEdgeInsets(
            top: Layout.spacingM,
            left: Layout.spacingS,
            bottom: Layout.spacingM,
            right: Layout.spacingS
        )
        pasteTextView.delegate = self
        contentView.addSubview(pasteTextView)

        pastePlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        pastePlaceholderLabel.text = "Paste a product link or describe what you want…"
        pastePlaceholderLabel.font = Fonts.regular16
        pastePlaceholderLabel.textColor = Colors.subtleGrayText
        pastePlaceholderLabel.numberOfLines = 0
        pastePlaceholderLabel.isUserInteractionEnabled = false
        contentView.addSubview(pastePlaceholderLabel)
    }

    private func setupExamples() {
        examplesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        examplesTitleLabel.text = "Examples:"
        examplesTitleLabel.font = Fonts.semibold14
        examplesTitleLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(examplesTitleLabel)

        examplesStack.translatesAutoresizingMaskIntoConstraints = false
        examplesStack.axis = .vertical
        examplesStack.spacing = Layout.spacingS
        examplesStack.alignment = .fill
        contentView.addSubview(examplesStack)

        let examples = [
            "https://www.nintendo.com/store/products/…",
            "Secret of Mana for Nintendo Switch",
            "I want wireless headphones under $100"
        ]
        for example in examples {
            examplesStack.addArrangedSubview(makeExampleRow(text: example))
        }
    }

    private func makeExampleRow(text: String) -> UIView {
        let row = UIControl()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.backgroundColor = Colors.newItemInfoBackground
        row.layer.cornerRadius = 10
        row.clipsToBounds = true

        let icon = UIImageView(image: UIImage(systemName: "link"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = Colors.subtleGrayText
        icon.contentMode = .scaleAspectFit

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = Fonts.regular13
        label.textColor = Colors.mutedGrayText
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail

        row.addSubview(icon)
        row.addSubview(label)

        NSLayoutConstraint.activate([
            row.heightAnchor.constraint(equalToConstant: 40),
            icon.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: Layout.spacingM),
            icon.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 14),
            icon.heightAnchor.constraint(equalToConstant: 14),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Layout.spacingS),
            label.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -Layout.spacingM),
            label.centerYAnchor.constraint(equalTo: row.centerYAnchor)
        ])

        row.addAction(UIAction { [weak self] _ in
            self?.pasteTextView.text = text
            self?.pastePlaceholderLabel.isHidden = true
        }, for: .touchUpInside)

        return row
    }

    private func setupContinueButton() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue to Review", for: .normal)
        if let sparkles = UIImage(systemName: "sparkles") {
            continueButton.setImage(sparkles, for: .normal)
            continueButton.tintColor = .white
            continueButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        }
        Buttons.buttonPinkStyle(button: continueButton)
        continueButton.layer.cornerRadius = 14
        continueButton.titleLabel?.font = Fonts.semibold16
        continueButton.addTarget(self, action: #selector(continueToReviewTapped), for: .touchUpInside)
        contentView.addSubview(continueButton)
    }

    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // DRAFT
    /// Heuristic: URL → `productURL` (+ leftover as `postText`); else whole blob → `postText`.
    func makeDraft() -> ItemDraft {
        let trimmed = pasteTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        draft.productURL = nil
        draft.postText = nil
        draft.name = ""

        if let urlString = firstURL(in: trimmed) {
            draft.productURL = urlString
            let remainder = trimmed
                .replacingOccurrences(of: urlString, with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            draft.postText = remainder.isEmpty ? nil : remainder
        } else {
            draft.postText = trimmed
        }
        return draft
    }

    private func firstURL(in text: String) -> String? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return nil
        }
        let range = NSRange(text.startIndex..., in: text)
        guard let match = detector.firstMatch(in: text, options: [], range: range),
              let url = match.url else {
            return nil
        }
        return url.absoluteString
    }

    // ACTIONS
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func continueToReviewTapped() {
        let trimmed = pasteTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            pasteTextView.layer.borderColor = Colors.primaryPink.cgColor
            return
        }
        pasteTextView.layer.borderColor = Colors.newItemCardBorder.cgColor

        let review = ReviewItemViewController()
        review.draft = makeDraft()
        review.listName = listName
        navigationController?.pushViewController(review, animated: true)
    }
}

extension AddItemFromTextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        pastePlaceholderLabel.isHidden = !textView.text.isEmpty
        if !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            pasteTextView.layer.borderColor = Colors.newItemCardBorder.cgColor
        }
    }
}
