//
//  UpdateUserProfileResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UpdateUserProfileResponseModel: Codable {
    let data: UpdateUserProfileModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = UpdateUserProfileModel()
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}

/*
 {
     "message": "We updated the user profile for davey",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 
 {
   data: {
     userName: 'davey',
     userID: 1,
     userImage: 'http://localhost:3003/kite-profile-us-west-two/profileImage-1738887410682-505580232-background_1.jpg',
     biography: 'They are (or were) a little people, about half our height, and smaller than the bearded dwarves',
     firstName: 'david v',
     lastName: 'david v'
   },
   message: 'We got the user profile for davey',
   success: true,
   statusCode: 200,
   errors: [],
   currentUser: 'davey'
 }
 */
