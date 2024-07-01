//
//  HeroStats.swift
//  mySimplePosts
//
//  Created by David on 6/30/24.
//

import Foundation


struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}

