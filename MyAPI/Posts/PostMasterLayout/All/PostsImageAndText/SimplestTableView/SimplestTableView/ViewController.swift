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
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
    func createArray() -> [User] {
        let userOne = User(userImage: UIImage(named: "background_1")!, userName: "davey")
        let userTwo = User(userImage: UIImage(named: "background_8")!, userName: "sam")
        let userThree = User(userImage: UIImage(named: "background_3")!, userName: "HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures")
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
        
        //cell.userLabel.numberOfLines = 200
        //tableView.delegate?.tableView(users[indexPath.row], heightForRowAt: 120)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentImage = users[indexPath.row].userImage
        let currentImageHeight = users[indexPath.row].userImage.size.height
        let currentImageWidth = users[indexPath.row].userImage.size.width
        let screenSize: CGRect = UIScreen.main.bounds
        let imageCrop = currentImage.getCropRatio()
        let imageHeight = tableView.frame.width / imageCrop
        let cellHeight = tableView.frame.width / imageCrop
        
        
        //TEXT
        let text = users[indexPath.row].userName
        let font = UIFont.systemFont(ofSize: 17) // Use the font size of your UILabel
        let cellWidth = tableView.bounds.width // or specific width if you have constraints
        let textHeight = calculateHeightForText(text, width: cellWidth, font: font)
    
        print("imageHeight \(imageHeight) textHeight \(textHeight)")
        //HEIGHT
        //Image Height
        
        //Text Height
        
        let postHeight = imageHeight + textHeight

        return postHeight
        
    }
    
    
    
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let text = "Your text for the cell at index \(indexPath.row)"
         let cellWidth = tableView.bounds.width // or specific width if you have constraints
         let font = UIFont.systemFont(ofSize: 17) // Use the font size of your UILabel
         
         let textHeight = calculateHeightForText(text, width: cellWidth, font: font)
         
         // Add padding if needed
         return textHeight + 20 // Adjust padding as necessary
     }

     */

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser.userName)!!")
    }
    
    func calculateHeightForText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let textRect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return textRect.height
    }

    
}


extension UIImage {
    func getCropRatio () -> CGFloat {
        let widthRatio = CGFloat (self.size.width / self.size.height)
        return widthRatio
    }
}


/*
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
 {
     var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell;
     if(cell == nil)
     {
         cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "CELL")
         cell?.selectionStyle = UITableViewCellSelectionStyle.none
     }
     cell?.textLabel.font = UIFont.systemFontOfSize(15.0)
     cell?.textLabel.sizeToFit()
     cell?.textLabel.text = messageArray[indexPath.row]
     cell?.textLabel.numberOfLines = 0
     return cell!;
 }

 func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
 {
     var height:CGFloat = self.calculateHeightForString(messageArray[indexPath.row])
     return height + 70.0
 }

 func calculateHeight(inString:String) -> CGFloat
 {
     let messageString = inString
     let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)]

     let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)

     let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

     let requredSize:CGRect = rect
     return requredSize.height
 }

 */


  

/*
 //
 //  ViewController.swift
 //  SimplestTableView
 //
 //  Created by David Vasquez on 8/29/24.
 //

 import UIKit

 class ViewController: UIViewController {
     
     @IBOutlet weak var tableView: UITableView!
     var users = ["sam", "merry", "frodo", "david", "I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures. Nasty disturbing uncomfortable things! Make you late for dinner!"]

     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self
         
         //New
         tableView.estimatedRowHeight = 44
         tableView.rowHeight = UITableView.automaticDimension
         
         
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


 class IndividualPostViewCell: UITableViewCell {

     @IBOutlet weak var userLabel: UILabel!
     
     func setUser(currentUser: String) {
         userLabel.text = currentUser
         userLabel.numberOfLines = 0

     }

 }

 */

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
