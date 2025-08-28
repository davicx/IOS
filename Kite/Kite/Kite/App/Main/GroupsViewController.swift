//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit


//GROUPS (Lists): Wishlist
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("________________________")
        print("GroupsViewController")
        print("LISTS: Wishlist")
        print("________________________")
        print(" ")
        
        setupNavigationBar()   // ✅ add navigation bar setup
        setupTableView()
        fetchGroups()
        
        // Listen for group updates
        GroupDataController.shared.onGroupsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("________________________")
        print("GroupsViewController")
        print("LISTS: Wishlist")
        print("________________________")
        print(" ")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGroups()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    // MARK: - NAVIGATION BAR
    private func setupNavigationBar() {
        // Title in the middle
        navigationItem.title = "Wishlist"

        // Right bar button: "+"
        let createGroupButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openCreateGroup)
        )
        navigationItem.rightBarButtonItem = createGroupButton

        // Left bar button: profile (circular)
        if let image = UIImage(named: "user") {
            // Resize + crop circle
            let circularImage = makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
                .withRenderingMode(.alwaysOriginal)

            let profileButton = UIBarButtonItem(
                image: circularImage,
                style: .plain,
                target: self,
                action: #selector(openProfile)
            )
            navigationItem.leftBarButtonItem = profileButton
        }
    }

    // Helper: resize + circular crop
    private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(ovalIn: rect).addClip()   // circular mask
            image.draw(in: rect)
        }
    }

    // Helper function to resize
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }


    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }
    
    @objc private func openProfile() {
        print("Profile tapped")
        // push profile screen here if you want
    }
    
    /*
    // MARK: - TABLE VIEW
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Header with segmented control
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground

        let segmentedControl = UISegmentedControl(items: ["My Lists", "Shared With Me"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        headerView.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.8)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // My Lists → show groups
            fetchGroups()
        } else {
            // Shared With Me → placeholder
            groups = [] // clear existing data
            tableView.reloadData()
            
            // Show a single "Coming Soon" cell
            let placeholderLabel = UILabel()
            placeholderLabel.text = "Coming Soon..."
            placeholderLabel.textAlignment = .center
            placeholderLabel.font = .italicSystemFont(ofSize: 16)
            placeholderLabel.textColor = .secondaryLabel
            tableView.backgroundView = placeholderLabel
        }
    }
    */

    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        //  Keep your custom table header
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let headerLabel = UILabel()
        headerLabel.text = "Table Header Placeholder"
        headerLabel.font = .boldSystemFont(ofSize: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupDataController.shared.groups.count
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups.isEmpty && (tableView.backgroundView != nil) {
            return 0
        }
        tableView.backgroundView = nil
        return GroupDataController.shared.groups.count
    }
     */

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = GroupDataController.shared.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = GroupDataController.shared.groups[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
}

