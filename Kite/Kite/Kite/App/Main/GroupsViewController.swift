//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit



class GroupsViewController: UIViewController {

    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

    private var groups: [GroupModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchGroups()
    }

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

        let headerLabel = UILabel()
        headerLabel.text = "Groups"
        headerLabel.font = .boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center

        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        // Set the header's frame explicitly to be recognized by tableView
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
        let currentUser = userDefaultManager.getLoggedInUser()

        Task {
            do {
                let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
                if groupsResponseModel.statusCode == 401 {
                    AuthManager.shared.logoutCurrentUser()
                    return
                }
                self.groups = groupsResponseModel.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch groups:", error)
            }
        }
    }
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.configure(with: group)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.individualGroupViewControllerID) as? IndividualGroupViewController else { return }
        vc.group = group
        navigationController?.pushViewController(vc, animated: true)
    }
}



/*
class GroupsViewController: UIViewController {
    let groupsAPI = GroupsAPI()
    let userDefaultManager = UserDefaultManager()

 
    override func viewDidLoad() {
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
   
        super.viewDidLoad()
       
        getGroup(currentUser: currentUser)

         

      

    
            
    }

    func getGroup(currentUser: String) {
        Task{
            do{
                let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
                
                if(groupsResponseModel.statusCode == 401) {
                    AuthManager.shared.logoutCurrentUser()
                }
                
                print(groupsResponseModel)
                
           
            } catch{
                print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
                print(error)
                //AuthManager.shared.logoutCurrentUser()
            }
        }
    }
}

*/

/*
getGroup(currentUser: currentUser)

 
 


 func createGroup(){
     Task{
         do{
             let newGroupResponseModel = try await groupsAPI.newGroup(currentUser: "davey", groupName: "music", groupType: "kite", groupPrivate: 1, groupUsers: ["davey", "sam",  "merry", "Frodo", "frodo", " pippin"], notificationMessage: "Invited you to a new Group", notificationType: "group_invite", notificationLink: "http://localhost:3003/group/77")
             
             if(newGroupResponseModel.statusCode == 401) {
                 AuthManager.shared.logoutCurrentUser()
             }
             
             print(newGroupResponseModel)
             
             
         } catch{
             print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
             print(error)
             //AuthManager.shared.logoutCurrentUser()
         }
     }
 }
 */

//WORKS
/*
class GroupsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let topView = SimpleTopView()
        let bottomStackView = SimpleBottomStackView()
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 220),
            
            bottomStackView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
*/


//WORKS
/*
class GroupsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }

    private func setupStackView() {
        let stackView = UserProfileFollowers()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
    }
    
}
*/




//TASK: Get a Group
/*
let groupsAPI = GroupsAPI()
let userDefaultManager = UserDefaultManager()

override func viewDidLoad() {
    super.viewDidLoad()
    let currentUser = userDefaultManager.getLoggedInUser()
    let deviceId = getDeviceId()
 
    Task{
     do{
         let newGroupResponseModel = try await groupsAPI.newGroup(currentUser: "davey", groupName: "music", groupType: "kite", groupPrivate: 1, groupUsers: ["davey", "sam",  "merry", "Frodo", "frodo", " pippin"], notificationMessage: "Invited you to a new Group", notificationType: "group_invite", notificationLink: "http://localhost:3003/group/77")
         
         if(newGroupResponseModel.statusCode == 401) {
             AuthManager.shared.logoutCurrentUser()
         }
         
         print(newGroupResponseModel)
         
      
     } catch{
         print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
         print(error)
         //AuthManager.shared.logoutCurrentUser()
     }
 }
    

}



 */



//Get Group
/*
Task{
    do{
        let groupsResponseModel = try await groupsAPI.getGroupsAPI(for: currentUser)
        
        if(groupsResponseModel.statusCode == 401) {
            AuthManager.shared.logoutCurrentUser()
        }
        
        print(groupsResponseModel)
        
   
    } catch{
        print("CATCH groupsAPI.getGroupsAPI(for: currentUser) yo man error!")
        print(error)
        //AuthManager.shared.logoutCurrentUser()
    }
}
*/
