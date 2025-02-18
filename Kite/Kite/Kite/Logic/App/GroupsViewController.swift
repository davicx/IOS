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
    }
    


}
