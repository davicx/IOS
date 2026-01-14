//
//  ComparingGroupVCs.swift
//  Temporary Analysis File
//
//  This file compares IndividualGroupUserViewController and IndividualGroupFriendViewController
//  to understand how to consolidate them into one VC using a boolean flag
//

import UIKit

/*
================================================================================
KEY DIFFERENCES BETWEEN THE TWO VIEW CONTROLLERS
================================================================================

1. CELL IDENTIFIER & TYPE
   - User: "GroupItemUserCell" (GroupItemUserCell)
   - Friend: "GroupItemFriendCell" (GroupItemFriendCell)

2. NOTIFICATION OBSERVERS
   - User: .itemUpdated → itemUpdated()
   - Friend: .itemsFetched → itemsUpdated()

3. VIEW WILL APPEAR
   - User: Only fetchItemsForGroup() (reloadData called inside fetchItemsForGroup)
   - Friend: fetchItemsForGroup() + tableView.reloadData()

4. TABLE VIEW SETUP
   - User: tableView.separatorStyle = .none
   - Friend: No separatorStyle setting

5. DATA FILTERING
   - User: Shows ALL posts from getPostsForGroup(groupID:) (no filter)
   - Friend: Filters to show only items: .filter { $0.postType == "item" }

6. NAVIGATION ON CELL TAP
   - User: Navigates to IndividualPostViewController
   - Friend: Navigation commented out, prints "Right now cant navigate to new item"

7. FETCH ITEMS LOGGING
   - User: Prints all posts (no filter)
   - Friend: Filters and prints only items

================================================================================
CONSOLIDATED STRUCTURE (PSEUDOCODE)
================================================================================

class ConsolidatedGroupViewController: UIViewController {
    
    // NEW PROPERTY: Boolean flag to differentiate behavior
    var isUserOwnedGroup: Bool = false // true = User's own groups, false = Friend's shared groups
    
    var group: GroupModel?
    let postDataController = PostDataController.shared
    let usersDataController = UsersDataController.shared
    private var groupMembers: [User] = []
    private let tableView = UITableView()
    private let pollingManager = PollingManager()
    
    // COMPUTED PROPERTY: Cell identifier based on boolean
    private var cellIdentifier: String {
        return isUserOwnedGroup ? "GroupItemUserCell" : "GroupItemFriendCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        
        pollingManager.onFetchPosts = { [weak self] in
            self?.fetchItemsForGroup()
        }
        pollingManager.startPolling()
        
        if let group = group {
            Task {
                await fetchGroupMemberProfiles()
            }
        }
        
        // CONDITIONAL: Notification observer based on boolean
        if isUserOwnedGroup {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(itemUpdated),
                name: .itemUpdated,
                object: nil
            )
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(itemsUpdated),
                name: .itemsFetched,
                object: nil
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsForGroup()
        // CONDITIONAL: Friend VC also calls reloadData here
        if !isUserOwnedGroup {
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        // CONDITIONAL: Cell identifier based on boolean
        tableView.register(isUserOwnedGroup ? GroupItemUserCell.self : GroupItemFriendCell.self, 
                          forCellReuseIdentifier: cellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.tableHeaderView = createTableHeader()
        tableView.tableFooterView = UIView()
        
        // CONDITIONAL: Separator style only for User VC
        if isUserOwnedGroup {
            tableView.separatorStyle = .none
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchItemsForGroup() {
        guard let groupID = group?.groupID else { return }
        
        Task {
            await postDataController.fetchItems(groupID: groupID)
            
            DispatchQueue.main.async {
                let posts = self.postDataController.getPostsForGroup(groupID: groupID)
                
                // CONDITIONAL: Filtering based on boolean
                if self.isUserOwnedGroup {
                    // User: Show all posts (no filter)
                    print("Total posts: \(posts.count)")
                    for post in posts {
                        print("- Item Name: \(post.itemName ?? "No Name"), PostID: \(post.postID)")
                    }
                } else {
                    // Friend: Show only items
                    let items = posts.filter { $0.postType == "item" }
                    print("Total items fetched: \(items.count)")
                    for item in items {
                        print("- Item Name: \(item.itemName ?? "No Name"), PostID: \(item.postID)")
                    }
                }
                
                // CONDITIONAL: Reload only for User VC
                if self.isUserOwnedGroup {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // BOTH notification handlers (choose based on boolean in viewDidLoad)
    @objc private func itemUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func itemsUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ConsolidatedGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groupID = group?.groupID else { return 0 }
        let posts = postDataController.getPostsForGroup(groupID: groupID)
        
        // CONDITIONAL: Filtering based on boolean
        if isUserOwnedGroup {
            return posts.count // User: all posts
        } else {
            return posts.filter { $0.postType == "item" }.count // Friend: only items
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupID = group?.groupID else {
            return UITableViewCell()
        }
        
        let posts = postDataController.getPostsForGroup(groupID: groupID)
        let displayPosts: [Post]
        
        // CONDITIONAL: Filtering based on boolean
        if isUserOwnedGroup {
            displayPosts = posts // User: all posts
        } else {
            displayPosts = posts.filter { $0.postType == "item" } // Friend: only items
        }
        
        let post = displayPosts[indexPath.row]
        
        // CONDITIONAL: Cell type based on boolean
        if isUserOwnedGroup {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupItemUserCell", for: indexPath) as! GroupItemUserCell
            cell.configurePost(with: post)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupItemFriendCell", for: indexPath) as! GroupItemFriendCell
            cell.configurePost(with: post)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let groupID = group?.groupID else { return }
        let posts = postDataController.getPostsForGroup(groupID: groupID)
        let displayPosts: [Post]
        
        // CONDITIONAL: Filtering based on boolean
        if isUserOwnedGroup {
            displayPosts = posts
        } else {
            displayPosts = posts.filter { $0.postType == "item" }
        }
        
        let post = displayPosts[indexPath.row]
        
        // CONDITIONAL: Navigation based on boolean
        if isUserOwnedGroup {
            // User: Navigate to IndividualPostViewController
            let storyboard = UIStoryboard(name: "Post", bundle: nil)
            if let postViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualPostViewControllerID) as? IndividualPostViewController {
                postViewController.postID = post.postID
                navigationController?.pushViewController(postViewController, animated: true)
            }
        } else {
            // Friend: Navigation commented out (currently disabled)
            print("Right now cant navigate to new item")
            // TODO: Enable navigation when ready
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

/*
================================================================================
IMPLEMENTATION NOTES
================================================================================

1. ADD BOOLEAN PROPERTY:
   - Add `var isUserOwnedGroup: Bool = false` at the top
   - Set to `true` when instantiating for user's own groups
   - Set to `false` when instantiating for friend's shared groups

2. WHERE TO SET THE BOOLEAN:
   - When pushing/navigating to this VC, set the boolean before presenting:
     ```
     consolidatedVC.isUserOwnedGroup = true  // or false
     ```

3. REFACTORING STRATEGY:
   - Option A: Keep both files, but have them both inherit from a base class
   - Option B: Merge into one file and set boolean from parent VC
   - Option C: Use the boolean in a single consolidated class (recommended)

4. CELL HANDLING:
   - Could use protocol/conformance to handle both cell types
   - Or use type casting based on boolean
   - Current approach: Conditional cell registration and dequeuing

5. NOTIFICATION OBSERVERS:
   - Could observe both notifications if needed
   - Or consolidate to use one notification type
   - Current: Choose one based on boolean

6. DATA FILTERING:
   - Helper method: `getDisplayPosts(for groupID: Int) -> [Post]`
   - This would centralize the filtering logic
   - Makes the code cleaner and easier to maintain

================================================================================
RECOMMENDED HELPER METHOD
================================================================================

private func getDisplayPosts(for groupID: Int) -> [Post] {
    let allPosts = postDataController.getPostsForGroup(groupID: groupID)
    if isUserOwnedGroup {
        return allPosts
    } else {
        return allPosts.filter { $0.postType == "item" }
    }
}

// Then use it in:
// - numberOfRowsInSection
// - cellForRowAt
// - didSelectRowAt
// - fetchItemsForGroup logging

================================================================================
*/

