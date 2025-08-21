//
//  NewGroupResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 12/18/24.
//

import Foundation


struct NewGroupResponseModel: Codable {
    let data: GroupModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    
    init() {
        self.data = GroupModel(groupID: 0, groupName: "groupName", groupImage: nil, createdBy: "createdBy", activeGroupMembers: ["activeMembers"], pendingGroupMembers: ["pendingMembers"])
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}

/*
 {
   data: {
     groupName: 'Hi',
     groupImage: 'http://localhost:3003/kite-groups-us-west-two/group_image.png',
     groupID: 684,
     groupMembers: [ 'davey' ],
     pendingGroupMembers: [ 'sam' ]
   },
   message: 'Succesfully created the new group, yay!',
   success: true,
   statusCode: 200,
   errors: [],
   currentUser: 'davey'
 }
 */
