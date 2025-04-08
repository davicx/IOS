//
//  Appendix.swift
//  Profile
//
//  Created by David Vasquez on 12/13/24.
//


import UIKit



/*
class ViewController: UIViewController {
    let mainProfileView = UIView()
    let mainPostsView = UIView()
    
    //Sub Views
    let userActionView = UIView()
    let userProfileView = UIView()
    let userEditProfileView = UIView()
    let userBiographyView = UIView()
    let userPostSelectView = UIView()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        //setupMainViews()
    
  
    }
    
    //VIEWS
    //Section 1: Main Page Layout
    func setupMainViews() {
        mainProfileView.backgroundColor = .systemBlue
        mainPostsView.backgroundColor = .systemGreen

        view.addSubview(mainProfileView)
        view.addSubview(mainPostsView)
 
        // Disable autoresizing mask translation
        mainProfileView.translatesAutoresizingMaskIntoConstraints = false
        mainPostsView.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints
        NSLayoutConstraint.activate([
            mainProfileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            mainProfileView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainProfileView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainProfileView.heightAnchor.constraint(equalToConstant: 380),

            mainPostsView.topAnchor.constraint(equalTo: mainProfileView.bottomAnchor),
            mainPostsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainPostsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainPostsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupSubViews()
    }
    
    func setupSubViews() {
        
        //Section 2: User Actions
        userActionView.backgroundColor = .systemPink
        mainProfileView.addSubview(userActionView)
        userActionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userActionView.topAnchor.constraint(equalTo: mainProfileView.topAnchor, constant: 0),
            userActionView.leftAnchor.constraint(equalTo: mainProfileView.leftAnchor, constant: 0),
            userActionView.rightAnchor.constraint(equalTo: mainProfileView.rightAnchor, constant: -0),
            //userProfileView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -40)
            userActionView.heightAnchor.constraint(equalToConstant: 48)
        ])
        

        //Section 3: User Profile
        userProfileView.backgroundColor = .blue
        mainProfileView.addSubview(userProfileView)
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: userActionView.bottomAnchor),
            userProfileView.leftAnchor.constraint(equalTo: mainProfileView.leftAnchor),
            userProfileView.rightAnchor.constraint(equalTo: mainProfileView.rightAnchor),
            userProfileView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        //Section 4: User Edit Profile
        userEditProfileView.backgroundColor = .white
        mainProfileView.addSubview(userEditProfileView)
        userEditProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userEditProfileView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor),
            userEditProfileView.leftAnchor.constraint(equalTo: mainProfileView.leftAnchor),
            userEditProfileView.rightAnchor.constraint(equalTo: mainProfileView.rightAnchor),
            userEditProfileView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //Section 5: User Biography
        userBiographyView.backgroundColor = .blue
        mainProfileView.addSubview(userBiographyView)
        userBiographyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userBiographyView.topAnchor.constraint(equalTo: userEditProfileView.bottomAnchor),
            userBiographyView.leftAnchor.constraint(equalTo: mainProfileView.leftAnchor),
            userBiographyView.rightAnchor.constraint(equalTo: mainProfileView.rightAnchor),
            userBiographyView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        //Section 5: User Select Display
        userPostSelectView.backgroundColor = .white
        mainProfileView.addSubview(userPostSelectView)
        userPostSelectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userPostSelectView.topAnchor.constraint(equalTo: userBiographyView.bottomAnchor),
            userPostSelectView.leftAnchor.constraint(equalTo: mainProfileView.leftAnchor),
            userPostSelectView.rightAnchor.constraint(equalTo: mainProfileView.rightAnchor),
            userPostSelectView.heightAnchor.constraint(equalToConstant: 42)
        ])

        
    }
    
    //BUTTON
    @IBAction func navigateToSecondView(_ sender: UIButton) {
        performSegue(withIdentifier: "editProfileSegue", sender: self)
        print("hi")
    }
    
    func setUpButton() {
        
        let editProfileButton = createEditProfileButton()

        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.addTarget(self, action: #selector(navigateToSecondView), for: .touchUpInside)
        view.addSubview(editProfileButton)
    
        NSLayoutConstraint.activate([
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
  
        
    }
    
}

func createEditProfileButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("Edit Profile", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

    return button
}

func createImageHeaderView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    
    return imageView

}
*/

    /*
     
     setUpBodyView()

 }
 
 func setUpBodyView() {
     //Body View
     userProfileView.backgroundColor = .white
     bodyView.addSubview(userProfileView)
     userProfileView.translatesAutoresizingMaskIntoConstraints = false
     
     NSLayoutConstraint.activate([
         userProfileView.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 40),
         userProfileView.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 40),
         userProfileView.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -40),
         //userProfileView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -40)
         userProfileView.heightAnchor.constraint(equalToConstant: 120)
     ])
     
 }
 
     */
    

    
    
    //USER ACTIONS
    //USER PROFILE
    /*
     
     func setUpButton() {
         let editProfileButton = createEditProfileButton()

         editProfileButton.translatesAutoresizingMaskIntoConstraints = false
         editProfileButton.addTarget(self, action: #selector(navigateToSecondView), for: .touchUpInside)
         view.addSubview(editProfileButton)
     
         NSLayoutConstraint.activate([
             editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             editProfileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
   
         
     }
     
     /*
      TYPE 1:
     @objc private func navigateToSecondView() {
         performSegue(withIdentifier: "editProfileSegue", sender: self)
         print("hi")
     }
      */
     
     //TYPE 2
     @IBAction func navigateToSecondView(_ sender: UIButton) {
         performSegue(withIdentifier: "editProfileSegue", sender: self)
         print("hi")
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "editProfileSegue" {
             // Pass data to SecondViewController if needed
             let destinationVC = segue.destination as! EditProfileViewController
             //destinationVC.someProperty = "Hello from ViewController!"
         }
     }

     */
    
    //USER EDIT PROFILE
    
    //USER BIOGRAPHY
    
    //USER SELECT DISPLAY


