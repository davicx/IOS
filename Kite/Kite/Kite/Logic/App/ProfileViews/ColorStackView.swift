//
//  ColorStackView.swift
//  Kite
//
//  Created by David Vasquez on 3/7/25.
//


import UIKit


class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Create individual views
        let leftView = createLeftView()
        let middleView = createMiddleView()
        let rightView = createRightView()

        // Add to parent stack
        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createLeftView() -> UIView {
        let leftView = createContainerView(topColor: .red, bottomColor: .orange)

        let numberLabel = createNumberLabel(text: "14")
        let textLabel = createTextLabel(text: "Following", alignment: .right, padding: 12)

        leftView.subviews[0].addSubview(numberLabel) // Top container
        leftView.subviews[1].addSubview(textLabel)   // Bottom container

        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: leftView.subviews[0].centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: leftView.subviews[0].centerYAnchor, constant: -6),

            textLabel.leadingAnchor.constraint(equalTo: leftView.subviews[1].leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: leftView.subviews[1].trailingAnchor, constant: -12),
            textLabel.centerYAnchor.constraint(equalTo: leftView.subviews[1].centerYAnchor)
        ])

        return leftView
    }

    private func createMiddleView() -> UIView {
        let middleView = createContainerView(topColor: .green, bottomColor: .yellow)

        let numberLabel = createNumberLabel(text: "38")
        let textLabel = createTextLabel(text: "Followers", alignment: .center)

        middleView.subviews[0].addSubview(numberLabel)
        middleView.subviews[1].addSubview(textLabel)

        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: middleView.subviews[0].centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: middleView.subviews[0].centerYAnchor, constant: -6),

            textLabel.centerXAnchor.constraint(equalTo: middleView.subviews[1].centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: middleView.subviews[1].centerYAnchor)
        ])

        return middleView
    }

    private func createRightView() -> UIView {
        let rightView = createContainerView(topColor: .blue, bottomColor: .purple)

        let numberLabel = createNumberLabel(text: "91")
        let textLabel = createTextLabel(text: "Likes", alignment: .left, padding: 12)

        rightView.subviews[0].addSubview(numberLabel)
        rightView.subviews[1].addSubview(textLabel)

        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: rightView.subviews[0].centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: rightView.subviews[0].centerYAnchor, constant: -6),

            textLabel.leadingAnchor.constraint(equalTo: rightView.subviews[1].leadingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: rightView.subviews[1].trailingAnchor),
            textLabel.centerYAnchor.constraint(equalTo: rightView.subviews[1].centerYAnchor)
        ])

        return rightView
    }


    private func createContainerView(topColor: UIColor, bottomColor: UIColor) -> UIView {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let topContainer = UIView()
        topContainer.backgroundColor = topColor
        topContainer.translatesAutoresizingMaskIntoConstraints = false

        let bottomContainer = UIView()
        bottomContainer.backgroundColor = bottomColor
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(topContainer)
        containerView.addSubview(bottomContainer)

        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),

            bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        return containerView
    }

    private func createNumberLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 1.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createTextLabel(text: String, alignment: NSTextAlignment, padding: CGFloat = 0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = alignment
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 1.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}




/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(
            number: "14", label: "Following", topColor: .red, bottomColor: .orange,
            textAlignment: .right, padding: 12
        )
        let middleView = createContainerView(
            number: "38", label: "Followers", topColor: .green, bottomColor: .yellow,
            textAlignment: .center
        )
        let rightView = createContainerView(
            number: "91", label: "Likes", topColor: .blue, bottomColor: .purple,
            textAlignment: .left, padding: 12
        )

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(
        number: String,
        label: String,
        topColor: UIColor,
        bottomColor: UIColor,
        textAlignment: NSTextAlignment,
        padding: CGFloat = 0
    ) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1.0

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 0
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let topContainer = UIView()
        topContainer.backgroundColor = topColor
        topContainer.translatesAutoresizingMaskIntoConstraints = false

        let bottomContainer = UIView()
        bottomContainer.backgroundColor = bottomColor
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.layer.borderColor = UIColor.blue.cgColor
        numberLabel.layer.borderWidth = 1.0
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = .darkGray
        textLabel.textAlignment = textAlignment
        textLabel.layer.borderColor = UIColor.blue.cgColor
        textLabel.layer.borderWidth = 1.0
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        topContainer.addSubview(numberLabel)
        bottomContainer.addSubview(textLabel)

        verticalStackView.addArrangedSubview(topContainer)
        verticalStackView.addArrangedSubview(bottomContainer)
        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            numberLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: -6),

            textLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor),

            textLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -padding)
        ])

        return containerView
    }
}

