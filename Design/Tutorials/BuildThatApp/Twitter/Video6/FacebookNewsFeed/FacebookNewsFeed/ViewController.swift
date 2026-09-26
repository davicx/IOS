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
        let merry = User(name: "merry", username: "@merry", bioText: "I suppose hobbits need some description nowadays, since they have become rare and shy of the Big People, as they call us. They are (or were) a little people, about half our height, and smaller than the bearded Dwarves. Hobbits have no beards. There is little or no magic about them, except the ordinary everyday sort which helps them to disappear quietly and quickly when large stupid folk like you and me come blundering along, making a noise like elephants which they can hear a mile off. They are inclined to be fat in the stomach; they dress in bright colours (chiefly green and yellow);", profileImage: #imageLiteral(resourceName: "background_5"))
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
        
        guard let user = users[indexPath.row] as? User else {
            // Fallback size if user data is not available
            return CGSize(width: view.frame.width, height: 200)
        }
        
        // Calculate the available width for bioTextView
        //let padding: CGFloat = 12 + 50 + 12 + 2
        let padding: CGFloat = 12 + 50 + 12
        let approximateWidthOfBioTextView = view.frame.width - padding
        
        // Define a maximum height for the bio text
        let size = CGSize(width: approximateWidthOfBioTextView, height: CGFloat.greatestFiniteMagnitude)
        
        // Set the font attributes for bioTextView
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
        
        // Calculate the bounding rectangle for the bio text
        let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        // Add the fixed height of other labels (66) to the estimated text height
        let totalHeight = estimatedFrame.height + 66
        
        return CGSize(width: view.frame.width, height: totalHeight)
    }

    //Remove the extra space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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




/*
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if let user = users[indexPath.row] as? User {
        
        //Width of Screen minus the user image size and padding (12 - 50 - 12 - 2)
        let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
        
        let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        
        let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                    
        print("approximateWidthOfBioTextView \(approximateWidthOfBioTextView)")
        print("estimatedFrame \(estimatedFrame)")
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        
    }
    
    return CGSize(width: view.frame.width, height: 200)
}
 
*/
/*
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

     if let user = users[indexPath.row] as? User {
         let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
         let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
         let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
         
         let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                     
         print("approximateWidthOfBioTextView \(approximateWidthOfBioTextView)")
         print("estimatedFrame \(estimatedFrame)")
         return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
         
     }
     
     return CGSize(width: view.frame.width, height: 200)
     
 }
 
 */

