//
//  PurchaseButtonState.swift
//  Kite
//
//  Created by David Vasquez on 9/5/26.
//

import Foundation


//MVP presentation rules for wishlist purchase button (see Doc/feature_item_purchase.md).
func purchaseButtonState(post: Post, currentUser: String) -> PurchaseButtonState {
    if let postFrom = post.postFrom, postFrom == currentUser {
        return .hidden
    }

    let isPurchased = (post.purchased ?? 0) != 0
    if isPurchased, let purchasedBy = post.purchasedBy, purchasedBy == currentUser {
        return .youPurchased
    }

    if isPurchased {
        let viewers = post.purchasedViewers ?? []
        if viewers.contains(currentUser) {
            let by = post.purchasedBy?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return .purchased(by: by.isEmpty ? "Someone" : by)
        }
    }

    return .purchase
}
