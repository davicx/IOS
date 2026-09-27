//
//  homeFunctions.swift
//  Kite
//
//  Created by David Vasquez on 9/26/26.
//

import Foundation


/*
FUNCTIONS A: Home feeds
    1) Function A1: All active Kite posts (master_site = kite)
*/

final class homeFunctions {
    static let shared = homeFunctions()
    private init() {}

    private let postDataController = PostDataController.shared

    //Function A1: All active Kite posts, newest first
    func homeAllPosts() async {
        await postDataController.fetchAllKitePosts()
    }
}
