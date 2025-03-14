//
//  ViewController.swift
//  Design
//
//  Created by Syngenta on 10/16/21.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        var previousView: UIView?
        
        // 1) Single Blue View
        let blueView = createView(color: .blue)
        contentView.addSubview(blueView)
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            blueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            blueView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            blueView.heightAnchor.constraint(equalToConstant: 80)
        ])
        previousView = blueView
        
        // 2) Three Side-by-Side Views
        let stackView1 = UIStackView()
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.spacing = 5
        
        let redView = createView(color: .blue)
        let greenView = createView(color: .gray)
        let yellowView = createView(color: .blue)
        
        stackView1.addArrangedSubview(redView)
        stackView1.addArrangedSubview(greenView)
        stackView1.addArrangedSubview(yellowView)
        
        contentView.addSubview(stackView1)
        NSLayoutConstraint.activate([
            stackView1.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 20),
            stackView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView1.heightAnchor.constraint(equalToConstant: 80)
        ])
        previousView = stackView1
        
        // 3) Horizontal StackView with 2 Cells
        let stackView2 = UIStackView()
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        
        let leftView = createView(color: .gray)
        let rightView = createView(color: .blue)
        
        stackView2.addArrangedSubview(leftView)
        stackView2.addArrangedSubview(rightView)
        
        contentView.addSubview(stackView2)
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView2.heightAnchor.constraint(equalToConstant: 80),
            
            leftView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            rightView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
        previousView = stackView2
        
        // 4) Two Views, Left Fixed Width, Right Fills
        let leftFixedView = createView(color: .blue)
        let rightFillingView = createView(color: .gray)
        
        contentView.addSubview(leftFixedView)
        contentView.addSubview(rightFillingView)
        
        NSLayoutConstraint.activate([
            leftFixedView.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 20),
            leftFixedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftFixedView.widthAnchor.constraint(equalToConstant: 80),
            leftFixedView.heightAnchor.constraint(equalToConstant: 80),
            
            rightFillingView.topAnchor.constraint(equalTo: leftFixedView.topAnchor),
            rightFillingView.leadingAnchor.constraint(equalTo: leftFixedView.trailingAnchor),
            rightFillingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightFillingView.heightAnchor.constraint(equalToConstant: 80)
        ])
        previousView = rightFillingView
        
        // 5) Centered View with Label (Bottom Aligned)
        let centeredView = createView(color: .lightGray, width: 200, height: 80)
        contentView.addSubview(centeredView)
        
        NSLayoutConstraint.activate([
            centeredView.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 20),
            centeredView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        let label1 = createLabel(text: "Bottom Label", color: .white)
        centeredView.addSubview(label1)
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: centeredView.centerXAnchor),
            label1.widthAnchor.constraint(equalToConstant: 120),
            label1.heightAnchor.constraint(equalToConstant: 40),
            label1.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: -12)
        ])
        previousView = centeredView
        
        // 6) Centered View with Right-Aligned Label
        let centeredView2 = createView(color: .gray, width: 200, height: 80)
        contentView.addSubview(centeredView2)
        
        NSLayoutConstraint.activate([
            centeredView2.topAnchor.constraint(equalTo: previousView!.bottomAnchor, constant: 20),
            centeredView2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        let label2 = createLabel(text: "Right Label", color: .black)
        centeredView2.addSubview(label2)
        NSLayoutConstraint.activate([
            //label2.trailingAnchor.constraint(equalTo: centeredView2.trailingAnchor, constant: -20),
            label2.trailingAnchor.constraint(equalTo: centeredView2.trailingAnchor, constant: 0),
            label2.widthAnchor.constraint(equalToConstant: 120),
            label2.heightAnchor.constraint(equalToConstant: 40),
            label2.centerYAnchor.constraint(equalTo: centeredView2.centerYAnchor)
        ])
        previousView = centeredView2
        
        // Set final bottom constraint for scroll view
        NSLayoutConstraint.activate([
            previousView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createView(color: UIColor, width: CGFloat? = nil, height: CGFloat? = nil) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return view
    }
    
    private func createLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = color
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
*/
