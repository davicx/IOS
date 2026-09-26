//
//  CookieModel.swift
//  myAPI
//
//  Created by David Vasquez on 3/13/23.
//

import Foundation


//Make optional if value might be nil
struct CookieModel: Codable {
    var accessToken:String = ""
    var userName:String = ""
    var outcome:String = ""
}

