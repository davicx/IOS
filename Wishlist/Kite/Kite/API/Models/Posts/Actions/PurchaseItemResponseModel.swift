//
//  PurchaseItemResponseModel.swift
//  Kite
//
//  Created by David Vasquez on 2/7/26.
//

import Foundation


//WISHLIST
struct PurchaseItemResponseModel: Codable {
    let data: PurchaseItemModel
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String

    init() {
        self.data = PurchaseItemModel(itemID: 0, postID: 0, purchased: 0, purchasedBy: "", message: "")
        self.message = ""
        self.success = false
        self.statusCode = 500
        self.errors = []
        self.currentUser = ""
    }
}
