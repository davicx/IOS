//
//  UserModel.swift
//  apiModels
//
//  Created by David Vasquez on 3/13/23.
//


import Foundation

//Make optional if value might be nil
struct UserModel: Codable {
    var firstName:String = ""
    var lastName:String = ""
    
}
