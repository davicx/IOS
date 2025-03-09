//
//  UserProfileFollowers.swift
//  Kite
//
//  Created by David Vasquez on 3/8/25.
//


import UIKit


class UserProfileFollowers: UIView {

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

        // Add to stack view
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
        let leftView = createContainerView(topColor: .white, bottomColor: .blue)

        if let topContainer = leftView.subviews.first,
           let bottomContainer = leftView.subviews.last {
            setupTopLabel(in: topContainer, text: "140", rightOffset: 2)
            setupBottomLabel(in: bottomContainer, text: "Posts", rightOffset: 2)
        }

        return leftView
    }

    private func createMiddleView() -> UIView {
        let middleView = createContainerView(topColor: .blue, bottomColor: .white)

        if let topContainer = middleView.subviews.first,
           let bottomContainer = middleView.subviews.last {
            setupTopLabel(in: topContainer, text: "22", centerX: true)
            setupBottomLabel(in: bottomContainer, text: "Events", centerX: true)
        }

        return middleView
    }

    private func createRightView() -> UIView {
        let rightView = createContainerView(topColor: .white, bottomColor: .blue)

        /*
        if let topContainer = rightView.subviews.first,
           let bottomContainer = rightView.subviews.last {
            setupTopLabel(in: topContainer, text: "12", leftOffset: 2)
            setupBottomLabel(in: bottomContainer, text: "Friends", leftOffset: 2)
        }
         */
        if let topContainer = rightView.subviews.first {
            setupTopLabel(in: topContainer, text: "12", leftOffset: 2)
        }

        if let bottomContainer = rightView.subviews.last {
            setupBottomLabel(in: bottomContainer, text: "Friends", leftOffset: 2)
        }


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

    private func setupTopLabel(in container: UIView, text: String,
                               leftOffset: CGFloat? = nil,
                               rightOffset: CGFloat? = nil,
                               centerX: Bool = false) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold) // Bigger font for top labels
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        var constraints = [NSLayoutConstraint]()
        constraints.append(label.widthAnchor.constraint(equalToConstant: 68)) // Fixed width for alignment

        if let left = leftOffset {
            constraints.append(label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: left))
        }
        if let right = rightOffset {
            constraints.append(label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -right))
        }
        if centerX {
            constraints.append(label.centerXAnchor.constraint(equalTo: container.centerXAnchor))
        }

        // Bring text down closer to the bottom of the top container
        constraints.append(label.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 8))

        NSLayoutConstraint.activate(constraints)
    }

    private func setupBottomLabel(in container: UIView, text: String,
                                  leftOffset: CGFloat? = nil,
                                  rightOffset: CGFloat? = nil,
                                  centerX: Bool = false) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular) // Smaller font for bottom labels
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        var constraints = [NSLayoutConstraint]()
        constraints.append(label.widthAnchor.constraint(equalToConstant: 68)) // Fixed width for alignment

        if let left = leftOffset {
            constraints.append(label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: left))
        }
        if let right = rightOffset {
            constraints.append(label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -right))
        }
        if centerX {
            constraints.append(label.centerXAnchor.constraint(equalTo: container.centerXAnchor))
        }

        // Bring text up closer to the top of the bottom container
        constraints.append(label.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -8))

        NSLayoutConstraint.activate(constraints)
    }
}



