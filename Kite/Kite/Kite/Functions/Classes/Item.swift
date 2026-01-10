//
//  Item.swift
//  Kite
//
//  Created by David Vasquez on 12/19/24.
//


import UIKit


 class Item {
 var postID: Int
 var postType: String?
 var groupID: Int?
 var groupName: String?
 var groupImage: String?
 var listID: Int?
 var postFrom: String?
 var postFromImage: String?
 var postTo: String?
 var postCaption: String?
 var fileName: String?
 var fileNameServer: String?
 var fileUrl: String?
 var cloudBucket: String?
 var cloudKey: String?
 var storageType: String?
 
 var videoURL: String?
 var videoCode: String?
 var postDate: String?
 var postTime: String?
 var timeMessage: String?
 
 var created: String?
 var isLikedByCurrentUser: Bool?
 var commentsArray: [Comment]?
 var postLikesArray: [LikeModel]?
 var simpleLikesArray: [String]?
 
 var postImageData: UIImage?
 var postFromImageData: UIImage?
 var groupImageData: UIImage?
 
 // Item-specific properties
 var itemID: Int?
 var itemName: String?
 var itemPrice: String?
 var itemDescription: String?
 var itemCategory: String?
 var itemLink: String?
 var purchased: Int?
 var purchasedBy: String?
 var store: String?
 var multipleStores: Int?
 
 init(postID: Int) {
 self.postID = postID
 }
 
 }
 
