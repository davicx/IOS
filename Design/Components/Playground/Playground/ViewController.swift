//
//  ViewController.swift
//  Playground
//
//  Created by David Vasquez on 12/1/24.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        // Create the header view
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        // Create the left view
        let leftView = UIView()
        leftView.backgroundColor = .systemRed
        leftView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(leftView)
        
        // Create the middle view
        let middleView = UIView()
        middleView.backgroundColor = .systemGreen
        middleView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(middleView)
        
        // Create the right view
        let rightView = UIView()
        rightView.backgroundColor = .systemYellow
        rightView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(rightView)
        
        // Add constraints for the header view
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        // Add constraints for the left view
        NSLayoutConstraint.activate([
            leftView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            leftView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            leftView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            leftView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add constraints for the right view
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            rightView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            rightView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            rightView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add constraints for the middle view
        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            middleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            middleView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 20),
            middleView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: -20)
        ])
    }
}


//EXAMPLE 1: Table View with Header
/*
class ViewController: UIViewController {

    // Table view and data source
    let tableView = UITableView()
    let hobbitNames = ["Frodo Baggins", "Samwise Gamgee", "Peregrin Took", "Meriadoc Brandybuck"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Register the header view
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    // Create a simple header view
    func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        headerView.backgroundColor = UIColor.systemBlue
        
        let label = UILabel(frame: headerView.bounds)
        label.text = "Hobbit List"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        headerView.addSubview(label)
        
        return headerView
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hobbitNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = hobbitNames[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // Row height
    }
}
 */
