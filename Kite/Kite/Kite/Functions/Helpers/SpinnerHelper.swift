//
//  SpinnerHelper.swift
//  Kite
//
//  Created by David Vasquez on 5/14/25.
//


import UIKit


final class SpinnerHelper {
    private var spinner: UIActivityIndicatorView?
    private var backgroundView: UIView?
    private var workItem: DispatchWorkItem?

    /// Key window for centering spinner on screen. Use with `show(in: Self.keyWindow ?? fallbackView, delay: 0)`.
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }
    }

    func show(in view: UIView, delay: TimeInterval = 0.5) {
        hide() // Clear any existing spinner or pending show

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            // Create background view with semi-transparent dark color
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(backgroundView)

            // Create spinner
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.color = .white // Make spinner white for better contrast
            spinner.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview(spinner)

            NSLayoutConstraint.activate([
                // Background view covers the entire parent view
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                // Spinner is centered in the background view
                spinner.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])

            spinner.startAnimating()
            self.spinner = spinner
            self.backgroundView = backgroundView
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
        
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
}


//WORKS FIRST ONE
/*
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

*/

/*
 
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
 */

// ORIGINAL IMPLEMENTATION (commented out for easy reversion)
/*
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
 */
