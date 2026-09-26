//
//  ViewController.swift
//  InstagramDesign
//
//  Created by David Vasquez on 1/5/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myData: [String] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setUpLayout()

        
    }
    
    func setUpLayout() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 3
        let numberOfItemsPerRow: CGFloat = 3

        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let itemWidth = (view.frame.width - totalPadding) / numberOfItemsPerRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding

        collectionView.collectionViewLayout = layout
    }
    

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as?
            MyCollectionViewCell {
      
            currentCell.backgroundColor = UIColor(hex: "#EFEFEF")
            currentCell.configure(with: myData[indexPath.row])
            cell = currentCell
        }
        
        return cell

    }
         
    
}

/*
 
 class ViewController: UIViewController {
     
     @IBOutlet weak var tableView: UITableView!
     var users = ["sam", "merry", "frodo", "david"]

     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self
     }



 }

 extension ViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return users.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let currentUser = users[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "individualUserCell") as! IndividualPostViewCell
         
         cell.setUser(currentUser: currentUser)
         
         return cell
     }
     
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedUser = users[indexPath.row]
         print("you picked \(selectedUser)!!")
     }
 }

 */
