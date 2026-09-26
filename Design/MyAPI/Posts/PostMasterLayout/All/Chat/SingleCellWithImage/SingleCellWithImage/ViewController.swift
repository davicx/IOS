//
//  ViewController.swift
//  SingleCellWithImage
//
//  Created by David Vasquez on 10/1/24.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    let imageNames = ["background_1", "background_2", "background_3", "background_4", "background_5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a cell class
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Add the table view to the view hierarchy
        view.addSubview(tableView)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count // Number of rows based on the image count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Set up the cell view with the corresponding image
        let imageName = imageNames[indexPath.row]
        cell.configure(with: imageName)
        
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateImageHeight(imageName: imageNames[indexPath.row])
    }
    
    // Function to calculate image height based on width and aspect ratio
    func calculateImageHeight(imageName: String) -> CGFloat {
        guard let image = UIImage(named: imageName) else {
            print("Image named \(imageName) not found")
            return 0
        }
        let screenWidth = UIScreen.main.bounds.width
        let aspectRatio = image.size.height / image.size.width
        return screenWidth * aspectRatio // Calculate height based on width
    }
}

class CustomTableViewCell: UITableViewCell {
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true // Ensure the image is clipped to the bounds
        iv.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView!)
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor) // Fill the cell
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageName: String) {
        imageView?.image = UIImage(named: imageName)
        if imageView!.image == nil {
            print("Failed to load image: \(imageName)")
        }
    }
}

