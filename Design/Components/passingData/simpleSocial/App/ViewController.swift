//
//  ViewController.swift
//  simpleSocial
//
//  Created by David Vasquez on 5/22/25.
//

import UIKit


class ViewController: UIViewController {

    let tableView = UITableView()
    
    var users = [
        User(userName: "Frodo", totalLikes: 5),
        User(userName: "Sam", totalLikes: 3),
        User(userName: "Merry", totalLikes: 7)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func reloadTable() {
        tableView.reloadData()
    }
}


// MARK: - UserLikeDelegate
extension ViewController: UserLikeDelegate {
    func didUpdateLikes(for user: User) {
        print("didUpdateLikes is in ViewController")
        reloadTable()
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(user.userName) - Likes: \(user.totalLikes)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else {
            return
        }

        vc.user = selectedUser
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

