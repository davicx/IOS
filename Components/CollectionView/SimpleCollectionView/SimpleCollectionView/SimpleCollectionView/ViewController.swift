//
//  ViewController.swift
//  SimpleCollectionView
//
//  Created by David Vasquez on 10/2/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var postCaptions: [String] = ["hiya!, hiya! again!"]
    var postImages: [String] = ["background_1, background_2"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        print("hi")
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postCaptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        as! CollectionViewCell
        cell.postCaptionView.text = postCaptions[indexPath.row]
        cell.postImageView.image = UIImage(named: postImages[indexPath.row])
        print(postImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeFqrItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    


}

/*

 func collectionView(_ collectionView: UICollectionView, cellforItemAt indexPath: IndexPath) ->
 UICollectionViewCell {

 }
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
 UICollectionViewLayout, sizeFqrItemAt indexPath: IndexPath) -> CGSize {
 let size = (collectionView.frame.size.width-10)/2
 return CGSize(width: size, height: size)
 }
 */
