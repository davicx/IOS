//
//  MainSearchVC.swift
//  Kite
//
//  Created by David Vasquez on 9/15/25.
//

import UIKit

class SearchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search"
        
        // Ensure proper navigation bar setup
        navigationItem.largeTitleDisplayMode = .never
        
        setupUI()
    }
    
    private func setupUI() {
        // Add a simple label to show the search view is working
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search View"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
