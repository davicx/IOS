//
//  PlaceholderView.swift
//  Kite
//
//  Fixed-size gray loading shape (text line, circle, etc.). Pair with real content
//  and cross-fade via `show()` / `hide()`. Not wired into screens yet.
//

import UIKit


final class PlaceholderView: UIView {

    init(
        width: CGFloat,
        height: CGFloat,
        isCircle: Bool = false
    ) {
        super.init(frame: .zero)

        backgroundColor = Colors.loadingViewBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = isCircle ? height / 2 : 4

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        alpha = 1
        isHidden = false
    }

    func hide(animated: Bool = true) {
        guard animated else {
            alpha = 0
            isHidden = true
            return
        }

        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
}
