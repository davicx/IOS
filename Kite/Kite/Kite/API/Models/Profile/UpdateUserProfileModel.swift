//
//  UpdateUserProfileModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct UpdateUserProfileModel: Codable {
    let currentUser: String
    let imageName: String
    let firstName: String
    let lastName: String
    let biography: String
    
    init() {
        self.currentUser = ""
        self.imageName = ""
        self.firstName = ""
        self.lastName = ""
        self.biography = ""
    }

}

/*
 {
     "message": "We updated the user profile for davey",
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey",
     "data": {
         "currentUser": "davey",
         "imageName": "password",
         "firstName": "david vas",
         "lastName": "v",
         "biography": "biography"
     }
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
