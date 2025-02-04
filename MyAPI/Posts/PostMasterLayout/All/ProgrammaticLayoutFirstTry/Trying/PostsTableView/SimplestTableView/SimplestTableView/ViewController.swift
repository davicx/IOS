//
//  ViewController.swift
//  SimplestTableView
//
//  Created by David Vasquez on 8/29/24.
//

import UIKit



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

        
        let postHeight = imageHeight + textHeight

        return postHeight
        
    }
    

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

