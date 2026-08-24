//
//  ItemDraft.swift
//  Kite
//
//  Created by David Vasquez on 8/22/26.
//

import UIKit


/// Shared draft for Paste / Photo / Manual → Review.
/// Only Review Item should call create (Step 7). Paths only fill this model.
struct ItemDraft {
    var name: String
    var price: String?          // stay String while editing; convert at submit
    var postText: String?       // what the user wants to say (not product copy)
    var productURL: String?
    var imageURL: String?       // remote, if any
    var localImage: UIImage?    // local pick / screenshot — fine for MVP
    var storeName: String?
    var groupID: Int

    static func empty(groupID: Int) -> ItemDraft {
        ItemDraft(
            name: "",
            price: nil,
            postText: nil,
            productURL: nil,
            imageURL: nil,
            localImage: nil,
            storeName: nil,
            groupID: groupID
        )
    }

    /// Sample draft for Step 3 Review UI preview (matches mock).
    static func sample(groupID: Int) -> ItemDraft {
        ItemDraft(
            name: "Secret of Mana",
            price: "$49.99",
            postText: "I want to get Secret of Mana for Nintendo Switch. Looks awesome!",
            productURL: "https://www.nintendo.com/store/products/secret-of-mana-switch/",
            imageURL: nil,
            localImage: nil,
            storeName: "Nintendo",
            groupID: groupID
        )
    }
}
