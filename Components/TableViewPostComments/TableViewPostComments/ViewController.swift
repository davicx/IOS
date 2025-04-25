//
//  ViewController.swift
//  TableViewPostComments
//
//  Created by David Vasquez on 4/24/25.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let comments = [
        "This is amazing!",
        "Love the vibes ",
        "Where did you take this?",
        "So wholesome ",
        "Let's go hiking!"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.separatorStyle = .none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.configure(with: "Hiya Sam!! What a sunny day! The weather is perfect! Wanna hike or garden?")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.configure(with: comments[indexPath.row - 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 500 : UITableView.automaticDimension
    }
}
 
