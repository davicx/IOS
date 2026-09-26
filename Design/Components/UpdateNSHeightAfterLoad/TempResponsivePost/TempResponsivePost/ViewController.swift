//
//  ViewController.swift
//  TempResponsivePost
//
//  Created by David Vasquez on 10/13/24.
//

import UIKit


class ViewController: UIViewController {
    
    // The view that will have its height updated
    let dynamicView = UIView()
    
    
    // A reference to the height constraint
    var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the dynamic view
        dynamicView.translatesAutoresizingMaskIntoConstraints = false
        dynamicView.backgroundColor = .blue
        view.addSubview(dynamicView)
        
        // Add initial constraints
        NSLayoutConstraint.activate([
            dynamicView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dynamicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dynamicView.widthAnchor.constraint(equalToConstant: 200),
            // Temporary height constraint, will be updated later
        ])
        
        // Create and store the height constraint
        heightConstraint = dynamicView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        heightConstraint?.isActive = true
        
        self.fetchHeightFromAPI()
    }
    
    // Function to update the height dynamically
    func updateHeight(to newHeight: CGFloat) {
        // Update the height constraint constant
        heightConstraint?.constant = newHeight
        
        // Animate the height change if needed
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Simulate API call response
    func fetchHeightFromAPI() {
        // Simulate an API call that provides height data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // Example: Update height to 300 after API response
            let newHeight: CGFloat = 500
            self?.updateHeight(to: newHeight)
        }
    }
}


/*
 
class ViewController: UIViewController {

    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        fetchImage()
    }

    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Maintain aspect ratio
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5625) // Aspect ratio for 16:9
            //imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: getImageAspectRatio(image: imageView.image))
        ])
    }
    

    private func fetchImage() {
        // Simulating an API call with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Fetch the image from assets
            //if let image = UIImage(named: "background_1") {
            if let image = UIImage(named: "tall") {
            //if let image = UIImage(named: "long") {
                self.imageView.image = image
                self.updateImageViewHeight(for: image)
            }
        }
    }

    private func updateImageViewHeight(for image: UIImage) {
        // Calculate the aspect ratio
        let aspectRatio = image.size.height / image.size.width
        let newHeight = view.frame.width * aspectRatio

        // Update the height constraint
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: newHeight)
        ])
        
        // This will animate the layout change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func getImageAspectRatio(image: UIImage?) -> CGFloat {
     guard let image = image else { return 1.0 }
     return image.size.height / image.size.width
    }
}

*/
//FROM API (Maybe work?)
/*
class ImageViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        fetchImage()
    }
    
    private func setupImageView() {
        // Add imageView to the view
        view.addSubview(imageView)
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set initial constraints
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) // Aspect ratio constraint
        ])
    }
    
    private func fetchImage() {
        // Example URL for the image
        let imageUrl = URL(string: "https://example.com/background_1.png")!
        
        // Fetch the image
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching image: \(String(describing: error))")
                return
            }
            
            // Set the image on the main thread
            DispatchQueue.main.async { [weak self] in
                if let image = UIImage(data: data) {
                    self?.imageView.image = image
                    self?.updateImageViewAspectRatio(with: image)
                }
            }
        }.resume()
    }
    
    private func updateImageViewAspectRatio(with image: UIImage) {
        let aspectRatio = image.size.width / image.size.height
        
        // Remove the previous height constraint if needed
        if let heightConstraint = imageView.constraints.first(where: { $0.firstAttribute == .height }) {
            imageView.removeConstraint(heightConstraint)
        }
        
        // Create a new height constraint based on the aspect ratio
        let newHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aspectRatio)
        newHeightConstraint.isActive = true
        
        // Update the layout
        view.layoutIfNeeded()
    }
}

*/

//WORKING: Image
/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the UIImageView
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // Maintains the aspect ratio of the image
        imageView.image = UIImage(named: "background_1")
        
        // Add the imageView to the view
        view.addSubview(imageView)
        
        // Set the layout constraints
        NSLayoutConstraint.activate([
            // Make the imageView as wide as the screen
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Set the imageView's top constraint
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            // Set the aspect ratio constraint
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: getImageAspectRatio(image: imageView.image))
        ])
    }

    // Helper function to calculate the aspect ratio of the image
    func getImageAspectRatio(image: UIImage?) -> CGFloat {
        guard let image = image else { return 1.0 }
        return image.size.height / image.size.width
    }
}
*/

/*
class ViewController: UIViewController {
    
    // The view that will have its height updated
    let dynamicView = UIView()
    
    
    // A reference to the height constraint
    var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the dynamic view
        dynamicView.translatesAutoresizingMaskIntoConstraints = false
        dynamicView.backgroundColor = .blue
        view.addSubview(dynamicView)
        
        // Add initial constraints
        NSLayoutConstraint.activate([
            dynamicView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dynamicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dynamicView.widthAnchor.constraint(equalToConstant: 200),
            // Temporary height constraint, will be updated later
        ])
        
        // Create and store the height constraint
        heightConstraint = dynamicView.heightAnchor.constraint(equalToConstant: 100)  // Initial height
        heightConstraint?.isActive = true
        
        self.fetchHeightFromAPI()
    }
    
    // Function to update the height dynamically
    func updateHeight(to newHeight: CGFloat) {
        // Update the height constraint constant
        heightConstraint?.constant = newHeight
        
        // Animate the height change if needed
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Simulate API call response
    func fetchHeightFromAPI() {
        // Simulate an API call that provides height data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // Example: Update height to 300 after API response
            let newHeight: CGFloat = 500
            self?.updateHeight(to: newHeight)
        }
    }
}



*/
