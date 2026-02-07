//
//  GroupLogic.swift
//  Kite
//
//  Created by David Vasquez on 1/11/26.
//

import Foundation


final class GroupLogic {
    static let shared = GroupLogic()
    private init() {}
    
    private let postDataController = PostDataController.shared
    
    // MARK: - Fetch Posts for Group
    //KITE: fetch posts from posts API
    //WISHLIST: fetch items (stored as posts) from items API — implementation in PostDataController.fetchPosts
    
    /// Fetch posts for a group (KITE: posts API; WISHLIST: items API, stored as posts)
    func fetchGroupPosts(groupID: Int) async {
        await postDataController.fetchPosts(groupID: groupID)
    }
    
    /*
    //KITE: same as fetchGroupPosts — both call fetchPosts
    //WISHLIST: use fetchGroupPosts; items are loaded via fetchPosts in PostDataController
    func fetchGroupItems(groupID: Int) async {
        await postDataController.fetchItems(groupID: groupID)
    }
    */
}
