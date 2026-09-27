//
//  SimpleBottomStackView.swift
//  Kite
//
//  Created by David Vasquez on 3/11/25.
//

import UIKit


class SimpleBottomStackView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let topLabel = createLabel(text: "Top Label", backgroundColor: .blue)
        let bottomLabel = createLabel(text: "Bottom Label", backgroundColor: .green)
        
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bottomLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createLabel(text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = backgroundColor
        return label
    }
}
