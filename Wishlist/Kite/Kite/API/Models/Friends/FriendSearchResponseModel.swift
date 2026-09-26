//
//  FriendSearchResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 1/7/25.
//

import Foundation


struct FriendSearchResponseModel: Codable {
    let data: [FriendSearchModel]
    let message: Int
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = []
        self.message = 0
        self.success = false
        self.statusCode = 401
        self.errors = []
        self.currentUser = ""
    }
}

/*
 {
     "data": [
         {
             "friendName": "frodo",
             "friendImage": "frodo.jpg",
             "firstName": "Mr Frodo",
             "lastName": "Baggins"
         }
     ],
     "message": 1,
     "success": true,
     "statusCode": 200,
     "errors": [],
     "currentUser": "davey"
 }
 */
