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
    
    // MARK: - Fetch Posts/Items for Group
    
    /// Fetch posts for a group (posts are stored in PostDataController.posts)
    func fetchGroupPosts(groupID: Int) async {
        await postDataController.fetchPosts(groupID: groupID)
    }
    
    /// Fetch items for a group (items are posts with postType == "item", stored in PostDataController.posts)
    func fetchGroupItems(groupID: Int) async {
        await postDataController.fetchItems(groupID: groupID)
    }
}
