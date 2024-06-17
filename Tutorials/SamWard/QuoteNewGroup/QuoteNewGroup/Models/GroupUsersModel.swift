//
//  GroupUsersModel.swift
//  QuoteNewGroup
//
//  Created by David Vasquez on 9/11/23.
//

import Foundation

struct GroupUsersModel: Codable {
    let data: GroupUsersData
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
}


struct GroupUsersData: Codable {
    let activeGroupUsers: [String]
    let pendingGroupUsers: [String]

}




/*
 {
     "data": {
         "activeGroupUsers": [
             "davey"
         ],
         "pendingGroupUsers": [
             "david",
             "merry",
             "sam"
         ]
     },
     "message": "",
     "success": false,
     "statusCode": 500,
     "errors": [],
     "currentUser": "currentUser"
 }
*/

/*
 
 var groupUsersOutcome = {
     data: "data",
     message: "",
     success: false,
     statusCode: 500,
     errors: [],
     currentUser: "currentUser"
 }
 {
     "groupUsers": {
         "activeGroupUsers": [
             "davey"
         ],
         "pendingGroupUsers": [
             "david",
             "merry",
             "sam"
         ]
     }
 }
 */

