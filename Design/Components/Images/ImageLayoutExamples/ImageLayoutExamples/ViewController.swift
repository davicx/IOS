//
//  ViewController.swift
//  ImageLayoutExamples
//
//  Created by David Vasquez on 7/19/25.
//

import UIKit


class ViewController: UIViewController {

    private let tableView = UITableView()

    private let images = ["background_1", "background_2", "background_3"]
    private let modes: [(UIView.ContentMode, String)] = [
        (.scaleAspectFit, "Aspect Fit"),
        (.scaleAspectFill, "Aspect Fill"),
        (.scaleToFill, "Scale To Fill")
    ]

    private var displayItems: [(String, UIView.ContentMode, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        prepareDisplayItems()
    }

    private func prepareDisplayItems() {
        for imageName in images {
            for (mode, modeName) in modes {
                displayItems.append((imageName, mode, modeName))
            }
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageDisplayCell.self, forCellReuseIdentifier: "ImageDisplayCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDisplayCell", for: indexPath) as? ImageDisplayCell else {
            return UITableViewCell()
        }

        let (imageName, contentMode, label) = displayItems[indexPath.row]
        cell.configure(imageName: imageName, contentMode: contentMode, labelText: label)
        return cell
    }
}

/*
 1. .scaleAspectFit

     Preserves original image proportions ✅

     No distortion ❌

     Behavior: Scales the image to fit within the UIImageView bounds without cropping.

     Result: Entire image is visible, but you may get letterboxing (empty space on sides or top/bottom).

 ✅ 2. .scaleAspectFill

     Preserves original image proportions ✅

     No distortion ❌

     Behavior: Scales the image to fill the UIImageView bounds, cropping as needed.

     Result: The image fills the view, but parts may be cropped.

 ❌ 3. .scaleToFill

     Does not preserve original image proportions ❌

     Can distort the image ✅

     Behavior: Stretches or squashes the image to exactly fill the bounds.

     Result: The image is fully visible, but distorted if the aspect ratio of the image and view don't match.

 Summary Table:
 Content Mode    Keeps Proportions    Can Distort    May Crop    May Have Empty Space
 .scaleAspectFit    ✅ Yes    ❌ No    ❌ No    ✅ Yes (if not same aspect)
 .scaleAspectFill    ✅ Yes    ❌ No    ✅ Yes    ❌ No
 .scaleToFill    ❌ No    ✅ Yes    ❌ No    ❌ No
 */
