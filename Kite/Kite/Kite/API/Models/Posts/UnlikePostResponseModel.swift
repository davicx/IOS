//
//  UnlikePostResponseModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation



struct UnlikePostResponseModel: Codable {
    let data: LikeModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
    init() {
        self.data = LikeModel(postLikeID: 0, postID: 0, likedByUserName: "", likedByImage: "", likedByFirstName: "", likedByLastName: "", timestamp: "", friendshipStatus: 0)
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
    
}


//JSON
/*
 {
   data: {
     postLikeID: 352,
     postID: 728,
     likedByUserName: '',
     likedByImage: '',
     likedByFirstName: '',
     likedByLastName: '',
     timestamp: '',
     friendshipStatus: ''
   },
   message: 'The Post Like was removed',
   success: true,
   statusCode: 200,
   errors: [],
   currentUser: 'davey'
 }
 */

/*
 struct LikePostResponseModel: Codable {
     let data: LikeModel
     let message: String
     let success: Bool
     let statusCode: Int
     let errors: [String]
     let currentUser: String
     
     init() {
         self.data = LikeModel(postLikeID: 0, postID: 0, likedByUserName: "", likedByImage: "", likedByFirstName: "", likedByLastName: "", timestamp: "", friendshipStatus: 0)
         self.message = ""
         self.success = false
         self.statusCode = 500
         self.errors = []
         self.currentUser = ""
     }
     
 }


 */

