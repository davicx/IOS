//
//  PostContent.swift
//  Kite
//
//  Created by David Vasquez on 2/23/26.
//

import UIKit


final class PostContent: UIView {

    let headerView = UIView()
    let bodyView = UIView()
    let footerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .clear

        headerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        bodyView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
        footerView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.3)

        addPlaceholderLabel("Header", to: headerView)
        addPlaceholderLabel("Body", to: bodyView)
        addPlaceholderLabel("Footer", to: footerView)
    }

    func setupConstraints() {
        [headerView, bodyView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 100),

            footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addPlaceholderLabel(_ text: String, to view: UIView) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
