//
//  ViewController.swift
//  SingleViewVariableHeight
//
//  Created by David Vasquez on 10/1/24.
//
import UIKit


//WORKING 2: With Delay
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var cellHeights: [CGFloat] = [] // Array to hold heights

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
        
        // Fetch heights from the mock API
        fetchCellHeights { heights in
            self.cellHeights = heights
            DispatchQueue.main.async {
                self.tableView.reloadData() // Reload table view with fetched heights
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellHeights.count // Number of rows based on the array count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Set up the cell view with the corresponding height
        let height = cellHeights[indexPath.row]
        cell.configure(with: height)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row] + 4 // Add 4 points for bottom space
    }
    
    // Mock API call
    func fetchCellHeights(completion: @escaping ([CGFloat]) -> Void) {
        DispatchQueue.global().async {
            // Simulate network delay
            sleep(1) // Simulates a 1-second delay
            // Generate mock heights
            let heights: [CGFloat] = [100, 120, 80, 150, 200, 90, 130, 110, 140, 160]
            completion(heights)
        }
    }
}



//WORKING 1
/*
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    
    // Array of heights for the cells
    let cellHeights: [CGFloat] = [100, 120, 80, 150, 200]

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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellHeights.count // Number of rows based on the array count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Set up the cell view with the corresponding height
        let height = cellHeights[indexPath.row]
        cell.configure(with: height)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row] + 4 // Add 4 points for bottom space
    }
}
*/



