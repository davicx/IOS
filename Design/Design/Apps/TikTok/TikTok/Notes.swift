//
//  Notes.swift
//  TikTok
//
//  Created by David Vasquez on 11/30/24.
//

import Foundation



/*

func setupSingleView() {
    // Create two views
    let view1 = UIView()
    let view2 = UIView()
    
    // Set background colors for the views
    view1.backgroundColor = UIColor.systemBlue
    view2.backgroundColor = UIColor.systemGreen
    
    // Add the views to the main view
    view.addSubview(view1)
    view.addSubview(view2)
    
    // Disable autoresizing masks for Auto Layout
    view1.translatesAutoresizingMaskIntoConstraints = false
    view2.translatesAutoresizingMaskIntoConstraints = false
    
    
    // Define Auto Layout constraints for view1
    NSLayoutConstraint.activate([
        view1.leftAnchor.constraint(equalTo: view.leftAnchor),
        view1.rightAnchor.constraint(equalTo: view.rightAnchor),
        view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        //view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        view1.heightAnchor.constraint(equalToConstant: 60)
    ])
    
    // Define Auto Layout constraints for view2
    NSLayoutConstraint.activate([
        view2.topAnchor.constraint(equalTo: view1.bottomAnchor),
        view2.leftAnchor.constraint(equalTo: view.leftAnchor),
        view2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        view2.heightAnchor.constraint(equalToConstant: 60)
    ])


}



func setUpHeaderViews() {
    // Create two views
    let view1 = UIView()
    let view2 = UIView()
    
    // Set background colors for the views
    //view1.backgroundColor = UIColor.systemBlue
    //view2.backgroundColor = UIColor.systemGreen
    
    // Add the views to the main view
    view.addSubview(view1)
    view.addSubview(view2)
    
    // Disable autoresizing masks for Auto Layout
    view1.translatesAutoresizingMaskIntoConstraints = false
    view2.translatesAutoresizingMaskIntoConstraints = false
    
    // Define Auto Layout constraints for view1
    NSLayoutConstraint.activate([
        view1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        view1.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    // Define Auto Layout constraints for view2
    NSLayoutConstraint.activate([
        view2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        view2.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        view2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        view2.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    // Create labels
    let followingLabel = UILabel()
    let forYouLabel = UILabel()
    
    // Set label properties
    followingLabel.text = "Following"
    forYouLabel.text = "For You"
    
    //followingLabel.textColor = UIColor.white
    //forYouLabel.textColor = UIColor.white
    
    //followingLabel.backgroundColor = .red
    //forYouLabel.backgroundColor = .blue
    
    followingLabel.textAlignment = .right
    forYouLabel.textAlignment = .left
    
    // Add labels to the views
    view1.addSubview(followingLabel)
    view2.addSubview(forYouLabel)
    
    // Disable autoresizing masks for Auto Layout
    followingLabel.translatesAutoresizingMaskIntoConstraints = false
    forYouLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Define Auto Layout constraints for label1
    NSLayoutConstraint.activate([
        followingLabel.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 10),
        followingLabel.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -10),
        followingLabel.topAnchor.constraint(equalTo: view1.topAnchor, constant: 10),
        followingLabel.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -10)
    ])
    
    // Define Auto Layout constraints for label2
    NSLayoutConstraint.activate([
        forYouLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
        forYouLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
        forYouLabel.topAnchor.constraint(equalTo: view2.topAnchor, constant: 10),
        forYouLabel.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10)
    ])


}



func setUpTwoViewsWorks() {
    // Create two views
    let view1 = UIView()
    let view2 = UIView()
    
    // Set background colors for the views
    view1.backgroundColor = UIColor.systemBlue
    view2.backgroundColor = UIColor.systemGreen
    
    // Add the views to the main view
    view.addSubview(view1)
    view.addSubview(view2)
    
    // Disable autoresizing masks for Auto Layout
    view1.translatesAutoresizingMaskIntoConstraints = false
    view2.translatesAutoresizingMaskIntoConstraints = false
    
    // Define Auto Layout constraints for view1
    NSLayoutConstraint.activate([
        view1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        view1.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    // Define Auto Layout constraints for view2
    NSLayoutConstraint.activate([
        view2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        view2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        view2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        view2.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    // Create labels
    let label1 = UILabel()
    let label2 = UILabel()
    
    // Set label properties
    label1.text = "Label 1"
    label2.text = "Label 2"
    
    label1.textColor = UIColor.white
    label2.textColor = UIColor.white
    
    label1.backgroundColor = .red
    label2.backgroundColor = .blue
    
    label1.textAlignment = .right
    label2.textAlignment = .left
    
    // Add labels to the views
    view1.addSubview(label1)
    view2.addSubview(label2)
    
    // Disable autoresizing masks for Auto Layout
    label1.translatesAutoresizingMaskIntoConstraints = false
    label2.translatesAutoresizingMaskIntoConstraints = false
    
    // Define Auto Layout constraints for label1
    NSLayoutConstraint.activate([
        label1.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 10),
        label1.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -10),
        label1.topAnchor.constraint(equalTo: view1.topAnchor, constant: 10),
        label1.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -10)
    ])
    
    // Define Auto Layout constraints for label2
    NSLayoutConstraint.activate([
        label2.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
        label2.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
        label2.topAnchor.constraint(equalTo: view2.topAnchor, constant: 10),
        label2.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10)
    ])


}


func setUpSingleView() {

    // Create the container view
    let containerView = UIView()
    containerView.backgroundColor = UIColor.systemBlue  // Set background color
    containerView.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
    
    // Add the container view to the main view
    self.view.addSubview(containerView)
    
    // Set constraints for containerView
    NSLayoutConstraint.activate([
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // 20 points from the top
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        containerView.heightAnchor.constraint(equalToConstant: 100)  // Height of 100
    ])
    
    // Create the UILabel
    let label = UILabel()
    label.text = "Hello, World!"
    label.backgroundColor = UIColor.systemYellow  // Set label background color
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
    
    // Add the label to the container view
    containerView.addSubview(label)
    
    // Set constraints for label (10 points from each edge of containerView)
    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
}




func setUpThreeHeaderViews() {
    
    // Create the three views
    let leftView = UIView()
    let rightView = UIView()
    let dividerView = UIView()
    
    // Set background colors for visibility
    leftView.backgroundColor = .systemBlue
    rightView.backgroundColor = .systemGreen
    dividerView.backgroundColor = .black
    
    // Add the views to the main view
    view.addSubview(leftView)
    view.addSubview(rightView)
    view.addSubview(dividerView)
    
    // Disable autoresizing masks for Auto Layout
    leftView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    rightView.translatesAutoresizingMaskIntoConstraints = false
    
    // Constraints
    NSLayoutConstraint.activate([
        
        // Set heights for all views to 100 points
        leftView.heightAnchor.constraint(equalToConstant: 40),
        rightView.heightAnchor.constraint(equalToConstant: 40),
        dividerView.heightAnchor.constraint(equalToConstant: 40),
        
        // Set left view on the left half of the screen
        leftView.leftAnchor.constraint(equalTo: view.leftAnchor),
        leftView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        
        // Set right view on the right half of the screen
        rightView.rightAnchor.constraint(equalTo: view.rightAnchor),
        rightView.topAnchor.constraint(equalTo: leftView.topAnchor),
        
        // Middle divider view
        dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        dividerView.topAnchor.constraint(equalTo: leftView.topAnchor),
        dividerView.widthAnchor.constraint(equalToConstant: 2),
        
        // Widths: Left and right views take up half the screen minus the divider
        leftView.trailingAnchor.constraint(equalTo: dividerView.leadingAnchor),
        rightView.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
        leftView.widthAnchor.constraint(equalTo: rightView.widthAnchor),
    ])
    
    //CREATE TEXT
    //let label1 = createLabel(text: "Following", backgroundColor: .red)
    //let label2 = createLabel(text: "For You", backgroundColor: .blue)
    
    // 5. Add labels to the stack view
    //leftView.addSubview(label1)
    //rightView.addSubview(label2)
    
    // Create labels for each view
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    // Set text and background colors for labels
    leftLabel.text = "Following"
    leftLabel.backgroundColor = .white
    leftLabel.textAlignment = .right
    
    NSLayoutConstraint.activate([
        //leftLabel.leftAnchor.constraint(equalTo: leftView.leftAnchor),
        //leftLabel.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 100),
        leftLabel.heightAnchor.constraint(equalToConstant: 30),
        leftLabel.widthAnchor.constraint(equalToConstant: 100)
    ])

    rightLabel.text = "For You"
    rightLabel.backgroundColor = .white
    rightLabel.textAlignment = .left
    
    // Disable autoresizing masks for labels
    leftLabel.translatesAutoresizingMaskIntoConstraints = false
    rightLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Add labels to their respective views
    leftView.addSubview(leftLabel)
    rightView.addSubview(rightLabel)
    
}

*/

