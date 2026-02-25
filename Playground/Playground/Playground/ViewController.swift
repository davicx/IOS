//
//  ViewController.swift
//  Playground
//
//  Created by David Vasquez on 12/11/24.
//


import UIKit


struct StoreItem {
    let name: String
    let price: String
}

class ViewController: UIViewController {

    // MARK: - Data
    private var stores: [StoreItem] = [
        StoreItem(name: "Amazon", price: "$20"),
        StoreItem(name: "Target", price: "$18")
    ]

    // MARK: - UI
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)

    private let addContainerView = UIView()
    private let storeTextField = UITextField()
    private let priceTextField = UITextField()
    private let submitButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    private var addContainerHeightConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTableView()
        setupAddButton()
        setupAddContainer()
        setupConstraints()
    }

    // MARK: - Setup
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
    }

    private func setupAddButton() {
        addButton.setTitle("+ New Store", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        view.addSubview(addButton)
    }

    private func setupAddContainer() {
        addContainerView.backgroundColor = .secondarySystemBackground
        addContainerView.layer.cornerRadius = 12
        addContainerView.clipsToBounds = true
        view.addSubview(addContainerView)

        storeTextField.placeholder = "Store name"
        storeTextField.borderStyle = .roundedRect

        priceTextField.placeholder = "Price"
        priceTextField.borderStyle = .roundedRect

        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)

        [storeTextField, priceTextField, submitButton, cancelButton].forEach {
            addContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addContainerView.translatesAutoresizingMaskIntoConstraints = false

        addContainerHeightConstraint = addContainerView.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            // Add button
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Table
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addContainerView.topAnchor, constant: -8),

            // Add container
            addContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addContainerHeightConstraint,

            // Store field
            storeTextField.topAnchor.constraint(equalTo: addContainerView.topAnchor, constant: 12),
            storeTextField.leadingAnchor.constraint(equalTo: addContainerView.leadingAnchor, constant: 12),
            storeTextField.trailingAnchor.constraint(equalTo: addContainerView.trailingAnchor, constant: -12),

            // Price field
            priceTextField.topAnchor.constraint(equalTo: storeTextField.bottomAnchor, constant: 8),
            priceTextField.leadingAnchor.constraint(equalTo: storeTextField.leadingAnchor),
            priceTextField.trailingAnchor.constraint(equalTo: storeTextField.trailingAnchor),

            // Buttons
            submitButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 12),
            submitButton.leadingAnchor.constraint(equalTo: addContainerView.leadingAnchor, constant: 12),
            submitButton.bottomAnchor.constraint(equalTo: addContainerView.bottomAnchor, constant: -12),

            cancelButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: addContainerView.trailingAnchor, constant: -12)
        ])
    }

    // MARK: - Actions
    @objc private func didTapAdd() {
        showAddArea(true)
    }

    @objc private func didTapCancel() {
        showAddArea(false)
        clearInputs()
    }

    @objc private func didTapSubmit() {
        guard
            let name = storeTextField.text, !name.isEmpty,
            let price = priceTextField.text, !price.isEmpty
        else { return }

        stores.append(StoreItem(name: name, price: price))
        tableView.reloadData()

        clearInputs()
        showAddArea(false)
    }

    private func showAddArea(_ show: Bool) {
        addContainerHeightConstraint.constant = show ? 160 : 0

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    private func clearInputs() {
        storeTextField.text = nil
        priceTextField.text = nil
    }
}

// MARK: - Table DataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = stores[indexPath.row]
        cell.textLabel?.text = "\(item.name) \(item.price)"
        return cell
    }
}


