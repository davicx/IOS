//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by David Vasquez on 10/2/24.
//

import UIKit

class YourViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    


    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // Number of cells you want
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: "Item \(indexPath.item + 1)")
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) // Set the cell size
    }
}

/*

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    

    
}
 */

/*
 import UIKit


*/

/*
 
 
 
 class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
     
     let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
     var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
     
     
     // MARK: - UICollectionViewDataSource protocol
     
     // tell the collection view how many cells to make
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.items.count
     }
     
     // make a cell for each cell index path
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         // get a reference to our storyboard cell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
         
         // Use the outlet in our custom class to get a reference to the UILabel in the cell
         cell.myLabel.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
         cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
         
         return cell
     }
     
     // MARK: - UICollectionViewDelegate protocol
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         // handle tap events
         print("You selected cell #\(indexPath.item)!")
     }
 }
 */
