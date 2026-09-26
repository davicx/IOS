//
//  ViewController.swift
//  Twitter
//
//  Created by David Vasquez on 10/4/24.
//


import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var postCaptions: [String] = ["hiya!", "hiya! again!", "hiya!", "hiya! again!", "Hiya 5!!"]
    var postImages: [String] = ["background_1", "background_2", "background_3", "background_4", "background_5"]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //collectionView?.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostCell
        //cell.myImageView.image = UIImage(named: postImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = (view.frame.width / 2) - 20
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You picked \(postImages[indexPath.row])! and it is image \(indexPath.row + 1)")
        let secondVC = SecondViewController()
        secondVC.postCaption = postCaptions[indexPath.row] // Pass the image name
        navigationController?.pushViewController(secondVC, animated: true) // Navigate to the second view
    }

}



