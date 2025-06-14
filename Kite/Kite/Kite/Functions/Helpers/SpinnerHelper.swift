//
//  SpinnerHelper.swift
//  Kite
//
//  Created by David Vasquez on 5/14/25.
//


import UIKit


final class SpinnerHelper {
    private var spinner: UIActivityIndicatorView?
    private var workItem: DispatchWorkItem?

    func show(in view: UIView, delay: TimeInterval = 0.5) {
        hide() // Clear any existing spinner or pending show

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

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

        self.workItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    func hide() {
        workItem?.cancel()
        workItem = nil

        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil
    }
}

//WORKS
/*
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
*/