/*


// Helper method to create a label
func createLabel(text: String, backgroundColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textAlignment = .center
    label.backgroundColor = backgroundColor
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.heightAnchor.constraint(equalToConstant: 32).isActive = true
    
    return label
}
*/
/*
 func setupStackView() {
     // 1. Create the stack view
     let stackView = UIStackView()
     stackView.axis = .vertical
     stackView.alignment = .fill
     stackView.distribution = .fillEqually  // Each cell has equal height
     
     // 2. Add the stack view to the view
     stackView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(stackView)
     
     // 3. Set constraints for the stack view (100 points high, full width)
     NSLayoutConstraint.activate([
         stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
         stackView.heightAnchor.constraint(equalToConstant: 100)
     ])
     
     // 4. Create the first label
     let label1 = createLabel(text: "Label 1", backgroundColor: .red)
     let label2 = createLabel(text: "Label 2", backgroundColor: .blue)
     
     // 5. Add labels to the stack view
     stackView.addArrangedSubview(label1)
     stackView.addArrangedSubview(label2)
 }
 */



/*
func setUpThreeHeaderViews() {
    // Create the left and right views
    let leftView = UIView()
    let dividerView = UIView()
    let rightView = UIView()
    
    // Set background colors for the views
    leftView.backgroundColor = .systemBlue
    dividerView.backgroundColor = .black
    rightView.backgroundColor = .systemGreen
    
    // Disable autoresizing masks for Auto Layout
    leftView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    rightView.translatesAutoresizingMaskIntoConstraints = false
    
    // Add the views to the main view
    view.addSubview(leftView)
    view.addSubview(dividerView)
    view.addSubview(rightView)
    
    // Create labels for each view
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    // Set text and background colors for labels
    leftLabel.text = "Following"
    leftLabel.backgroundColor = .white
    leftLabel.textAlignment = .right

    rightLabel.text = "For You"
    rightLabel.backgroundColor = .white
    rightLabel.textAlignment = .left
    
    // Disable autoresizing masks for labels
    leftLabel.translatesAutoresizingMaskIntoConstraints = false
    rightLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Add labels to their respective views
    leftView.addSubview(leftLabel)
    rightView.addSubview(rightLabel)
    
    // Constraints for the left view
    NSLayoutConstraint.activate([
        leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        leftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        leftView.heightAnchor.constraint(equalToConstant: 40),
        leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
    ])
    
    // Constraints for the divider view
    NSLayoutConstraint.activate([
        dividerView.leadingAnchor.constraint(equalTo: leftView.rightAnchor),
        dividerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        dividerView.heightAnchor.constraint(equalToConstant: 40),
        dividerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
    ])
    
    // Constraints for the right view
    NSLayoutConstraint.activate([
        rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        rightView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        rightView.heightAnchor.constraint(equalToConstant: 40),
        rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
    ])
    
    
    //LABEL
    // Constraints for the left label
    NSLayoutConstraint.activate([
        leftLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
        leftLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
        leftLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor)
    ])
    
    // Constraints for the right label
    NSLayoutConstraint.activate([
        rightLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 8),
        rightLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -20),
        rightLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
    ])
}



func setUpHeaderViews() {
    // Create the left and right views
    let leftView = UIView()
    let rightView = UIView()
    
    // Set background colors for the views
    leftView.backgroundColor = .systemBlue
    rightView.backgroundColor = .systemGreen
    
    // Disable autoresizing masks for Auto Layout
    leftView.translatesAutoresizingMaskIntoConstraints = false
    rightView.translatesAutoresizingMaskIntoConstraints = false
    
    // Add the views to the main view
    view.addSubview(leftView)
    view.addSubview(rightView)
    
    // Create labels for each view
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    // Set text and background colors for labels
    leftLabel.text = "Following"
    leftLabel.backgroundColor = .white
    leftLabel.textAlignment = .right

    rightLabel.text = "For You"
    rightLabel.backgroundColor = .white
    rightLabel.textAlignment = .left
    
    // Disable autoresizing masks for labels
    leftLabel.translatesAutoresizingMaskIntoConstraints = false
    rightLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Add labels to their respective views
    leftView.addSubview(leftLabel)
    rightView.addSubview(rightLabel)
    
    // Constraints for the left view
    NSLayoutConstraint.activate([
        leftView.leftAnchor.constraint(equalTo: view.leftAnchor),
        leftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        leftView.heightAnchor.constraint(equalToConstant: 40),
        leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
    ])
    
    // Constraints for the right view
    NSLayoutConstraint.activate([
        rightView.rightAnchor.constraint(equalTo: view.rightAnchor),
        rightView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        rightView.heightAnchor.constraint(equalToConstant: 40),
        rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
    ])
    
    // Constraints for the left label
    NSLayoutConstraint.activate([
        leftLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
        leftLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
        leftLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor)
    ])
    
    // Constraints for the right label
    NSLayoutConstraint.activate([
        rightLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 8),
        rightLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -20),
        rightLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
    ])
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpHeaderViews()
    }
    
    func setUpHeaderViews() {
        // Create the left and right views
        let leftView = UIView()
        let rightView = UIView()
        
        // Set background colors for the views
        leftView.backgroundColor = .systemBlue
        rightView.backgroundColor = .systemGreen
        
        // Disable autoresizing masks for Auto Layout
        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the views to the main view
        view.addSubview(leftView)
        view.addSubview(rightView)
        
        // Create labels for each view
        let leftLabel = UILabel()
        let rightLabel = UILabel()
        
        // Set text and background colors for labels
        leftLabel.text = "Following"
        leftLabel.backgroundColor = .white
        leftLabel.textAlignment = .right
   
        rightLabel.text = "For You"
        rightLabel.backgroundColor = .white
        rightLabel.textAlignment = .left
        
        // Disable autoresizing masks for labels
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add labels to their respective views
        leftView.addSubview(leftLabel)
        rightView.addSubview(rightLabel)
        
        // Constraints for the left view
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            leftView.heightAnchor.constraint(equalToConstant: 100),
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        // Constraints for the right view
        NSLayoutConstraint.activate([
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            rightView.heightAnchor.constraint(equalToConstant: 100),
            rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        // Constraints for the left label
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            leftLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -8),
            leftLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor)
        ])
        
        // Constraints for the right label
        NSLayoutConstraint.activate([
            rightLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 8),
            rightLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -20),
            rightLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
        ])
    }
    
}

*/