/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle("Go to Second View", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToSecondView), for: .touchUpInside)
        
        view.addSubview(button)
        
        // Center the button in the view
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func navigateToSecondView() {
        performSegue(withIdentifier: "toSecondViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            // Pass data to SecondViewController if needed
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.someProperty = "Hello from ViewController!"
        }
    }
}
*/


/*
 
 
 func createImageHeaderView() -> UIImageView {
     let imageView = UIImageView()
     imageView.contentMode = .scaleAspectFit
     imageView.backgroundColor = .white
     
     return imageView

 }

 func createHeaderView() -> UIView {
     let view = UIView()
     view.backgroundColor = .red
     
     return view

 }

 func createBodyView() -> UIView {
     let view = UIView()
     view.backgroundColor = .white
     
     return view
 }

 func createFooterView() -> UIView {
     let view = UIView()
     view.backgroundColor = .blue
     
     return view
 }


 func createDividerView() -> UIView {
     let view = UIView()
     view.backgroundColor = .black
     
     return view
 }

 func createLabelView() -> UILabel {
     let label = UILabel()
     label.text = "hi"
     label.translatesAutoresizingMaskIntoConstraints = false
     label.numberOfLines = 0 // Allow for multiple lines
     label.textAlignment = .center
     label.backgroundColor = .green

     
     return label
 }

 */

