//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/3/24.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let users: [User] = {
        let frodo = User(name: "frodo", username: "@frodo", bioText: "hi!!", profileImage: #imageLiteral(resourceName: "background_1"))
        let merry = User(name: "merry", username: "@merry", bioText: "hi!!", profileImage: #imageLiteral(resourceName: "background_5"))
        let pippin = User(name: "pippin", username: "@pippin", bioText: "Do you wish me a good morning, or mean that it is a good morning whether I want it or not; or that you feel good this morning; or that it is a morning to be good on", profileImage: #imageLiteral(resourceName: "background_2"))
        return [frodo, pippin, merry]
    }()
    
    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UserCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UserHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(UserFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId) // Register UserFooterView here
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserCell
        //cell.nameLabel.text = users[indexPath.row].bioText
        let currentUser = users[indexPath.row]
        
        cell.postCurrentUser(user: currentUser)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
     
    // Header and Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserHeaderView
            header.backgroundColor = .white
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! UserFooterView
            footer.backgroundColor = .white // Use the UserFooterView class
            return footer
        }
    }
}

