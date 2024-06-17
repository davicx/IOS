//
//  ModelAPI.swift
//  myAPI
//
//  Created by David Vasquez on 6/13/24.
//

import Foundation


struct ResponseModel: Codable {
    //let data: Data
    let message: String
    let success: Bool
    let statusCode: Int
    let errors: [String]
    let currentUser: String
    
}

