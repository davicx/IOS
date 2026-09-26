//
//  PurchaseItemModel.swift
//  Kite
//
//  Created by David Vasquez on 2/7/26.
//

import Foundation


//WISHLIST
struct PurchaseItemModel: Codable {
    let itemID: Int
    let postID: Int
    let purchased: Int
    let purchasedBy: String
    let message: String
}
