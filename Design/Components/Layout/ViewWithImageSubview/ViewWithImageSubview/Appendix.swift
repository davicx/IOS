//
//  Appendix.swift
//  ViewWithImageSubview
//
//  Created by David Vasquez on 10/8/24.
//

import Foundation



//EXAMPLE 2 SHOULD WORK

/*
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
         if let image = UIImage(named: "exampleImage") {
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


 */


//
//  ViewController.swift
//  ViewWithImageSubview
//
//  Created by David Vasquez on 10/7/24.
//

/*
import UIKit


class ViewController: UIViewController {
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UIImageView
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        // Load the image (replace "exampleImage" with your actual image name)
        if let image = UIImage(named: "long") {
            imageView.image = image
            view.addSubview(imageView)
            
            // Set up Auto Layout constraints programmatically
            let aspectRatio = getImageRatio(image: image)
            
            NSLayoutConstraint.activate([
                // Set the image view width to be the same as the view's width
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                // Set the top anchor to the top of the view (you can modify this if needed)
                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80), // optional padding from top
                
                // Set the height based on the aspect ratio
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio)
            ])
        }
    }
    
    private func setupLayout() {
        print("setupLayout")
    }
    
    
    
    // Function to get the image aspect ratio (height / width)
    func getImageRatio(image: UIImage) -> CGFloat {
        return image.size.height / image.size.width
    }
    
    
}

func createProfileImageView() -> UIImageView {
    let imageView = UIImageView()
    //imageView.backgroundColor = .blue
    imageView.image = UIImage(named: "background_1")
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    return imageView
}

func createBioTextView() -> UITextView {
    let textView = UITextView()
    textView.text = "Wanna go to the garden?!!"
    textView.font = UIFont.systemFont(ofSize: 15)
    textView.backgroundColor = .clear
    //textView.backgroundColor = .red
    return textView
}
    
    //ORIGINAL

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentImage = UIImage(named: "tall")!


    
        printImageSize(currentImage: currentImage)
        
    }
    
    
    
    
    

    private func getImageHeight(UIImage currentImage) -> CGRect  {
       print("setupLayout")
        
       return image.size.height / image.size.width
    }
     */
    




/*
 import UIKit

 class ViewController: UIViewController {

     var imageView: UIImageView!

     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Initialize the UIImageView
         imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         
         // Load the image (replace "exampleImage" with your actual image name)
         if let image = UIImage(named: "exampleImage") {
             imageView.image = image
             view.addSubview(imageView)
             
             // Set up Auto Layout constraints programmatically
             let aspectRatio = getImageRatio(image: image)
             
             NSLayoutConstraint.activate([
                 // Set the image view width to be the same as the view's width
                 imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 
                 // Set the top anchor to the top of the view (you can modify this if needed)
                 imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50), // optional padding from top
                 
                 // Set the height based on the aspect ratio
                 imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio)
             ])
         }
     }
     
     // Function to get the image aspect ratio (height / width)
     func getImageRatio(image: UIImage) -> CGFloat {
         return image.size.height / image.size.width
     }
 }


 */





/*
 
 private func setupLayout() {
     // Add the custom view to the main view
     view.addSubview(customView)
     customView.translatesAutoresizingMaskIntoConstraints = false
     
     // Set constraints for custom view
     NSLayoutConstraint.activate([
         customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
         customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
     ])
     
     // Add the label to the custom view
     customView.addSubview(label)
     label.translatesAutoresizingMaskIntoConstraints = false
     
     // Set constraints for the label
     NSLayoutConstraint.activate([
         label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20), // Padding from the left
         label.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20), // Padding from the right
         label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20), // Padding from the top
         label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20) // Padding from the bottom
     ])
 }
 
 private func updateLabel(with text: String) {
     label.text = text
     
     // Calculate the height of the label based on the text
     let labelWidth = view.frame.width - 40 // Adjust for padding
     let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
     let estimatedSize = label.sizeThatFits(maxSize)
     //print("estimatedSize \(estimatedSize)")
     
     // Update the custom view height constraint
     customView.heightAnchor.constraint(equalToConstant: estimatedSize.height + 40).isActive = true
     
     // Animate layout changes
     UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
     }
 }
 private let customView: UIView = {
     let view = UIView()
     view.backgroundColor = .lightGray // Set background color
     return view
 }()
 
 private let label: UILabel = {
     let label = UILabel()
     label.font = UIFont.systemFont(ofSize: 16) // Font size
     label.textAlignment = .center // Center text
     label.numberOfLines = 0 // Allow multiple lines
     //label.backgroundColor = .white
     return label
 }()
 

 
 //HEADER
 private let imageView: UIImageView = {
     let imageView = UIImageView()
     imageView.contentMode = .scaleAspectFit
     imageView.backgroundColor = .white
     return imageView

 }()
  
  let aspectRatio = currentImage.size.height / currentImage.size.width
  let newHeight = UIScreen.main.bounds.width * aspectRatio
  */

 
