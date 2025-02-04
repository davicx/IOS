//
//  ViewController.swift
//  LearningProgrammaticLayout
//
//  Created by David Vasquez on 9/19/24.
//

import UIKit

class ViewController: UIViewController {

    let myLabel = UILabel()
    let expandingLabel = UILabel()
    let mainSquare = UIView()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFullImage()
    
    }
    
    private func createFullImage() {
        
        //STEP 1: Configure Image
        let currentImage = UIImage(named: "background_1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFit
        imageView.image = currentImage

        view.addSubview(imageView)
        
        //Step 2: Image Height
        let actualImageHeight = currentImage!.size.height
        let actualImageWidth = currentImage!.size.width
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let imageCrop = currentImage!.getCropRatio()
        
        let imageHolderHeight = Float(screenWidth / imageCrop)
        let imageHolderWidth = Float(screenWidth)
        
        print("actualImageHeight \(actualImageHeight) actualImageWidth \(actualImageWidth)")
        print("imageHeight \(imageHolderHeight) imageWidth \(imageHolderWidth)")

        //Step 3: Set up constraints
         NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageHolderHeight - 8))
         ])
    
    }
    
    
    //HEIGHT
    private func calculateImageHeight() {
        
        // Step 1: Configure the UIImageView
        let currentImage = UIImage(named: "background_1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = currentImage

        view.addSubview(imageView)
        
        //Step 2: Image Height
        let actualImageHeight = currentImage!.size.height
        let actualImageWidth = currentImage!.size.width
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let imageCrop = currentImage!.getCropRatio()
        
        let imageHeight = screenWidth / imageCrop
        let imageWidth = screenWidth
        //print("actualImageHeight \(actualImageHeight) actualImageWidth \(actualImageWidth)")
        //print("imageHeight \(imageHeight) imageWidth \(imageWidth)")

        // Step 3: Set up constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    
    private func calculateTextHeight() {
        
        //Set up Text
        let caption = "There is more in you of good than you know, child of the kindly West. Some courage and some wisdom, blended in measure. If more of us valued food and cheer and song above hoarded gold, it would be a merrier world."
        let currentFont = UIFont.systemFont(ofSize: 16)
        
        //Get Screen Size
        let screenSize: CGRect = UIScreen.main.bounds
        let labelWidth = screenSize.width - 24
        let textHeight = calculateHeightForText(caption, width: labelWidth, font: currentFont)
    
        print("textHeight \(textHeight)")
        
        //Set up Label
        expandingLabel.translatesAutoresizingMaskIntoConstraints = false
        expandingLabel.backgroundColor = .lightGray
        expandingLabel.numberOfLines = 0
        expandingLabel.text = caption
        expandingLabel.font = currentFont

        // Step 2: Add the label to the view hierarchy
        view.addSubview(expandingLabel)

        // Step 3: Set up constraints
        NSLayoutConstraint.activate([
            expandingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expandingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            expandingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }

    //TEXT LABEL
    private func createExpandingText() {
        let caption = "There is more in you of good than you know, child of the kindly West. Some courage and some wisdom, blended in measure. If more of us valued food and cheer and song above hoarded gold, it would be a merrier world."
        let currentFont = UIFont.systemFont(ofSize: 16)
        
        expandingLabel.translatesAutoresizingMaskIntoConstraints = false
        expandingLabel.backgroundColor = .lightGray
        expandingLabel.numberOfLines = 0
        expandingLabel.text = caption
        expandingLabel.font = currentFont

        
        // Step 2: Add the label to the view hierarchy
        view.addSubview(expandingLabel)

        // Step 3: Set up constraints
        NSLayoutConstraint.activate([
            expandingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expandingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            expandingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
    func createCenteredLabel() {
        myLabel.text = "Centered Label"
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .blue
     
        view.addSubview(myLabel)

        myLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myLabel.widthAnchor.constraint(equalToConstant: 220),
            myLabel.heightAnchor.constraint(equalToConstant: 50)

        ])

    }
    
    
    //IMAGE
    private func createImage() {
        // Step 1: Configure the UIImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "background_1")

        // Step 2: Add the image view to the view hierarchy
        view.addSubview(imageView)

        // Step 3: Set up constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func createImages() {
        
        //IMAGE 1
        // Create a UIImageView
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        
        // Set the frame or constraints
        imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        
        // Set the image from the assets folder
        imageView.image = UIImage(named: "background_1")
       
        // Content mode
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        //IMAGE 2
        let imageView2 = UIImageView()
        imageView2.backgroundColor = .blue
        imageView2.frame = CGRect(x: 50, y: 300, width: 200, height: 200)
        imageView2.image = UIImage(named: "background_2")
        imageView2.contentMode = .scaleAspectFit
        view.addSubview(imageView2)

        //IMAGE 3
        let imageView3 = UIImageView()
        imageView3.backgroundColor = .blue
        imageView3.frame = CGRect(x: 50, y: 600, width: 200, height: 200)
        imageView3.image = UIImage(named: "background_3")
        imageView3.contentMode = .scaleToFill
        view.addSubview(imageView3)
        
    }
    
    
    //VIEWS
    func createLargeSquare() {
        mainSquare.translatesAutoresizingMaskIntoConstraints = false
        mainSquare.backgroundColor = .lightGray
        view.addSubview(mainSquare)
        
        //Pin to Top
        NSLayoutConstraint.activate([
            mainSquare.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40), // Pin to top with a 20-point margin
            mainSquare.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Optional: pin to left
            mainSquare.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Optional: pin to right
            mainSquare.heightAnchor.constraint(equalTo: mainSquare.widthAnchor) // Keep it a square
        ])

        //Center Square
        /*
        NSLayoutConstraint.activate([
            mainSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainSquare.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            mainSquare.heightAnchor.constraint(equalTo: mainSquare.widthAnchor) // make it a square
        ])
         */

    }
    
    func createFourSquare() {
        // Create the main square view

        mainSquare.translatesAutoresizingMaskIntoConstraints = false
        mainSquare.backgroundColor = .lightGray
        view.addSubview(mainSquare)
        
        // Constraints for the main square (pinned to the top)
        NSLayoutConstraint.activate([
            mainSquare.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainSquare.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainSquare.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainSquare.heightAnchor.constraint(equalTo: mainSquare.widthAnchor) // Keep it a square
        ])
        
        // Create four subviews
        let colors: [UIColor] = [.red, .green, .blue, .yellow]
        var subviews: [UIView] = []
        
        for color in colors {
            let square = UIView()
            square.translatesAutoresizingMaskIntoConstraints = false
            square.backgroundColor = color
            mainSquare.addSubview(square)
            subviews.append(square)
        }

        // Set constraints for the subviews
        NSLayoutConstraint.activate([
            // Top left
            subviews[0].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[0].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[0].widthAnchor.constraint(equalTo: mainSquare.widthAnchor, multiplier: 0.5),
            subviews[0].heightAnchor.constraint(equalTo: subviews[0].widthAnchor),
            
            // Top right
            subviews[1].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[1].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[1].widthAnchor.constraint(equalTo: mainSquare.widthAnchor, multiplier: 0.5),
            subviews[1].heightAnchor.constraint(equalTo: subviews[1].widthAnchor),

            // Bottom left
            subviews[2].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[2].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[2].widthAnchor.constraint(equalTo: mainSquare.widthAnchor, multiplier: 0.5),
            subviews[2].heightAnchor.constraint(equalTo: subviews[2].widthAnchor),

            // Bottom right
            subviews[3].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[3].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[3].widthAnchor.constraint(equalTo: mainSquare.widthAnchor, multiplier: 0.5),
            subviews[3].heightAnchor.constraint(equalTo: subviews[3].widthAnchor),
        ])
  
    }

    //FUNCTIONS
    func calculateHeightForText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let textRect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return textRect.height
    }
    

}


extension UIImage {
    func getCropRatio () -> CGFloat {
        let widthRatio = CGFloat (self.size.width / self.size.height)
        return widthRatio
    }
}