*/
//STEP 5: Working aliging text now
/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(number: "14", label: "Following", topColor: .red, bottomColor: .orange)
        let middleView = createContainerView(number: "38", label: "Followers", topColor: .green, bottomColor: .yellow)
        let rightView = createContainerView(number: "91", label: "Likes", topColor: .blue, bottomColor: .purple)

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(number: String, label: String, topColor: UIColor, bottomColor: UIColor) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1.0

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually // Ensures equal heights
        verticalStackView.spacing = 0
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let topContainer = UIView()
        topContainer.backgroundColor = topColor
        topContainer.translatesAutoresizingMaskIntoConstraints = false

        let bottomContainer = UIView()
        bottomContainer.backgroundColor = bottomColor
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.layer.borderColor = UIColor.blue.cgColor
        numberLabel.layer.borderWidth = 1.0
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = .darkGray
        textLabel.textAlignment = .center
        textLabel.layer.borderColor = UIColor.blue.cgColor
        textLabel.layer.borderWidth = 1.0
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        topContainer.addSubview(numberLabel)
        bottomContainer.addSubview(textLabel)

        verticalStackView.addArrangedSubview(topContainer)
        verticalStackView.addArrangedSubview(bottomContainer)
        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            //stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
            //numberLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            //numberLabel.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),

            numberLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: 12),
            
            textLabel.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor, constant: -6)
        ])

        return containerView
    }
}

*/

//STEP 4: working with border
/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(number: "14", label: "Following")
        let middleView = createContainerView(number: "38", label: "Followers")
        let rightView = createContainerView(number: "91", label: "Likes")

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(number: String, label: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.black.cgColor // Add black border
        containerView.layer.borderWidth = 1.0

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.spacing = 4
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textColor = .black

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = .darkGray

        verticalStackView.addArrangedSubview(numberLabel)
        verticalStackView.addArrangedSubview(textLabel)

        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        return containerView
    }
}

*/


//STEP 4: Doesn't work
/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(number: "14", label: "Following", alignment: .right, spacing: 12)
        let middleView = createContainerView(number: "38", label: "Followers", alignment: .center, spacing: 0)
        let rightView = createContainerView(number: "91", label: "Likes", alignment: .left, spacing: 12)

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(number: String, label: String, alignment: UIStackView.Alignment, spacing: CGFloat) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.black.cgColor // Black border
        containerView.layer.borderWidth = 1.0

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = alignment // Custom alignment
        verticalStackView.spacing = spacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textColor = .black

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = .darkGray

        let topContainer = UIView()
        topContainer.addSubview(numberLabel)
        topContainer.translatesAutoresizingMaskIntoConstraints = false

        let bottomContainer = UIView()
        bottomContainer.addSubview(textLabel)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.addArrangedSubview(topContainer)
        verticalStackView.addArrangedSubview(bottomContainer)

        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            numberLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -4), // 4 from bottom

            textLabel.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 4) // 4 from top
        ])

        return containerView
    }
}
*/


//STEP 3
/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(number: "14", label: "Following")
        let middleView = createContainerView(number: "38", label: "Followers")
        let rightView = createContainerView(number: "91", label: "Likes")

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(number: String, label: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.spacing = 4
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textColor = .black

        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = .darkGray

        verticalStackView.addArrangedSubview(numberLabel)
        verticalStackView.addArrangedSubview(textLabel)

        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        return containerView
    }
}
*/


//STEP 2
/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = createContainerView(topColor: .yellow, bottomColor: .orange)
        let middleView = createContainerView(topColor: .cyan, bottomColor: .magenta)
        let rightView = createContainerView(topColor: .green, bottomColor: .purple)

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createContainerView(topColor: UIColor, bottomColor: UIColor) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let topView = UIView()
        topView.backgroundColor = topColor

        let bottomView = UIView()
        bottomView.backgroundColor = bottomColor

        verticalStackView.addArrangedSubview(topView)
        verticalStackView.addArrangedSubview(bottomView)

        containerView.addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        return containerView
    }
}
*/

/*
class ColorStackView: UIView {

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let leftView = UIView()
        leftView.backgroundColor = .blue

        let middleView = UIView()
        middleView.backgroundColor = .red

        let rightView = UIView()
        rightView.backgroundColor = .blue

        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(rightView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

*/
