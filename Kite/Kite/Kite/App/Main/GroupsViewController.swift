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

    
    private let userProfileLayout = UserProfileLayoutExample()
    
    override func viewDidLoad() {
        let currentUser = userDefaultManager.getLoggedInUser()
        let deviceId = getDeviceId()
        
        super.viewDidLoad()
        userProfileLayout.setup(in: view)
        

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
}


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
