//
//  GroupsViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit

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

/*
 // Set constraints for custom view
 NSLayoutConstraint.activate([
     customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
     customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
 ])
 
 // Add the label to the custom view
 customView.addSubview(label)
 label.translatesAutoresizingMaskIntoConstraints = false
 
 // Set constraints for the label
 NSLayoutConstraint.activate([
     label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20), // Padding from the left
     label.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20), // Padding from the right
     label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20), // Padding from the top
     label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20) // Padding from the bottom
 ])
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