/*

 import UIKit

 class ViewController: UIViewController {

     let hobbitNames = ["Frodo", "Sam", "Merry", "Pippin", "Bilbo", "Thorin"]
     
     // Collection view instance
     var collectionView: UICollectionView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupCollectionView()
         
     }
     

     

 }


 // Custom Header View
 class HeaderView: UICollectionReusableView {
     let headerView = UIView()
     let bodyView = UIView()
     let footerView = UIView()
     
     //Body View
     let userProfileView = UIView()

     
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupViews()
     }
     
     func setupViews() {
         headerView.backgroundColor = .systemBlue
         bodyView.backgroundColor = .systemGreen
         footerView.backgroundColor = .systemRed

         addSubview(headerView)
         addSubview(bodyView)
         addSubview(footerView)

         // Disable autoresizing mask translation
         headerView.translatesAutoresizingMaskIntoConstraints = false
         bodyView.translatesAutoresizingMaskIntoConstraints = false
         footerView.translatesAutoresizingMaskIntoConstraints = false

         // Set constraints
         NSLayoutConstraint.activate([
             headerView.topAnchor.constraint(equalTo: topAnchor),
             headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
             headerView.heightAnchor.constraint(equalToConstant: 48),

             footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
             footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
             footerView.heightAnchor.constraint(equalToConstant: 42),

             bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
             bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
             bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
             bodyView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
         ])
         
         setUpBodyView()

     }
     
     func setUpBodyView() {
         //Body View
         userProfileView.backgroundColor = .white
         bodyView.addSubview(userProfileView)
         userProfileView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             userProfileView.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 40),
             userProfileView.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 40),
             userProfileView.rightAnchor.constraint(equalTo: bodyView.rightAnchor, constant: -40),
             //userProfileView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -40)
             userProfileView.heightAnchor.constraint(equalToConstant: 120)
         ])
         
     }
     

     
     
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
 }



 extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return hobbitNames.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
         cell.backgroundColor = .systemGreen
         
         // Add label to the cell
         let label = UILabel(frame: cell.contentView.frame)
         label.text = hobbitNames[indexPath.item]
         label.textColor = .white
         label.textAlignment = .center
         label.font = UIFont.boldSystemFont(ofSize: 16)
         
         // Remove existing subviews to avoid duplication
         cell.contentView.subviews.forEach { $0.removeFromSuperview() }
         
         cell.contentView.addSubview(label)
         return cell
     }

     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
         headerView.backgroundColor = .systemBlue
         //headerView.label.text = "Hobbit Names Collection"
         return headerView
     }
 }
*/


 //TEMPLATES
 /*
  func setupStackiew() {
      // Create the header view
      let headerView = UIView()
      headerView.translatesAutoresizingMaskIntoConstraints = false
      headerView.backgroundColor = .systemGray6  // Optional: background color
      
      // Add header view to the main view
      view.addSubview(headerView)
      
      // Header view constraints
      NSLayoutConstraint.activate([
          headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          headerView.heightAnchor.constraint(equalToConstant: 160)
      ])
      
      // Create horizontal stack view
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      // Add stack view to header view
      headerView.addSubview(stackView)
      
      // Stack view constraints
      NSLayoutConstraint.activate([
          stackView.topAnchor.constraint(equalTo: headerView.topAnchor),
          stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
          stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
          stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
      ])
      
      // Create first cell
      let firstCell = UIView()
      firstCell.backgroundColor = .systemBlue
      
      // Create second cell
      let secondCell = UIView()
      secondCell.backgroundColor = .systemGreen
      
      // Add cells to stack view
      stackView.addArrangedSubview(firstCell)
      stackView.addArrangedSubview(secondCell)
      
      // Create first label
      let firstLabel = UILabel()
      firstLabel.text = "First"
      firstLabel.textColor = .white
      firstLabel.textAlignment = .center
      
      firstLabel.translatesAutoresizingMaskIntoConstraints = false
      
      // Add first label to first cell
      firstCell.addSubview(firstLabel)
      
      // First label constraints
      NSLayoutConstraint.activate([
          firstLabel.centerXAnchor.constraint(equalTo: firstCell.centerXAnchor),
          firstLabel.centerYAnchor.constraint(equalTo: firstCell.centerYAnchor)
      ])
      
      // Create second label
      let secondLabel = UILabel()
      secondLabel.text = "Second"
      secondLabel.textColor = .white
      secondLabel.textAlignment = .center
      secondLabel.translatesAutoresizingMaskIntoConstraints = false
      
      // Add second label to second cell
      secondCell.addSubview(secondLabel)
      
      // Second label constraints
      NSLayoutConstraint.activate([
          secondLabel.centerXAnchor.constraint(equalTo: secondCell.centerXAnchor),
          secondLabel.centerYAnchor.constraint(equalTo: secondCell.centerYAnchor)
      ])
  }
  
  
  */


