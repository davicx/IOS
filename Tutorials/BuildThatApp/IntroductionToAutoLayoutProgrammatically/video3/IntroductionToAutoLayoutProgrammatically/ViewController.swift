//
//  ViewController.swift
//  IntroductionToAutoLayoutProgrammatically
//
//  Created by David Vasquez on 9/13/24.
//




import UIKit


class ViewController: UIViewController {
   
    //IMAGE
    let loadImageView: UIImageView = {
        let image = UIImage(named: "background_1")
        let imageView = UIImageView(image: image)
        // this enables autolayout for our imageView
        //Get Image Size
   
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //BUTTON
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    
    //TEXT
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
      attributedText.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray ]))
            
            textView.attributedText = attributedText
           
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBottomControls()
        //setupStackView()
        
        
    }
    
    
    fileprivate func setupBottomControls() {
        view.addSubview(previousButton)

        view.addSubview(nextButton)
        //previousButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        //previousButton.backgroundColor = .red
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
 
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            //previousButton.topAnchor.constraint(equalTo: view.topAnchor),
            //previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
  
    
    private func setupLayout() {
        let imageView = loadImageView
        
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        view.addSubview(descriptionTextView)
        
        //topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //TYPE 1: Half of top view
        //topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        //topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        //topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //TYPE 2: Half of top view
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //IMAGE
        topImageContainerView.addSubview(imageView)
        let image = UIImage(named: "background_1")
        let currentImageHeight = image!.size.height
        let currentImageWidth = image!.size.width
       
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: currentImageWidth / 4).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: currentImageHeight / 4).isActive = true
        
        //TEXT
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }
    
    
    fileprivate func setupStackView() {
        //view.addSubview(previousButton)
        //previousButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        previousButton.backgroundColor = .red
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [yellowView, greenView, blueView])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            //previousButton.topAnchor.constraint(equalTo: view.topAnchor),
            //previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
  


}

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}


//VIDEO 3 Notes
/*
 private let previousButton: UIButton = {
     let button = UIButton(type: .system)
     button.setTitle("PREV", for: .normal)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
     button.setTitleColor(.gray, for: .normal)
     return button
 }()
 
 private let nextButton: UIButton = {
     let button = UIButton(type: .system)
     button.setTitle("NEXT", for: .normal)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
     button.setTitleColor(.mainPink, for: .normal)
     return button
 }()
 */

//CODE

/*
 //
 //  ViewController.swift
 //  autolayout_lbta
 //
 //  Created by Brian Voong on 9/25/17.
 //  Copyright © 2017 Lets Build That App. All rights reserved.
 //

 import UIKit

 class ViewController: UIViewController {

     // let's avoid polluting viewDidLoad
     // {} is referred to as closure, or anon. functions
     let bearImageView: UIImageView = {
         let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
         // this enables autolayout for our imageView
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     let descriptionTextView: UITextView = {
         let textView = UITextView()
         textView.text = "Join us today in our fun and games!"
         textView.font = UIFont.boldSystemFont(ofSize: 18)
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.textAlignment = .center
         textView.isEditable = false
         textView.isScrollEnabled = false
         return textView
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // here's our entry point into our app
         view.addSubview(bearImageView)
         view.addSubview(descriptionTextView)
         
         setupLayout()
     }
     
     private func setupLayout() {
         bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
         bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
         bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
         
         descriptionTextView.topAnchor.constraint(equalTo: bearImageView.bottomAnchor, constant: 120).isActive = true
         descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
         descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
     }

 }

 */


//VIDEO 1
//topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//topImageContainerView.addSubview(bearImageView)

/*
let imageView = loadImageView
//imageView.contentMode = .scaleAspectFit
view.addSubview(imageView)

//Get Screen Size
let screenSize: CGRect = UIScreen.main.bounds
let screenHeight = screenSize.height
let screenWidth = screenSize.width
print("SCREEN: \(screenHeight) \(screenWidth)")


//POSITION:
//Image Size
let image = UIImage(named: "background_1")

// this enables autolayout for our imageView
//Get Image Size
let currentImageHeight = image!.size.height
let currentImageWidth = image!.size.width

//Set By Hand
//imageView.frame = CGRect(x: 10, y: 100, width: currentImageWidth / 3, height: currentImageHeight / 3)

//Set with contstraints
//Enable autolayout for imageview
imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

imageView.widthAnchor.constraint(equalToConstant: currentImageWidth / 4).isActive = true
imageView.heightAnchor.constraint(equalToConstant: currentImageHeight / 4).isActive = true


//TEXT
view.addSubview(descriptionTextView)
descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60).isActive = true
descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0).isActive = true
descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:0).isActive = true
descriptionTextView.backgroundColor = .blue
 */


