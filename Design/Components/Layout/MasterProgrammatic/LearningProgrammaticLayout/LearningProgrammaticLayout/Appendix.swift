//
//  Appendix.swift
//  LearningProgrammaticLayout
//
//  Created by David Vasquez on 9/21/24.
//

import Foundation

/*
 import UIKit

 class SquareViewController: UIViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Create the main square view
         let mainSquare = UIView()
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
 }


 */

/*
import UIKit

class SquareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the main square view
        let mainSquare = UIView()
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
        let subviewWidth = mainSquare.widthAnchor.constraint(equalTo: mainSquare.heightAnchor, multiplier: 0.5)

        NSLayoutConstraint.activate([
            // Top left
            subviews[0].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[0].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[0].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[0].heightAnchor.constraint(equalTo: subviews[0].widthAnchor),
            
            // Top right
            subviews[1].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[1].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[1].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[1].heightAnchor.constraint(equalTo: subviews[1].widthAnchor),

            // Bottom left
            subviews[2].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[2].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[2].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[2].heightAnchor.constraint(equalTo: subviews[2].widthAnchor),

            // Bottom right
            subviews[3].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[3].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[3].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[3].heightAnchor.constraint(equalTo: subviews[3].widthAnchor),
        ])
    }
}
 */


/*
import UIKit

class SquareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the main square view
        let mainSquare = UIView()
        mainSquare.translatesAutoresizingMaskIntoConstraints = false
        mainSquare.backgroundColor = .lightGray
        view.addSubview(mainSquare)
        
        // Constraints for the main square
        NSLayoutConstraint.activate([
            mainSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainSquare.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            mainSquare.heightAnchor.constraint(equalTo: mainSquare.widthAnchor) // make it a square
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
        let gridSize = 2 // 2x2 grid
        let subviewWidth = mainSquare.widthAnchor.constraint(equalTo: mainSquare.heightAnchor, multiplier: 0.5) // 50% width of main square

        NSLayoutConstraint.activate([
            subviews[0].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[0].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[0].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[0].heightAnchor.constraint(equalTo: subviews[0].widthAnchor),
            
            subviews[1].topAnchor.constraint(equalTo: mainSquare.topAnchor),
            subviews[1].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[1].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[1].heightAnchor.constraint(equalTo: subviews[1].widthAnchor),

            subviews[2].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[2].leadingAnchor.constraint(equalTo: mainSquare.leadingAnchor),
            subviews[2].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[2].heightAnchor.constraint(equalTo: subviews[2].widthAnchor),

            subviews[3].bottomAnchor.constraint(equalTo: mainSquare.bottomAnchor),
            subviews[3].trailingAnchor.constraint(equalTo: mainSquare.trailingAnchor),
            subviews[3].widthAnchor.constraint(equalTo: subviewWidth),
            subviews[3].heightAnchor.constraint(equalTo: subviews[3].widthAnchor),
        ])
    }
}

*/

//APPENDIX
/*
func createCenteredLabelOLD() {
    myLabel.text = "Centered Label"
    myLabel.textAlignment = .center
    myLabel.backgroundColor = .blue
 
    view.addSubview(myLabel)

    myLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Center the label in the view
    NSLayoutConstraint.activate([
        myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        myLabel.widthAnchor.constraint(equalToConstant: 220),
        myLabel.heightAnchor.constraint(equalToConstant: 50)

    ])
    
    //myLabel.translatesAutoresizingMaskIntoConstraints = false
    //view.addSubview(myLabel)
    //myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    //myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    //myLabel.heightAnchor.constraint(equalToConstant: 50)
    //myLabel.widthAnchor.constraint(equalToConstant: 50)
    
    //myLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    //videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
    //videoImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
    //videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier:16/9).isActive = true
}


 let someView = UIView()
 someView.backgroundColor = .red
 someView.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(someView)
 NSLayoutConstraint.activate([
     someView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     someView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     someView.heightAnchor.constraint(equalToConstant: 50),
     someView.widthAnchor.constraint(equalToConstant: 50)
 ])
 
 super.viewDidLoad()
 translatesAutoresizingMaskIntoConstraints = false
 topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
 leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
 trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
 bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true


 let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
 label.center = CGPoint(x: 160, y: 285)
 label.textAlignment = .center
 label.text = "I'm a test label"

 self.view.addSubview(label)
 */
/*
 
//Leading = Left
//Trailing = Right (This must be negative)
func setImageConstraints () {
    videoImageView.translatesAutoresizingMaskIntoConstraints = false
    videoImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
    videoImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
    videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier:16/9).isActive = true
}

func setTitleLabelConstraints () {
    videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    videoTitleLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    //Pin This to the image
    videoTitleLabel.leadingAnchor.constraint(equalTo:videoImageView.trailingAnchor,constant:20).isActive = true
    videoTitleLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
    videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
}
 */

