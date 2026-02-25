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
    

    //Function A1: Get all Group Posts
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
