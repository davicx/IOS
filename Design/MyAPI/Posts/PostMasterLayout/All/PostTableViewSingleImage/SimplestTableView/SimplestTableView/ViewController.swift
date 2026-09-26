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
    
    struct Cells {
        static let postCell = "individualPostCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = fetchData()
        configureTableView()

    }
    
    func configureTableView() {
        view.addSubview(tableView)
        //set delegates
        setTableViewDelegates()

        //set row height
        tableView.rowHeight = 120
        //tableView.rowHeight = UITableView.automaticDimension
        
        //register cells
        tableView.register(IndividualPostViewCell.self, forCellReuseIdentifier: Cells.postCell)

        //set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "individualPostCell") as! IndividualPostViewCell

        cell.setUser(currentUser: currentUser)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //Get Image
        let currentUserImage = users[indexPath.row].userImage
        let currentImageHeight = currentUserImage.size.height
        let currentImageWidth = currentUserImage.size.width
        let screenSize: CGRect = UIScreen.main.bounds
        let imageCrop = currentUserImage.getCropRatio()
        let correctImageHeight = CGFloat(tableView.frame.width / imageCrop)
        let correctImageWidth = CGFloat(tableView.frame.width)
        
        let cellHeight = correctImageHeight
        
        print("correctImageHeight \(correctImageHeight) correctImageWidth \(correctImageWidth)")
        //print("cellHeight \(cellHeight)")
        
        
        return 200


    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        print("you picked \(selectedUser.userName)!!")
    }

    
}


/*
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
 

 */
extension ViewController {
    func fetchData() -> [User] {
        let userOne = User(userImage: UIImage(named: "background_1")!, userName: "davey")
        let userTwo = User(userImage: UIImage(named: "background_8")!, userName: "sam")
        let userThree = User(userImage: UIImage(named: "background_3")!, userName: "HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures HIIII I am looking for someone to share in an adventure that I am arranging, and it's very difficult to find anyone. I should think so — in these parts! We are plain quiet folk and have no use for adventures")
        let userFour = User(userImage: UIImage(named: "background_4")!, userName: "merry")

        return [userOne, userTwo, userThree, userFour]
    }
}



/*

  import UIKit

 class ImageTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     let tableView = UITableView()
     let images: [UIImage] = [/* Your UIImages here */]

     override func viewDidLoad() {
         super.viewDidLoad()
         setupTableView()
     }

     func setupTableView() {
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ImageCell")
         view.addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return images.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
         cell.imageView?.image = images[indexPath.row]
         cell.imageView?.contentMode = .scaleAspectFit
         return cell
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         guard let image = images[indexPath.row] else { return 0 }
         let aspectRatio = image.size.height / image.size.width
         let width = tableView.bounds.width
         return width * aspectRatio
     }
 }


 */
