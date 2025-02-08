//
//  UpdateUserProfileModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation



struct UpdateUserProfileModel: Codable {
    let userName: String
    let userID: Int
    let userImage: String
    let biography: String
    let firstName: String
    let lastName: String

    
    init() {
        self.userName = ""
        self.userID = 0
        self.userImage = ""
        self.biography = ""
        self.firstName = ""
        self.lastName = ""

    }

}


/*
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



/*
 {
     "message": "We updated the user profile for frodo30",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "frodo30",
     "data": {
         "currentUser": "frodo30",
         "imageName": "frodo.png",
         "firstName": "frodo",
         "lastName": "baggins",
         "biography": "biography"
     }
 }
 */
