//
//  MakeComment.swift
//  Kite
//
//  Created by David Vasquez on 4/2/26.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

final class MakeComment: UIView {

    //UI COMPONENTS
    private let profileImageView = UIImageView()
    private let textView = UITextView()
    private let sendButton = UIButton(type: .system)
    private let placeholderLabel = UILabel()

    private var textViewHeightConstraint: NSLayoutConstraint!

    private let minHeight: CGFloat = 36
    private let maxHeight: CGFloat = 120

    private var lastTextViewWidth: CGFloat = 0

    //Called with trimmed comment text when Send succeeds basic validation.
    var onSendTapped: ((String) -> Void)?

    func clearCommentText() {
        textView.text = ""
        updatePlaceholderVisibility()
        updateTextViewHeight()
    }

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let w = textView.bounds.width
        guard w > 0, w != lastTextViewWidth else { return }
        lastTextViewWidth = w
        updateTextViewHeight()
    }

    //LAYOUT and UI
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground

        setupProfileImageView()
        setupTextView()
        setupPlaceholder()
        setupSendButton()
        setupLayout()
        setupTapToFocusComment()
    }

    /// Focuses the comment field (e.g. from the view controller).
    func focusCommentInput() {
        DispatchQueue.main.async { [weak self] in
            _ = self?.textView.becomeFirstResponder()
        }
    }

    private func setupTapToFocusComment() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCommentBarTap))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }

    private func setupProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        profileImageView.tintColor = .secondaryLabel
        profileImageView.contentMode = .scaleAspectFit
        addSubview(profileImageView)
    }

    private func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 16
        textView.clipsToBounds = true
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self

        addSubview(textView)

        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: minHeight)
        textViewHeightConstraint.isActive = true
    }

    private func setupPlaceholder() {
        placeholderLabel.text = "Add a comment..."
        placeholderLabel.textColor = .placeholderText
        placeholderLabel.font = .systemFont(ofSize: 16)

        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 6)
        ])
    }

    private func setupSendButton() {
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        addSubview(sendButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.topAnchor.constraint(equalTo: textView.topAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32),

            textView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            sendButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -2),
            sendButton.widthAnchor.constraint(equalToConstant: 60),

            bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8)
        ])
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    private func updateTextViewHeight() {
        let width = textView.bounds.width
        guard width > 0 else { return }

        let fitting = textView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        let newHeight = min(max(fitting.height, minHeight), maxHeight)
        textViewHeightConstraint.constant = newHeight
        textView.isScrollEnabled = fitting.height > maxHeight
    }

    //ACTIONS
    @objc private func handleCommentBarTap() {
        textView.becomeFirstResponder()
    }

    @objc private func sendButtonTapped() {
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            print("POST NEW COMMENT: skipped — empty caption")
            return
        }
        onSendTapped?(trimmed)
    }
}

extension MakeComment: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
        updateTextViewHeight()
    }
}

extension MakeComment: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }
        if touchedView === sendButton { return false }
        if touchedView === textView || touchedView.isDescendant(of: textView) { return false }
        return true
    }
}
