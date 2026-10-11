//
//  ListModule.swift
//  Kite
//

import UIKit


// Profile lists. The profile controller supplies the groups.
final class ListModule: UIView, UITableViewDataSource, UITableViewDelegate {

    var onListSelected: ((GroupModel) -> Void)?

    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private let listCellReuseID = "GroupTableViewCell"
    private var lists: [GroupModel] = []
    private var currentUser = ""
    private var memberProfiles: [String: User] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(lists: [GroupModel], currentUser: String, memberProfiles: [String: User]) {
        self.lists = lists
        self.currentUser = currentUser
        self.memberProfiles = memberProfiles
        emptyLabel.text = "No lists yet"
        emptyLabel.isHidden = !lists.isEmpty
        tableView.reloadData()
    }

    func showLoadFailed() {
        lists = []
        emptyLabel.text = "Couldn't load lists"
        emptyLabel.isHidden = false
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
        tableView.estimatedRowHeight = 144
        tableView.register(GroupCell.self, forCellReuseIdentifier: listCellReuseID)
        addSubview(tableView)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No lists yet"
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
        return lists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellReuseID, for: indexPath) as! GroupCell
        cell.setupGroupListCell(
            with: lists[indexPath.row],
            currentUser: currentUser,
            memberProfiles: memberProfiles
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < lists.count else { return }
        onListSelected?(lists[indexPath.row])
    }
}
