//
//  ViewController.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



//https://www.youtube.com/watch?v=JvjEqWHcyIw
//https://samwize.com/2017/05/25/creating-a-autoresizing-uitableview-programmatically/
//https://sarunw.com/posts/how-to-resize-and-position-image-in-uiimageview-using-contentmode/
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
    func createArray() -> [User] {
        let userOne = User(userImage: UIImage(named: "background_1")!, userName: "davey")
        let userTwo = User(userImage: UIImage(named: "background_8")!, userName: "sam")
        let userThree = User(userImage: UIImage(named: "background_3")!, userName: "I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures")
        let userFour = User(userImage: UIImage(named: "background_4")!, userName: "merry")

        return [userOne, userTwo, userThree, userFour]
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
        
        //tableView.delegate?.tableView(users[indexPath.row], heightForRowAt: 120)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = users[indexPath.row].userImage
        let currentImageHeight = users[indexPath.row].userImage.size.height
        let currentImageWidth = users[indexPath.row].userImage.size.width
        let screenSize: CGRect = UIScreen.main.bounds
        let imageCrop = currentImage.getCropRatio()
        let cellHeight = tableView.frame.width / imageCrop

        return cellHeight + 40
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser.userName)!!")
    }
}


extension UIImage {
    func getCropRatio () -> CGFloat {
        let widthRatio = CGFloat (self.size.width / self.size.height)
        return widthRatio
    }
}


/*
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     let currentImage = users[indexPath.row].userImage
     let currentImageHeight = users[indexPath.row].userImage.size.height
     let currentImageWidth = users[indexPath.row].userImage.size.width
     let screenSize: CGRect = UIScreen.main.bounds
     let imageCrop = currentImage.getCropRatio()
     let cellHeight = tableView.frame.width / imageCrop
     print("image crop \(imageCrop)")
     //print("\(currentImageHeight) \(currentImageWidth) \(screenSize.height) \(screenSize.width)")
     print("current row \(indexPath.row)")
     print("WIDTH \(tableView.frame.width)")
     print("HEIGHT \(tableView.frame.width / imageCrop)")
     
     //return tableView.frame.width /| imageCrop

     return cellHeight + 40
     
     
 }
 
 */


/*
 override func tableView(_ tableView: UITableView, heightforRowt indexPath: IndexPath) -> CGFloat {
 let currentImage = images [indexPath. row]
 let imageCrop = currentImage.getCropRatio)
 return tableView.frame.width /| imageCrop
 }
 */

/*
 let marginguide = contentView.layoutMarginsGuide


 //imageView auto layout constraints

 cell.imageView?.translatesAutoresizingMaskIntoConstraints = false

 let marginguide = cell.contentView.layoutMarginsGuide

 cell.imageView?.topAnchor.constraint(equalTo: marginguide.topAnchor).isActive = true
 cell.imageView?.leadingAnchor.constraint(equalTo: marginguide.leadingAnchor).isActive = true
 cell.imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
 cell.imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true

 cell.imageView?.contentMode = .scaleAspectFill
 cell.imageView?.layer.cornerRadius = 20 //half of your width or height

 */

/*
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    var cellHeight:CGFloat = CGFloat()

    if indexPath.row % 2 == 0 {
        cellHeight = 20
    }
    else if indexPath.row % 2 != 0 {
        cellHeight = 50
    }
    return cellHeight
}
 */


/*
 func collectionViewTemp( collectionView: UICollectionView, cellorItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = imagesCollectionView.dequeueReusableCe11(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
     cell.imageViewOutlet.image = imagesArr[indexPath.item]
     cell.constraintHeightOutlet.constant = imagesArr [indexPath.item]!.size.height
     cell.constraintWidthOutlet.constant = imagesArr[indexPath.item]!.size.width
     return cell
 }
 
 */
