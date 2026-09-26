//
//  User.swift
//  TableViewPlayground
//
//  Created by David Vasquez on 11/27/25.
//


import Foundation


//WORKS
class User {
    let name: String
    var likes: Int
    
    init(name: String, likes: Int = 0) {
        self.name = name
        self.likes = likes
    }
}