//TWO VIEWS
/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create two views
        let leftView = UIView()
        leftView.backgroundColor = .red // First color
        
        let rightView = UIView()
        rightView.backgroundColor = .blue // Second color
        
        // Add views to the main view
        view.addSubview(leftView)
        view.addSubview(rightView)
        
        // Disable autoresizing masks for programmatic constraints
        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the left view
        NSLayoutConstraint.activate([
            leftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),  // 100 from the top
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),  // Align left with the parent view
            leftView.heightAnchor.constraint(equalToConstant: 100),  // Height of 100
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)  // Half of the screen width
        ])
        
        // Set constraints for the right view
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),  // 100 from the top
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),  // Align right with the parent view
            rightView.heightAnchor.constraint(equalToConstant: 100),  // Height of 100
            rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)  // Half of the screen width
        ])
    }
}
*/

//MESSY


/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's background color to white
        view.backgroundColor = .white
        
        // Create the horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8 // Padding between the cells
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .green
        
        // Add the stack view to the main view
        view.addSubview(stackView)
        
        // Create the two labels to go inside the stack view
        let labelA = UILabel()
        labelA.text = "textA"
        labelA.textAlignment = .center
        labelA.backgroundColor = .red // Set a different color for labelA
        labelA.translatesAutoresizingMaskIntoConstraints = false
        
        let labelB = UILabel()
        labelB.text = "textB"
        labelB.textAlignment = .center
        labelB.backgroundColor = .blue // Set a different color for labelB
        labelB.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the labels to the stack view
        stackView.addArrangedSubview(labelA)
        stackView.addArrangedSubview(labelB)
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80), // 80 points from the top
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Align to the left of the screen
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // Align to the right of the screen
            stackView.heightAnchor.constraint(equalToConstant: 100) // 100 points height
        ])
        
        // Constraints for the labels' height and width
        NSLayoutConstraint.activate([
            labelA.heightAnchor.constraint(equalToConstant: 40), // 40 points high
            labelA.widthAnchor.constraint(equalToConstant: 80), // 80 points wide
            
            labelB.heightAnchor.constraint(equalToConstant: 40), // 40 points high
            labelB.widthAnchor.constraint(equalToConstant: 80) // 80 points wide
        ])
        
        // Adjust the text's position to be 10 points away from the center
        // For labelA
        NSLayoutConstraint.activate([
            labelA.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10), // Move 10 points down from center
            labelA.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10) // Move 10 points up from center
        ])
        
        // For labelB
        NSLayoutConstraint.activate([
            labelB.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10), // Move 10 points down from center
            labelB.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10) // Move 10 points up from center
        ])
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's background color to white
        view.backgroundColor = .white
        
        // Create the horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8 // Padding between the cells
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .green
        
        // Add the stack view to the main view
        view.addSubview(stackView)
        
        // Create the two labels to go inside the stack view
        let labelA = UILabel()
        labelA.text = "textA"
        labelA.textAlignment = .center
        labelA.backgroundColor = .red // Set a different color for labelA
        labelA.translatesAutoresizingMaskIntoConstraints = false
        
        let labelB = UILabel()
        labelB.text = "textB"
        labelB.textAlignment = .center
        labelB.backgroundColor = .blue // Set a different color for labelB
        labelB.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the labels to the stack view
        stackView.addArrangedSubview(labelA)
        stackView.addArrangedSubview(labelB)
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80), // 80 points from the top
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Align to the left of the screen
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // Align to the right of the screen
            stackView.heightAnchor.constraint(equalToConstant: 100) // 100 points height
        ])
        
        // Constraints for the labels' height and width
        NSLayoutConstraint.activate([
            labelA.heightAnchor.constraint(equalToConstant: 40), // 40 points high
            labelA.widthAnchor.constraint(equalToConstant: 80), // 80 points wide
            
            labelB.heightAnchor.constraint(equalToConstant: 40), // 40 points high
            labelB.widthAnchor.constraint(equalToConstant: 80) // 80 points wide
        ])
    }
}
*/


