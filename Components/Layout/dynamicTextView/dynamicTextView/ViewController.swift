//
//  ViewController.swift
//  dynamicTextView
//
//  Created by David Vasquez on 10/11/24.
//

import UIKit


class MockAPI {
    func fetchData(completion: @escaping ([String]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let mockData = [
                "Hello, World!",
                "Swift is great.",
                "Table views are useful.",
                "This is a dynamic table.",
                "Fetch data asynchronously and see how it adapts."
            ]
            completion(mockData)
        }
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var data: [String] = []
    private let cellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44 // Estimate for performance
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        
        // Auto Layout Constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        let api = MockAPI()
        api.fetchData { [weak self] fetchedData in
            DispatchQueue.main.async {
                self?.data = fetchedData
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.label.text = data[indexPath.row]
        return cell
    }
}

// Custom UITableViewCell
class CustomTableViewCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow for multiple lines
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        // Auto Layout for label
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 


