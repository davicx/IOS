//
//  LoadingPlaceholderView.swift
//  Kite
//
//  Generic LOADING / LOADED pattern for any UI: add UILabel, UITextView, UIImageView,
//  custom views, etc. inside `contentContainer`, then call `showLoading()` / `showContent()`.
//

import UIKit


//LOGIC
//UI COMPONENTS
//MANAGE VIEWS
//LAYOUT and UI
//ACTIONS
//FUNCTIONS

/// **LOADING:** gray holder on top · **LOADED:** your real UI in `contentContainer` (labels, text, images, etc.)
class LoadingPlaceholderView: UIView {

    //UI COMPONENTS
    /// Add subviews here (labels, text fields, image views, stacks, etc.).
    let contentContainer = UIView()

    private let holderView = UIView()

    /// Instagram-like skeleton gray.
    var holderColor: UIColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0) {
        didSet { holderView.backgroundColor = holderColor }
    }

    var cornerRadius: CGFloat = 12 {
        didSet { applyCornerRadius() }
    }

    /// `true` when the gray holder is visible.
    var isShowingPlaceholder: Bool {
        !holderView.isHidden
    }

    //MANAGE VIEWS
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setupViews()
        setupLayout()
        applyCornerRadius()
        showLoading()
    }

    func applyCornerRadius() {
        layer.cornerRadius = cornerRadius
        contentContainer.layer.cornerRadius = cornerRadius
        holderView.layer.cornerRadius = cornerRadius
        cornerRadiusDidChange()
    }

    /// Subclasses override to style inner views when `cornerRadius` changes.
    func cornerRadiusDidChange() {}

    //LAYOUT and UI
    private func setupViews() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.clipsToBounds = true

        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.backgroundColor = holderColor
        holderView.clipsToBounds = true

        addSubview(contentContainer)
        addSubview(holderView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

            holderView.topAnchor.constraint(equalTo: topAnchor),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    //ACTIONS
    /// LOADING: gray holder covers `contentContainer`.
    func showLoading() {
        holderView.isHidden = false
        bringSubviewToFront(holderView)
    }

    /// LOADED: real UI visible; holder hidden.
    func showContent() {
        holderView.isHidden = true
    }
}