/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's background color to white
        view.backgroundColor = .white
        
        // Create the horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8 // Padding between the cells
        
        // Set the frame of the stack view
        stackView.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 100)
        
        // Set the background color of the stack view to green
        stackView.backgroundColor = .green
        
        // Create the two labels to go inside the stack view
        let labelA = UILabel()
        labelA.text = "textA"
        labelA.textAlignment = .center
        labelA.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        labelA.backgroundColor = .white // Optional, for visibility

        let labelB = UILabel()
        labelB.text = "textB"
        labelB.textAlignment = .center
        labelB.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        labelB.backgroundColor = .white // Optional, for visibility
        
        // Add the labels to the stack view
        stackView.addArrangedSubview(labelA)
        stackView.addArrangedSubview(labelB)
        
        // Add the stack view to the main view
        view.addSubview(stackView)
    }
}
*/


/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal  // Horizontal stack
        stackView.alignment = .center // Align items in the center vertically
        stackView.spacing = 10        // Space between the items
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the first label (A)
        let labelA = UILabel()
        labelA.text = "A"
        labelA.textAlignment = .center
        labelA.backgroundColor = .green // Just to make the label visible

        // Create the second label (B)
        let labelB = UILabel()
        labelB.text = "B"
        labelB.textAlignment = .center
        labelB.backgroundColor = .red // Just to make the label visible
        
        // Add labels to the stack view
        stackView.addArrangedSubview(labelA)
        stackView.addArrangedSubview(labelB)

        // Add the stack view to the view hierarchy
        self.view.addSubview(stackView)
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            // Position the stack view 20 points from the top
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            
            // Set the stack view to be full width
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            // Set a fixed height for the stack view (e.g., 100 points)
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Set some constraints for the labels inside the stack view
        labelA.widthAnchor.constraint(equalTo: labelB.widthAnchor).isActive = true
        labelA.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        labelB.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
    }
}
*/