/*
final class ViewController: UIViewController {

    // MARK: - UI

    private let searchContainer = UIView()
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    private let searchPlaceholderLabel = UILabel()

    private let separator = UIView()

    private let rowButton = UIButton(type: .system) // makes the row tappable

    private let avatarCircle = UIView()
    private let avatarIcon = UIImageView(image: UIImage(systemName: "paperplane.fill")) // stand-in for origami logo

    private let nameLabel = UILabel()
    private let handleLabel = UILabel()
    private let dateLabel = UILabel()

    private let previewLabel = UILabel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        buildSearchBar()
        buildRow()
        layoutUI()
    }

    // MARK: - Build

    private func buildSearchBar() {
        // Container (rounded light gray pill)
        searchContainer.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        searchContainer.layer.cornerRadius = 22
        searchContainer.layer.masksToBounds = true

        // Icon
        searchIcon.tintColor = UIColor(white: 0.55, alpha: 1.0)
        searchIcon.contentMode = .scaleAspectFit

        // Placeholder text
        searchPlaceholderLabel.text = "Search for people and groups"
        searchPlaceholderLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        searchPlaceholderLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)

        view.addSubview(searchContainer)
        searchContainer.addSubview(searchIcon)
        searchContainer.addSubview(searchPlaceholderLabel)
    }

    private func buildRow() {
        // Row button (no blue highlight)
        rowButton.backgroundColor = .clear
        rowButton.tintColor = .clear
        rowButton.showsTouchWhenHighlighted = false
        rowButton.adjustsImageWhenHighlighted = false

        // Optional: subtle highlight on touch (very light)
        rowButton.setBackgroundImage(imageWithColor(UIColor(white: 0.95, alpha: 1.0)), for: .highlighted)

        // Avatar circle
        avatarCircle.backgroundColor = UIColor.systemBlue
        avatarCircle.layer.cornerRadius = 28
        avatarCircle.layer.masksToBounds = true

        avatarIcon.tintColor = .white
        avatarIcon.contentMode = .scaleAspectFit

        // Name, handle, date
        nameLabel.text = "AzizDjan"
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .black

        handleLabel.text = "@A_AzizDjan"
        handleLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        handleLabel.textColor = UIColor(white: 0.55, alpha: 1.0)

        dateLabel.text = "12/2/19"
        dateLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        dateLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        dateLabel.textAlignment = .right

        // Preview line
        previewLabel.text = "You: You’re very welcome AzizDjan!"
        previewLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        previewLabel.textColor = UIColor(white: 0.55, alpha: 1.0)
        previewLabel.numberOfLines = 1

        // Separator line
        separator.backgroundColor = UIColor(white: 0.85, alpha: 1.0)

        view.addSubview(rowButton)
        view.addSubview(separator)

        rowButton.addSubview(avatarCircle)
        avatarCircle.addSubview(avatarIcon)

        rowButton.addSubview(nameLabel)
        rowButton.addSubview(handleLabel)
        rowButton.addSubview(dateLabel)
        rowButton.addSubview(previewLabel)

        // Tap action (optional)
        rowButton.addTarget(self, action: #selector(rowTapped), for: .touchUpInside)
    }

    // MARK: - Layout

    private func layoutUI() {
        [searchContainer, searchIcon, searchPlaceholderLabel,
         rowButton, avatarCircle, avatarIcon,
         nameLabel, handleLabel, dateLabel, previewLabel,
         separator].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        // Search pill
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            searchContainer.heightAnchor.constraint(equalToConstant: 52),

            searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 16),
            searchIcon.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),

            searchPlaceholderLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 10),
            searchPlaceholderLabel.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor, constant: 0),
            searchPlaceholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: searchContainer.trailingAnchor, constant: -14)
        ])

        // Row button area
        NSLayoutConstraint.activate([
            rowButton.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 14),
            rowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rowButton.heightAnchor.constraint(equalToConstant: 108)
        ])

        // Separator line (under search area like screenshot)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: rowButton.topAnchor, constant: -8),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])

        // Avatar
        NSLayoutConstraint.activate([
            avatarCircle.leadingAnchor.constraint(equalTo: rowButton.leadingAnchor, constant: 22),
            avatarCircle.centerYAnchor.constraint(equalTo: rowButton.centerYAnchor),
            avatarCircle.widthAnchor.constraint(equalToConstant: 56),
            avatarCircle.heightAnchor.constraint(equalToConstant: 56),

            avatarIcon.centerXAnchor.constraint(equalTo: avatarCircle.centerXAnchor),
            avatarIcon.centerYAnchor.constraint(equalTo: avatarCircle.centerYAnchor),
            avatarIcon.widthAnchor.constraint(equalToConstant: 28),
            avatarIcon.heightAnchor.constraint(equalToConstant: 28)
        ])

        // Top line: Name + Handle (left), Date (right)
        // We place name and handle on same baseline-ish, like the screenshot.
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarCircle.trailingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: rowButton.topAnchor, constant: 18),

            handleLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            handleLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),

            dateLabel.trailingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: -22),
            dateLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),

            // Make sure text doesn't collide with date
            handleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -10)
        ])

        // Preview line
        NSLayoutConstraint.activate([
            previewLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            previewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            previewLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: dateLabel.leadingAnchor,
                constant: -12
            )
        ])

    }

    // MARK: - Actions

    @objc private func rowTapped() {
        print("Row tapped")
    }

    // MARK: - Helpers

    private func imageWithColor(_ color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
*/

/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let commentView = UserCommentTemplate()
        commentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentView)
        
        commentView.configure(
            userName: "Bilbo",
            commentText: "This looks great! Love how reusable this is. This looks great! Love how reusable this is.",
            image: UIImage(named: "background_1")
        )
        
        NSLayoutConstraint.activate([
            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
}*/





//CALENDAR
/*
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    private var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.translatesAutoresizingMaskIntoConstraints = false

        // Basic style
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.weekdayTextColor = .systemBlue

        // Colors
        calendar.appearance.todayColor = .systemRed
        calendar.appearance.selectionColor = .systemBlue
        calendar.appearance.eventDefaultColor = .systemGreen
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleWeekendColor = .systemGray

        view.addSubview(calendar)

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    // Example delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
}
*/



//Basic
/*
class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    private var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Create calendar
        calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.translatesAutoresizingMaskIntoConstraints = false

        // Add to view
        view.addSubview(calendar)

        // Constraints
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    // Example delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
}
*/

/*
//SCROLL VIEW
class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupUsers()
        setupBlueView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // StackView inside ScrollView
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func setupUsers() {
        for i in 1...7 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "background_\(i)")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 50 // Half of 100
            imageView.layer.masksToBounds = true
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            stackView.addArrangedSubview(imageView)
        }
    }
    
    private func setupBlueView() {
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .systemBlue
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
 */




//MENU
/*
class ViewController: UIViewController {
    
    // Menu image (replace with your asset name if you want)
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.3.horizontal") // SF Symbol "hamburger" menu
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true // required for taps
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(menuImageView)
        
        // Center the menu icon
        NSLayoutConstraint.activate([
            menuImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 60),
            menuImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        menuImageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapMenu() {
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Animate "bounce" effect
        UIView.animate(withDuration: 0.15,
                       animations: {
            self.menuImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.menuImageView.transform = .identity
            }
        }
        
        print("Menu tapped!")
    }
}

*/


/*

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
*/

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
