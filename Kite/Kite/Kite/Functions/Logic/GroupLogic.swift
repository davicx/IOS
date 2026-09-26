//
//  GroupLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/11/26.
//

import Foundation

/*
FUNCTIONS A: All Functions Related to Getting Groups
    1) Function A1: Get all Group Posts
 
FUNCTIONS B: All Functions Related to Group Actions
    1) Function B1:
 
 
FUNCTIONS C: All Functions Related to Group Item Actions
    1) Function B1:
 
 
*/

final class GroupLogic {
    static let shared = GroupLogic()
    private init() {}
    
    private let postDataController = PostDataController.shared
    

    //Function A1: Get all Group Posts (Kite)
    func fetchGroupKitePosts(groupID: Int) async {
        await postDataController.fetchKitePosts(groupID: groupID)
    }

    //Function A2: Get all Group Items (Wishlist)
    func fetchGroupWishlistItems(groupID: Int) async {
        await postDataController.fetchWishlistItems(groupID: groupID)
    }
    
    
}
