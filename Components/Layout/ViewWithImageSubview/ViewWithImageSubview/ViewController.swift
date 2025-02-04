//
//  ViewController.swift
//  ViewWithImageSubview
//
//  Created by David Vasquez on 10/7/24.
//

import UIKit


class ViewController: UIViewController {

    var imageView: UIImageView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a container UIView with blue background
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .blue
        view.addSubview(containerView)

        // Create and configure the UIImageView
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        // Load the image (replace "exampleImage" with your actual image name)
        if let image = UIImage(named: "background_1") {
            imageView.image = image
            containerView.addSubview(imageView)

            // Get the image aspect ratio
            let aspectRatio = getImageRatio(image: image)
            
            // Add constraints for the containerView (blue border)
            NSLayoutConstraint.activate([
                // Make containerView as wide as the screen with some margin (optional)
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100), // example padding from top
                
                // Set the container's height based on the aspect ratio and padding
                containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: aspectRatio)
            ])

            // Add constraints for the imageView (with 4-point padding inside containerView)
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
            ])
        }
    }
    
    // Function to get the image aspect ratio (height / width)
    func getImageRatio(image: UIImage) -> CGFloat {
        return image.size.height / image.size.width
    }
}





//WORKING 1: No outer image
/*
class ViewController: UIViewController {
    var currentImage = UIImage(named: "background_1")
    
    lazy var currentImageView: UIImageView = {
        guard let currentImage = currentImage else { return UIImageView() }
        return createImageView(image: currentImage)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    
    private func getImageHeight(image: UIImage) -> CGFloat {
        let aspectRatio = image.size.height / image.size.width
        //let originalImageHeight = image.size.height
        //let originalImageWidth = image.size.width

        let newImageHeight = UIScreen.main.bounds.width * aspectRatio
        //let newImageWidth = UIScreen.main.bounds.width
        
        return newImageHeight
    }
    

    private func setupViews() {
        view.addSubview(currentImageView)
        
        // Set up Auto Layout constraints programmatically
        currentImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageHeight = getImageHeight(image: currentImage!)

        
        NSLayoutConstraint.activate([
            currentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50), // optional padding from top
            currentImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
    }
    
}


private func createImageView(image: UIImage) -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .blue
    imageView.image = image
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    
    return imageView
}*/

