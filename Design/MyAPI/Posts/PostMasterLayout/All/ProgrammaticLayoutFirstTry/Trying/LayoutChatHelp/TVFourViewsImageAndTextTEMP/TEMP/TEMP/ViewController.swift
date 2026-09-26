//
//  ViewController.swift
//  TEMP
//
//  Created by David Vasquez on 9/24/24.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private var imageHeights: [UIImage] = [] // Store your images

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: "ColorCell")
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        fetchData() // Load your images
    }

    func fetchData() {
        // Simulate loading images
        imageHeights = [
            UIImage(named: "background_1")!,
            UIImage(named: "background_2")!,
            UIImage(named: "background_3")!,
            UIImage(named: "tall")!,
            UIImage(named: "long")!
        ]
        
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageHeights.count // Use the count of images
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorTableViewCell
        let image = imageHeights[indexPath.row]
        
        // Example text for each cell; you can customize this
        let text = "Sample text for row Sample text for row Sample text for row Sample text for row Sample text for row Sample text for row Sample text for row Sample text for row Sample text for row \(indexPath.row + 1)"
        
        cell.configure(with: image, text: text)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = imageHeights[indexPath.row]
        let aspectRatio = image.size.height / image.size.width
        let blueHeight = UIScreen.main.bounds.width * aspectRatio
        
        return 40 + blueHeight + 12 + 40// Total height calculation
    }
}


//NEW
/*

 */
