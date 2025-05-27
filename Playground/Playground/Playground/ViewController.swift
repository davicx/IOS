//
//  ViewController.swift
//  Playground
//
//  Created by David Vasquez on 12/11/24.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let segmentedControl = UISegmentedControl(items: ["Hobbits", "Elves"])

    let hobbitNames = ["Frodo", "Samwise", "Merry", "Pippin"]
    let elvenNames = ["Legolas", "Elrond", "Galadriel", "Thranduil"]

    var currentData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupSegmentedControl()
        setupTableView()

        // Default selection
        segmentedControl.selectedSegmentIndex = 0
        currentData = hobbitNames
    }

    @objc private func segmentChanged() {
        currentData = segmentedControl.selectedSegmentIndex == 0 ? hobbitNames : elvenNames
        tableView.reloadData()
    }

    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemBlue
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Create a wrapper view to size the header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        segmentedControl.frame = CGRect(x: 16, y: 8, width: view.frame.width - 32, height: 34)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentData[indexPath.row]
        return cell
    }
}


//WORKS
/*
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct User {
        let username: String
        let fullName: String
        let imageName: String
        var isFollowing: Bool
    }

    class UserCell: UITableViewCell {
        static let identifier = "UserCell"

        let profileImageView = UIImageView()
        let usernameLabel = UILabel()
        let fullNameLabel = UILabel()
        let followButton = UIButton(type: .system)

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 24
            profileImageView.clipsToBounds = true

            usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false

            fullNameLabel.font = UIFont.systemFont(ofSize: 14)
            fullNameLabel.textColor = .gray
            fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

            followButton.translatesAutoresizingMaskIntoConstraints = false
            followButton.layer.cornerRadius = 6
            followButton.clipsToBounds = true
            followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

            contentView.addSubview(profileImageView)
            contentView.addSubview(usernameLabel)
            contentView.addSubview(fullNameLabel)
            contentView.addSubview(followButton)

            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 48),
                profileImageView.heightAnchor.constraint(equalToConstant: 48),

                usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),

                fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
                fullNameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),

                followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        func configure(with user: User) {
            profileImageView.image = UIImage(named: user.imageName)
            usernameLabel.text = user.username
            fullNameLabel.text = user.fullName
            let title = user.isFollowing ? "Following" : "Follow"
            followButton.setTitle(title, for: .normal)
            followButton.backgroundColor = user.isFollowing ? .white : UIColor.systemRed
            followButton.setTitleColor(user.isFollowing ? .black : .white, for: .normal)
            followButton.layer.borderWidth = user.isFollowing ? 1 : 0
            followButton.layer.borderColor = user.isFollowing ? UIColor.lightGray.cgColor : nil
        }
    }

    private let tableView = UITableView()
    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Followers"

        setupUsers()
        setupTableView()
    }

    private func setupUsers() {
        let imageNames = ["background_1", "background_2", "background_3"]
        for i in 0..<10 {
            users.append(User(
                username: "user\(i)",
                fullName: "Full Name \(i)",
                imageName: imageNames[i % 3],
                isFollowing: i % 2 == 0
            ))
        }
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 72
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(with: user)
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    @objc private func followButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        users[index].isFollowing.toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

 */
/*
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
 */



/*
class ViewController: UIViewController {
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        //setupConstraints()
        setBackgroundImage()
    }
    
    
    private func setBackgroundImage() {
         let backgroundImage = UIImageView(frame: view.bounds)
         backgroundImage.image = UIImage(named: "background_2")
         backgroundImage.contentMode = .scaleAspectFill
         backgroundImage.clipsToBounds = true
         backgroundImage.translatesAutoresizingMaskIntoConstraints = false

         view.insertSubview(backgroundImage, at: 0) // Places it behind all other views

         NSLayoutConstraint.activate([
             backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
             backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
    
    
    
    
    // MARK: - UI Elements
    // Status Bar Elements
    private let statusBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:41"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signalIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right") // Signal icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wifiIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wifi") // Wi-Fi icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let batteryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "battery.75") // Battery icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Main Content
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Evently"
        label.font = UIFont(name: "Billabong", size: 50) ?? UIFont.systemFont(ofSize: 50) // Approx Instagram font
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder") // Replace with your image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "jacob_w"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0) // Instagram blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let switchAccountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Switch accounts"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(statusBarView)
        statusBarView.addSubview(timeLabel)
        statusBarView.addSubview(signalIcon)
        statusBarView.addSubview(wifiIcon)
        statusBarView.addSubview(batteryIcon)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(loginButton)
        view.addSubview(switchAccountsLabel)
        view.addSubview(signUpLabel)
        
        // Add tap gesture to switch accounts label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchAccountsTapped))
        switchAccountsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        // Status Bar Constraints
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 20), // Status bar height
            
            timeLabel.centerXAnchor.constraint(equalTo: statusBarView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            
            signalIcon.trailingAnchor.constraint(equalTo: wifiIcon.leadingAnchor, constant: -8),
            signalIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            signalIcon.widthAnchor.constraint(equalToConstant: 15),
            signalIcon.heightAnchor.constraint(equalToConstant: 15),
            
            wifiIcon.trailingAnchor.constraint(equalTo: batteryIcon.leadingAnchor, constant: -8),
            wifiIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            wifiIcon.widthAnchor.constraint(equalToConstant: 15),
            wifiIcon.heightAnchor.constraint(equalToConstant: 15),
            
            batteryIcon.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor, constant: -8),
            batteryIcon.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            batteryIcon.widthAnchor.constraint(equalToConstant: 25),
            batteryIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        // Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: statusBarView.bottomAnchor, constant: 100) // Adjusted for image
        ])
        
        // Profile Image Constraints
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Username Label Constraints
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
        ])
        
        // Login Button Constraints
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Switch Accounts Label Constraints
        NSLayoutConstraint.activate([
            switchAccountsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchAccountsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
        
        // Sign Up Label Constraints
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func switchAccountsTapped() {
        print("Switch accounts tapped")
        // Add switch accounts logic here
    }
}
*/
