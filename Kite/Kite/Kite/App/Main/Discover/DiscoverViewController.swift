//
//  DiscoverViewController.swift
//  Kite
//
//  Created by David Vasquez on 9/19/25.
//

import UIKit


class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    // Placeholder results
    private let results = [
        "Frodo Baggins",
        "Gandalf the Grey",
        "Aragorn son of Arathorn"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTableView()
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        printPageInfo(vcName: "DiscoverViewController")
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Register a basic cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self

        // Set as table header
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }

    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }

    // MARK: - UISearchBarDelegate (for later filtering)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Eventually filter results here
        print("Searching for: \(searchText)")
    }
}

/*
class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

     private let tableView = UITableView()
     private let searchBar = UISearchBar()

     // Placeholder results
     private let results = [
         "Frodo Baggins",
         "Gandalf the Grey",
         "Aragorn son of Arathorn"
     ]

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
 
        printPageInfo(vcName: "DiscoverViewController")
 

         setupTableView()
         setupSearchBar()
     }

     private func setupTableView() {
         tableView.delegate = self
         tableView.dataSource = self
         tableView.translatesAutoresizingMaskIntoConstraints = false

         // Register a basic cell
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

         view.addSubview(tableView)

         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }

     private func setupSearchBar() {
         searchBar.placeholder = "Search"
         searchBar.searchBarStyle = .minimal
         searchBar.delegate = self

         // Set as table header
         searchBar.sizeToFit()
         tableView.tableHeaderView = searchBar
     }

     // MARK: - UITableView DataSource
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return results.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = results[indexPath.row]
         return cell
     }

     // MARK: - UISearchBarDelegate (for later filtering)
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         // Eventually filter results here
         print("Searching for: \(searchText)")
     }
}

*/
