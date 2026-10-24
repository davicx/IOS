//
//  ItemList.swift
//  Kite
//
//  Profile Content tab. A table of one user's items.
//  Not implemented yet.
//

import UIKit

/*
 ItemList

 Shows that profile's items in the Content tab (your profile and a friend's profile).
 A UIView with a UITableView, same role as ListModule. The profile keeps the header,
 counts, and About Me. ItemList only fills the content area.

 Table
 - UITableView pinned to all edges
 - background Colors.feedBackground
 - separatorStyle .none
 - rowHeight automaticDimension
 - estimatedRowHeight 700
 - empty label "No items yet" when the array is empty

 Cell — copy HomeViewController's row, do not build a new cell
 - register ItemCell, reuse id "ItemCell"
 - cell.usesFeedCard = true
 - cell.configure(with: post)
 - ItemCell already lays out ItemHeader, ItemInfo, ItemFooter, and ItemBody
 - ItemCell already handles purchase, cancel purchase, and "someone else bought this"

 Tap
 - deselect the row
 - onItemSelected?(post) so the profile opens IndividualPostViewController
 - same handoff as Home: postID, and currentUserOwnsGroup from the list's createdBy
   compared with the logged-in user

 Data the profile passes in
 - configure(posts: [Post])
 - posts are already that user's items, with images loaded
 - image loading stays with the caller, the same steps PostDataController uses:
   createPostsArray, addPostImageToPostsArray, addGroupImageToPostsArray,
   addPostFromImageToPostsArray
 - ItemList does not call fetchAllWishlistItems or GET /items
   That call is the home feed: every user's items, newest 12 only

 Still needed before this can show a real list
 - a fetch for one user's items (post_from = that profile)
 - the profile calls configure(posts:) with that result
 - after a purchase change, reload the row (home reloads on .itemsFetched)
 */


final class ItemList: UIView, UITableViewDataSource, UITableViewDelegate {

    var onItemSelected: ((Post) -> Void)?

    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private var posts: [Post] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadRows),
            name: .itemsFetched,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadRows),
            name: .postUpdated,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func configure(posts: [Post]) {
        self.posts = posts
        emptyLabel.isHidden = !posts.isEmpty
        tableView.reloadData()
    }

    @objc private func reloadRows() {
        tableView.reloadData()
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.feedBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Colors.feedBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        addSubview(tableView)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No items yet"
        emptyLabel.font = Fonts.regular15
        emptyLabel.textColor = Colors.subtleGrayText
        emptyLabel.textAlignment = .center
        addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.usesFeedCard = true
        cell.configure(with: posts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < posts.count else { return }
        onItemSelected?(posts[indexPath.row])
    }
}
