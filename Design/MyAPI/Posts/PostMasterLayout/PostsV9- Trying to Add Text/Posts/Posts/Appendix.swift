//
//  Appendix.swift
//  Posts
//
//  Created by David Vasquez on 9/29/24.
//

import Foundation




/*
 //
 //  ViewController.swift
 //  UITableViewTutorialCustomCellsProgrammatic
 //
 //  Created by David Vasquez on 9/15/24.
 //

 import UIKit


 class ViewController: UIViewController {

     var tableView = UITableView()
     var videos: [Video] = []
     
     struct Cells {
         static let videoCell = "VideoCell"
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         videos = fetchData()
         configureTableView()
         title = "Hiya!"
     }
     
     func configureTableView() {
         view.addSubview(tableView)
         //set delegates
         setTableViewDelegates()

         //set row height
         tableView.rowHeight = 120
         
         //register cells
         tableView.register(VideoCell.self, forCellReuseIdentifier: Cells.videoCell)

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
         print("numberOfRowsInSection")
         return videos.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         print("cellForRowAt")
         let currentVideo = videos[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: Cells.videoCell) as! VideoCell
         cell.setVideo(video: currentVideo)
         
         return cell
     }
 }

 extension ViewController {
     func fetchData() -> [Video] {
         print("Get Videos!")
         let video1 = Video(image: Images.background_1, title: "Forever we are Lost")
         let video2 = Video(image: #imageLiteral(resourceName: "background_2"), title: "Catch the Sky")
         let video3 = Video(image: Images.background_2, title: "Southern Charm")
         let video4 = Video(image: #imageLiteral(resourceName: "background_4"), title: "Northern Lights")
         let video5 = Video(image: #imageLiteral(resourceName: "background_5"), title: "From below the twilight")
         let video6 = Video(image: #imageLiteral(resourceName: "background_1"), title: "From a Well Beside the Ocean")
         
         return [video1, video2, video3, video4, video5, video6]
     }
 }



 */


/*
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let image = postsArray[indexPath.row].postImage
    let aspectRatio = image.size.height / image.size.width
    let blueHeight = UIScreen.main.bounds.width * aspectRatio
    
    return 40 + blueHeight + 12 + 40// Total height calculation
}
 */
/*


//BODY: Image and Post
private let postImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .blue
    return imageView
}()

private let footerView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
}()




private let myTextLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
}()



private func setupViews() {
    addSubview(headerView)
    addSubview(postImageView)
    addSubview(textImageView)
    addSubview(footerView)
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    postImageView.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    textImageView.translatesAutoresizingMaskIntoConstraints = false
    myTextLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Set up textImageView
    textImageView.addSubview(myTextLabel)
    
    // Initial height constraint for blueImageView
    imageViewHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
    imageViewHeightConstraint?.isActive = true
    
    NSLayoutConstraint.activate([
        headerView.topAnchor.constraint(equalTo: topAnchor),
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        headerView.heightAnchor.constraint(equalToConstant: 4),

        postImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
        postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

        // Set textImageView below ImageView
        textImageView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
        textImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        textImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

        // Set height for textImageView based on the content
        textImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50), // Adjust as needed
        
        footerView.topAnchor.constraint(equalTo: textImageView.bottomAnchor, constant: 20),
        footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
        footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        footerView.heightAnchor.constraint(equalToConstant: 8),
        footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    // Label constraints
    NSLayoutConstraint.activate([
        myTextLabel.topAnchor.constraint(equalTo: textImageView.topAnchor),
        myTextLabel.leadingAnchor.constraint(equalTo: textImageView.leadingAnchor),
        myTextLabel.trailingAnchor.constraint(equalTo: textImageView.trailingAnchor),
        myTextLabel.bottomAnchor.constraint(equalTo: textImageView.bottomAnchor)
    ])
}
 */

/*
postImageView.image = image

// Update the imageView height based on image aspect ratio
let aspectRatio = image.size.height / image.size.width
let newHeight = UIScreen.main.bounds.width * aspectRatio

imageViewHeightConstraint?.constant = newHeight + 8

// Set the label text
myTextLabel.text = postCaption

layoutIfNeeded() // Ensure layout is updated immediately
 */


//APPENDIX
/*
 //
 //  VideoCell.swift
 //  UITableViewTutorialCustomCellsProgrammatic
 //
 //  Created by David Vasquez on 9/16/24.
 //

 import UIKit

 class VideoCell: UITableViewCell {
     var videoImageView = UIImageView()
     var videoTitleLabel = UILabel ()
     
     

     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(videoImageView)
         addSubview(videoTitleLabel)
         configureImageView()
         configureTitleLabel()
         setImageConstraints()
         setTitleLabelConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func configureImageView() {
         videoImageView.layer.cornerRadius = 10
         videoImageView.clipsToBounds = true
     }
     
     func configureTitleLabel () {
         videoTitleLabel.numberOfLines = 0
         videoTitleLabel.adjustsFontSizeToFitWidth = true
     }
     
     
     //Leading = Left
     //Trailing = Right (This must be negative)
     func setImageConstraints () {
         videoImageView.translatesAutoresizingMaskIntoConstraints = false
         videoImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12) .isActive = true
         videoImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
         videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier:16/9).isActive = true
     }
     
     func setTitleLabelConstraints () {
         videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
         videoTitleLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
         //Pin This to the image
         videoTitleLabel.leadingAnchor.constraint(equalTo:videoImageView.trailingAnchor,constant:20).isActive = true
         videoTitleLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
         videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
     }
 }



 */
