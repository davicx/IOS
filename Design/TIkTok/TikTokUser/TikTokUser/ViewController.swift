//
//  ViewController.swift
//  TikTokUser
//
//  Created by David Vasquez on 12/1/24.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    let hobbitNames = ["Frodo", "Sam", "Merry", "Pippin", "Bilbo", "Thorin"]
    
    // Collection view instance
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 380) // Header height
        
        // Item size to fit 3 items across with spacing
        let itemWidth = (view.frame.width - 40) / 3
        let itemHeight = itemWidth + 20
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // Initialize collection view
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        // Register cell and header
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        // Set data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Add collection view to the view
        self.view.addSubview(collectionView)
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