/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create the horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 10 // Optional: add space between the labels
        
        // 2. Create two labels
        let label1 = createLabel(withText: "Label 1")
        let label2 = createLabel(withText: "Label 2")
        
        // 3. Add the labels to the stack view
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        
        // 4. Add the stack view to the main view
        view.addSubview(stackView)
        
        // 5. Set the constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // 6. Set the constraints for the labels inside the stack view
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label1.heightAnchor.constraint(equalToConstant: 60),
            label1.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            label1.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
            
            label2.heightAnchor.constraint(equalToConstant: 60),
            label2.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            label2.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20)
        ])
    }

    // Helper method to create a label
    func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }
}

*/

//VERTICAL STACK VIEW
/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }
    
    func setupStackView() {
        // 1. Create the stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually  // Each cell has equal height
        
        // 2. Add the stack view to the view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // 3. Set constraints for the stack view (100 points high, full width)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // 4. Create the first label
        let label1 = createLabel(text: "Label 1", backgroundColor: .red)
        let label2 = createLabel(text: "Label 2", backgroundColor: .blue)
        
        // 5. Add labels to the stack view
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
    }
    
    func createLabel(text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        // Set label height (60 points)
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return label
    }
}
*/

//NOTES
//backgroundImageView.image = UIImage(named: "background_3")
//headerView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//@IBOutlet weak var backgroundImageView: UIImageView!
//@IBOutlet weak var headerView: UIView!



/*
 import UIKit

 class ViewController: UIViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
     }
     

 }


 */
