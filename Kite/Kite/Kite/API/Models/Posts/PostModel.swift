//
//  PostModel.swift
//  Instagram
//
//  Created by David Vasquez on 10/19/24.
//

import Foundation


//WISHLIST
struct PostModel: Codable {
    let postID: Int
    let postType: String
    let groupID: Int
    let groupName: String?
    let groupImage: String?
    let listID: Int
    let postFrom: String
    let postFromImage: String?
    let postTo: String
    let postCaption: String
    let fileName: String
    let fileNameServer: String
    let fileURL: String
    
    let cloudBucket: String
    let cloudKey: String
    let storageType: String?
    
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    var isLikedByCurrentUser: Bool
    let commentsArray: [CommentModel]
    let postLikesArray: [LikeModel]
    let simpleLikesArray: [String]
    
    // Item-specific fields (optional for KITE, required for WISHLIST)
    let item: ItemDetails?
}

struct ItemDetails: Codable {
    let item_id: Int
    let item_name: String
    let item_price: String
    let item_description: String
    let item_category: String
    let item_link: String
    let purchased: Int
    let purchased_by: String
    let store: String
    let multiple_stores: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        item_id = try container.decode(Int.self, forKey: .item_id)
        item_name = try container.decode(String.self, forKey: .item_name)
        
        // Handle item_price which can be either a number or a string
        if let priceString = try? container.decode(String.self, forKey: .item_price) {
            item_price = priceString
        } else if let priceNumber = try? container.decode(Int.self, forKey: .item_price) {
            item_price = String(priceNumber)
        } else if let priceDouble = try? container.decode(Double.self, forKey: .item_price) {
            item_price = String(Int(priceDouble))
        } else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath + [CodingKeys.item_price], debugDescription: "Expected String, Int, or Double for item_price"))
        }
        
        item_description = try container.decode(String.self, forKey: .item_description)
        item_category = try container.decode(String.self, forKey: .item_category)
        item_link = try container.decode(String.self, forKey: .item_link)
        purchased = try container.decode(Int.self, forKey: .purchased)
        purchased_by = try container.decode(String.self, forKey: .purchased_by)
        store = try container.decode(String.self, forKey: .store)
        multiple_stores = try container.decode(Int.self, forKey: .multiple_stores)
    }
}


//KITE
/*
struct PostModel: Codable {
    let postID: Int
    let postType: String
    let groupID: Int
    let groupName: String
    let groupImage: String
    let listID: Int
    let postFrom: String
    let postFromImage: String
    let postTo: String
    let postCaption: String
    let fileName: String
    let fileNameServer: String
    let fileURL: String
    
    let cloudBucket: String
    let cloudKey: String
    let storageType: String
    
    let videoURL: String
    let videoCode: String
    let postDate: String
    let postTime: String
    let timeMessage: String
    let created: String
    var isLikedByCurrentUser: Bool
    let commentsArray: [CommentModel]
    let postLikesArray: [LikeModel]
    let simpleLikesArray: [String]
    
}

*/
