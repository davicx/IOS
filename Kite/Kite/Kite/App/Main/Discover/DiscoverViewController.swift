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
    private let searchAPI = SearchAPI.shared
    private let userDefaultManager = UserDefaultManager()
    
    // Dynamic search results
    private var searchResults: [FriendSearchModel] = []

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
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let friend = searchResults[indexPath.row]
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName) (@\(friend.friendName))"
        return cell
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Trigger search if 2 or more characters are typed
        if searchText.count >= 2 {
            searchFriends(searchText: searchText)
        }
    }
    
    // MARK: - Search Function
    private func searchFriends(searchText: String) {
        print("Searching for friends with: '\(searchText)'")
        
        Task {
            do {
                let currentUser = userDefaultManager.getLoggedInUser()
                let response = try await searchAPI.searchFriends(username: currentUser, searchString: searchText)
                
                DispatchQueue.main.async {
                    self.searchResults = response.data
                    self.tableView.reloadData()
                    print("Found \(response.data.count) friends")
                }
                
            } catch {
                print("Search failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.searchResults = []
                    self.tableView.reloadData()
                }
            }
        }
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