//SIMPLE 1:
/*
 import UIKit

 class ViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         
         //BACKGROUND
         //view.backgroundColor = .green
         
         
         //IMAGE
         let image = UIImage(named: "background_1")
         
         //Get Screen Size
         let screenSize: CGRect = UIScreen.main.bounds
         let screenHeight = screenSize.height
         let screenWidth = screenSize.width
         print("SCREEN: \(screenHeight) \(screenWidth)")
         
         
         //Get Image Size
         let currentImageHeight = image!.size.height
         let currentImageWidth = image!.size.width
         
         print("IMAGE \(currentImageHeight) \(currentImageWidth)")
         
         //Set and Position Image View
         let imageView = UIImageView(image: image)
         view.addSubview(imageView)
         
         //Set By Hand
         //imageView.frame = CGRect(x: 10, y: 100, width: currentImageWidth / 3, height: currentImageHeight / 3)
         
         //Set with contstraints
         //Enable autolayout for imageview
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         //imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
         
         imageView.widthAnchor.constraint(equalToConstant: currentImageWidth / 3).isActive = true
         imageView.heightAnchor.constraint(equalToConstant: currentImageHeight / 3).isActive = true
         
     }
     
     
     private func setupLayout() {
         
     }


 }
 */


//VIDEO 1:
/*
 //
 //  ViewController.swift
 //  IntroductionToAutoLayoutProgrammatically
 //
 //  Created by David Vasquez on 9/13/24.
 //




 import UIKit


 class ViewController: UIViewController {
    
     //IMAGE
     let loadImageView: UIImageView = {
         let image = UIImage(named: "background_1")
         let imageView = UIImageView(image: image)
         // this enables autolayout for our imageView
         //Get Image Size
    
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     //TEXT
     let descriptionTextView: UITextView = {
         let textView = UITextView()
         textView.text = "Hiya sam wanna garden!"
         textView.font = UIFont.boldSystemFont(ofSize: 18)
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.textAlignment = .center
         textView.isEditable = false
         textView.isScrollEnabled = false
         return textView
     }()
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         setupLayout()
         
         
     }
     
   
     
     private func setupLayout() {
         let imageView = loadImageView
         //imageView.contentMode = .scaleAspectFit
         view.addSubview(imageView)
         
         //Get Screen Size
         let screenSize: CGRect = UIScreen.main.bounds
         let screenHeight = screenSize.height
         let screenWidth = screenSize.width
         print("SCREEN: \(screenHeight) \(screenWidth)")
         
         
         //POSITION:
         //Image Size
         let image = UIImage(named: "background_1")

         // this enables autolayout for our imageView
         //Get Image Size
         let currentImageHeight = image!.size.height
         let currentImageWidth = image!.size.width
         
         print("IMAGE \(currentImageHeight) \(currentImageWidth)")
         
         
         //Set By Hand
         //imageView.frame = CGRect(x: 10, y: 100, width: currentImageWidth / 3, height: currentImageHeight / 3)
         
         //Set with contstraints
         //Enable autolayout for imageview
         imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         //imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
         
         imageView.widthAnchor.constraint(equalToConstant: currentImageWidth / 4).isActive = true
         imageView.heightAnchor.constraint(equalToConstant: currentImageHeight / 4).isActive = true
         
         
         //TEXT
         view.addSubview(descriptionTextView)
         descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60).isActive = true
         descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0).isActive = true
         descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:0).isActive = true
         //descriptionTextView.heightAnchor.constraint(equalTo: 20, multiplier: 1)
         //descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
         descriptionTextView.backgroundColor = .blue
     }


 }

 */