//WORKS
/*
class UserProfileFollowers: UIView {

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
        let leftView = createContainerView(topColor: .white, bottomColor: .blue)

        if let topContainer = leftView.subviews.first,
           let bottomContainer = leftView.subviews.last {

            addLabelToView(container: topContainer, text: "140", rightOffset: 2)
            addLabelToView(container: bottomContainer, text: "Posts", rightOffset: 2)
        }

        return leftView
    }

    private func createMiddleView() -> UIView {
        let middleView = createContainerView(topColor: .blue, bottomColor: .white)

        if let topContainer = middleView.subviews.first,
           let bottomContainer = middleView.subviews.last {

            addLabelToView(container: topContainer, text: "22", centerX: true)
            addLabelToView(container: bottomContainer, text: "Events", centerX: true)
        }

        return middleView
    }

    private func createRightView() -> UIView {
        let rightView = createContainerView(topColor: .white, bottomColor: .blue)

        if let topContainer = rightView.subviews.first,
           let bottomContainer = rightView.subviews.last {

            addLabelToView(container: topContainer, text: "12", leftOffset: 2)
            addLabelToView(container: bottomContainer, text: "Friends", leftOffset: 2)
        }

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

    private func addLabelToView(container: UIView, text: String,
                                leftOffset: CGFloat? = nil,
                                rightOffset: CGFloat? = nil,
                                centerX: Bool = false) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        var constraints = [NSLayoutConstraint]()

        // Set fixed width for alignment consistency
        constraints.append(label.widthAnchor.constraint(equalToConstant: 68))

        if let left = leftOffset {
            constraints.append(label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: left))
        }
        if let right = rightOffset {
            constraints.append(label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -right))
        }
        if centerX {
            constraints.append(label.centerXAnchor.constraint(equalTo: container.centerXAnchor))
        }

        // Adjust vertical alignment based on whether it's in the top or bottom container
        if container.superview?.subviews.first == container {
            // Align text **closer to the bottom** in the top container
            constraints.append(label.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 8))
        } else {
            // Align text **closer to the top** in the bottom container
            constraints.append(label.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -8))
        }

        NSLayoutConstraint.activate(constraints)
    }

    
    //WORKS
    /*
    private func addLabelToView(container: UIView, text: String,
                                leftOffset: CGFloat? = nil,
                                rightOffset: CGFloat? = nil,
                                centerX: Bool = false) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        var constraints = [NSLayoutConstraint]()

        // Set fixed width for alignment consistency
        constraints.append(label.widthAnchor.constraint(equalToConstant: 68))

        if let left = leftOffset {
            constraints.append(label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: left))
        }
        if let right = rightOffset {
            constraints.append(label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -right))
        }
        if centerX {
            constraints.append(label.centerXAnchor.constraint(equalTo: container.centerXAnchor))
        }

        // Center the label vertically in the container
        constraints.append(label.centerYAnchor.constraint(equalTo: container.centerYAnchor))

        NSLayoutConstraint.activate(constraints)
    }
     */
}
 */


//WORKS: text not centered
/*
class UserProfileFollowers: UIView {

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
        let leftView = createContainerView(topColor: .white, bottomColor: .blue)

        // Get top and bottom containers
        if let topContainer = leftView.subviews.first,
           let bottomContainer = leftView.subviews.last {

            addLabelToView(container: topContainer, text: "Top Left", rightOffset: 12, bottomOffset: 8)
            addLabelToView(container: bottomContainer, text: "Bottom Left", rightOffset: 12, topOffset: 8)
        }

        return leftView
    }

    private func createMiddleView() -> UIView {
        let middleView = createContainerView(topColor: .blue, bottomColor: .white)

        if let topContainer = middleView.subviews.first,
           let bottomContainer = middleView.subviews.last {

            addLabelToView(container: topContainer, text: "Middle Top", bottomOffset: 8, centerX: true)
            addLabelToView(container: bottomContainer, text: "Middle Bottom", topOffset: 8, centerX: true)
        }

        return middleView
    }

    private func createRightView() -> UIView {
        let rightView = createContainerView(topColor: .white, bottomColor: .blue)

        if let topContainer = rightView.subviews.first,
           let bottomContainer = rightView.subviews.last {

            addLabelToView(container: topContainer, text: "Top Right", leftOffset: 12, bottomOffset: 8)
            addLabelToView(container: bottomContainer, text: "Bottom Right", leftOffset: 12, topOffset: 8)
        }

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

    private func addLabelToView(container: UIView, text: String,
                                leftOffset: CGFloat? = nil,
                                rightOffset: CGFloat? = nil,
                                topOffset: CGFloat? = nil,
                                bottomOffset: CGFloat? = nil,
                                centerX: Bool = false) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)

        var constraints = [NSLayoutConstraint]()

        if let left = leftOffset {
            constraints.append(label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: left))
        }
        if let right = rightOffset {
            constraints.append(label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -right))
        }
        if let top = topOffset {
            constraints.append(label.topAnchor.constraint(equalTo: container.topAnchor, constant: top))
        }
        if let bottom = bottomOffset {
            constraints.append(label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -bottom))
        }
        if centerX {
            constraints.append(label.centerXAnchor.constraint(equalTo: container.centerXAnchor))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
*/


//WORKS
/*
class UserProfileFollowers: UIView {

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
        let leftView = createContainerView(topColor: .white, bottomColor: .blue)

        return leftView
    }

    private func createMiddleView() -> UIView {
        let middleView = createContainerView(topColor: .blue, bottomColor: .white)

        return middleView
    }

    private func createRightView() -> UIView {
        let rightView = createContainerView(topColor: .white, bottomColor: .blue)


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
    

}
*/


/*

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
