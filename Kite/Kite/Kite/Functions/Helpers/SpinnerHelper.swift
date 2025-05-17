//
//  SpinnerHelper.swift
//  Kite
//
//  Created by David Vasquez on 5/14/25.
//


import UIKit


final class SpinnerHelper {
    private var spinner: UIActivityIndicatorView?

    func show(in view: UIView) {
        hide() // Ensure no duplicate spinners
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        spinner.startAnimating()
        self.spinner = spinner
    }

    func hide() {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil
    }
}
