//
//  AddSimpleItemViewController.swift
//  Kite
//

import UIKit


final class AddSimpleItemViewController: UIViewController, UITextViewDelegate {

    var groupID: Int = 0
    var listName: String = "List"

    private let spinnerHelper = SpinnerHelper()
    private let userDefaultManager = UserDefaultManager()
    private var isSubmitting = false

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let introTitleLabel = UILabel()
    private let introSubtitleLabel = UILabel()

    private let textCaptionLabel = UILabel()
    private let textView = UITextView()
    private let textPlaceholderLabel = UILabel()

    private let linkCaptionLabel = UILabel()
    private let linkField = UITextField()

    private let postButton = UIButton(type: .system)

    private let fieldCornerRadius: CGFloat = 14

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.screenBackground
        title = "Simple Item"
        navigationItem.largeTitleDisplayMode = .never
        setupViews()
        updatePostButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        introTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introTitleLabel.text = "Write something"
        introTitleLabel.font = Fonts.semibold17
        introTitleLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(introTitleLabel)

        introSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introSubtitleLabel.text = "This posts to \(listName)."
        introSubtitleLabel.font = Fonts.regular14
        introSubtitleLabel.textColor = Colors.subtleGrayText
        introSubtitleLabel.numberOfLines = 0
        contentView.addSubview(introSubtitleLabel)

        textCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        textCaptionLabel.text = "Text"
        textCaptionLabel.font = Fonts.semibold14
        textCaptionLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(textCaptionLabel)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = Fonts.regular16
        textView.textColor = Colors.primaryGrayText
        textView.backgroundColor = Colors.screenBackground
        textView.layer.cornerRadius = fieldCornerRadius
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Colors.newItemCardBorder.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.delegate = self
        contentView.addSubview(textView)

        textPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textPlaceholderLabel.text = "I love books about history..."
        textPlaceholderLabel.font = Fonts.regular16
        textPlaceholderLabel.textColor = Colors.subtleGrayText
        textView.addSubview(textPlaceholderLabel)

        linkCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        linkCaptionLabel.text = "Link (optional)"
        linkCaptionLabel.font = Fonts.semibold14
        linkCaptionLabel.textColor = Colors.primaryGrayText
        contentView.addSubview(linkCaptionLabel)

        linkField.translatesAutoresizingMaskIntoConstraints = false
        linkField.placeholder = "https://"
        linkField.font = Fonts.regular16
        linkField.textColor = Colors.primaryGrayText
        linkField.backgroundColor = Colors.screenBackground
        linkField.layer.cornerRadius = fieldCornerRadius
        linkField.layer.borderWidth = 1
        linkField.layer.borderColor = Colors.newItemCardBorder.cgColor
        linkField.keyboardType = .URL
        linkField.autocapitalizationType = .none
        linkField.autocorrectionType = .no
        linkField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        linkField.leftViewMode = .always
        linkField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Layout.spacingL, height: 1))
        linkField.rightViewMode = .always
        linkField.addTarget(self, action: #selector(linkChanged), for: .editingChanged)
        contentView.addSubview(linkField)

        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.setTitle("Post", for: .normal)
        Buttons.buttonPinkStyle(button: postButton)
        postButton.layer.cornerRadius = 14
        postButton.titleLabel?.font = Fonts.semibold16
        postButton.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
        contentView.addSubview(postButton)

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

            introTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacingXL),
            introTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            introTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            introSubtitleLabel.topAnchor.constraint(equalTo: introTitleLabel.bottomAnchor, constant: Layout.spacingS),
            introSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            introSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            textCaptionLabel.topAnchor.constraint(equalTo: introSubtitleLabel.bottomAnchor, constant: Layout.spacingXL),
            textCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            textCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            textView.topAnchor.constraint(equalTo: textCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            textView.heightAnchor.constraint(equalToConstant: 160),

            textPlaceholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 12),
            textPlaceholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 16),
            textPlaceholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -16),

            linkCaptionLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Layout.spacingXL),
            linkCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkCaptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),

            linkField.topAnchor.constraint(equalTo: linkCaptionLabel.bottomAnchor, constant: Layout.spacingS),
            linkField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            linkField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            linkField.heightAnchor.constraint(equalToConstant: 48),

            postButton.topAnchor.constraint(equalTo: linkField.bottomAnchor, constant: Layout.spacingXXL),
            postButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: side),
            postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            postButton.heightAnchor.constraint(equalToConstant: 52),
            postButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacingXXL)
        ])
    }

    func textViewDidChange(_ textView: UITextView) {
        textPlaceholderLabel.isHidden = !textView.text.isEmpty
        updatePostButton()
    }

    @objc private func linkChanged() {
        updatePostButton()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func updatePostButton() {
        let hasText = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        postButton.isEnabled = hasText && !isSubmitting
        postButton.backgroundColor = hasText ? Colors.buttonPinkBackground : Colors.buttonGrayBackground
        postButton.setTitleColor(hasText ? .white : Colors.subtleGrayText, for: .normal)
    }

    @objc private func postTapped() {
        let caption = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !caption.isEmpty, !isSubmitting else { return }

        isSubmitting = true
        updatePostButton()
        spinnerHelper.show(in: view, delay: 0.0)
        view.endEditing(true)

        let postFrom = userDefaultManager.getLoggedInUser()
        let link = linkField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let savedGroupID = groupID

        Task {
            let success = await PostLogic.shared.createTextItemPost(
                postFrom: postFrom,
                postTo: "\(savedGroupID)",
                postCaption: caption,
                groupID: savedGroupID,
                listID: 0,
                itemLink: link
            )

            if success {
                await GroupLogic.shared.fetchGroupWishlistItems(groupID: savedGroupID)
            }

            await MainActor.run {
                self.spinnerHelper.hide()
                self.isSubmitting = false
                self.updatePostButton()
                if success {
                    self.dismiss(animated: true)
                } else {
                    let alert = UIAlertController(title: "Couldn’t post", message: "Something went wrong. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