//WISHLIST: working backup
/*
 
 
 class GroupsViewController: UIViewController {

     let groupsAPI = GroupsAPI()
     let userDefaultManager = UserDefaultManager()

     private var groups: [GroupModel] = []
     private let tableView = UITableView()

     override func viewDidLoad() {
         super.viewDidLoad()
         print("________________________")
         print("GroupsViewController")
         print("LISTS: Wishlist")
         print("________________________")
         print(" ")
         
         setupNavigationBar()   // ✅ add navigation bar setup
         setupTableView()
         fetchGroups()
         
         // Listen for group updates
         GroupDataController.shared.onGroupsUpdated = { [weak self] in
             DispatchQueue.main.async {
                 self?.tableView.reloadData()
             }
         }
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         print("________________________")
         print("GroupsViewController")
         print("LISTS: Wishlist")
         print("________________________")
         print(" ")
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         fetchGroups()
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         GroupDataController.shared.onGroupsUpdated = nil
     }
     
     // MARK: - NAVIGATION BAR
     private func setupNavigationBar() {
         // Title in the middle
         navigationItem.title = "Wishlist"

         // Right bar button: "+"
         let createGroupButton = UIBarButtonItem(
             barButtonSystemItem: .add,
             target: self,
             action: #selector(openCreateGroup)
         )
         navigationItem.rightBarButtonItem = createGroupButton

         // Left bar button: profile (circular)
         if let image = UIImage(named: "user") {
             // Resize + crop circle
             let circularImage = makeCircularImage(image: image, size: CGSize(width: 28, height: 28))
                 .withRenderingMode(.alwaysOriginal)

             let profileButton = UIBarButtonItem(
                 image: circularImage,
                 style: .plain,
                 target: self,
                 action: #selector(openProfile)
             )
             navigationItem.leftBarButtonItem = profileButton
         }
     }

     // Helper: resize + circular crop
     private func makeCircularImage(image: UIImage, size: CGSize) -> UIImage {
         let renderer = UIGraphicsImageRenderer(size: size)
         return renderer.image { _ in
             let rect = CGRect(origin: .zero, size: size)
             UIBezierPath(ovalIn: rect).addClip()   // circular mask
             image.draw(in: rect)
         }
     }

     // Helper function to resize
     private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
         let renderer = UIGraphicsImageRenderer(size: targetSize)
         return renderer.image { _ in
             image.draw(in: CGRect(origin: .zero, size: targetSize))
         }
     }


     @objc private func openCreateGroup() {
         let createVC = CreateGroupViewController()
         createVC.modalPresentationStyle = .pageSheet
         present(createVC, animated: true)
     }
     
     @objc private func openProfile() {
         print("Profile tapped")
         // push profile screen here if you want
     }
     
     // MARK: - TABLE VIEW
     private func setupTableView() {
         view.addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
         tableView.rowHeight = 220
         tableView.tableFooterView = UIView()

         // ✅ Keep your custom table header
         let headerView = UIView()
         headerView.backgroundColor = .lightGray

         let headerLabel = UILabel()
         headerLabel.text = "Table Header Placeholder"
         headerLabel.font = .boldSystemFont(ofSize: 18)
         headerLabel.translatesAutoresizingMaskIntoConstraints = false

         headerView.addSubview(headerLabel)
         NSLayoutConstraint.activate([
             headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
         ])

         headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
         tableView.tableHeaderView = headerView

         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
     
     private func fetchGroups() {
         GroupDataController.shared.getGroups {
             self.tableView.reloadData()
         }
     }
 }

 extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return GroupDataController.shared.groups.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let group = GroupDataController.shared.groups[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
         cell.configure(with: group)
         return cell
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let group = GroupDataController.shared.groups[indexPath.row]
         let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
         guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
         vc.group = group
         navigationController?.pushViewController(vc, animated: true)
     }
 }

 
 */


/*
//WORKING
//GROUPS: Kite
class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("________________________")
        print("GroupsViewController")
        print("________________________")
        
        setupTableView()
        fetchGroups()
        
        // Listen for group updates
        GroupDataController.shared.onGroupsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("________________________")
        print("GroupsViewController")
        print("________________________")
    }

 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh groups when view appears to ensure data is up to date
        fetchGroups()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clean up the callback to prevent memory leaks
        GroupDataController.shared.onGroupsUpdated = nil
    }
    
    
    //FUNCTIONS
    //Functions A: Table View
    //Function A1: Setup the Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupTableViewCell")
        tableView.rowHeight = 220
        tableView.tableFooterView = UIView()

        // Custom Header View
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        // Header Label
        let headerLabel = UILabel()
        headerLabel.text = "Groups"
        headerLabel.font = .boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Create Group Button
        let createGroupButton = UIButton(type: .system)
        createGroupButton.setTitle("+", for: .normal)
        createGroupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        createGroupButton.setTitleColor(.systemBlue, for: .normal)
        createGroupButton.translatesAutoresizingMaskIntoConstraints = false
        createGroupButton.addTarget(self, action: #selector(openCreateGroup), for: .touchUpInside)

        headerView.addSubview(headerLabel)
        headerView.addSubview(createGroupButton)

        // Header layout
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            createGroupButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            createGroupButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        tableView.tableHeaderView = headerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func openCreateGroup() {
        let createVC = CreateGroupViewController()
        createVC.modalPresentationStyle = .pageSheet
        present(createVC, animated: true)
    }

    //Functions B: API Functions
    //Function B1: Get all the Groups
    private func fetchGroups() {
        GroupDataController.shared.getGroups {
            self.tableView.reloadData()
        }
    }

}


extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupDataController.shared.groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = GroupDataController.shared.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = GroupDataController.shared.groups[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
*/
