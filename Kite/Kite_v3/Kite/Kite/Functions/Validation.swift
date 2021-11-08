//
//  Validation.swift
//  Kite
//
//  Created by Syngenta on 11/7/21.
//

import Foundation

class Validation {

    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        //return passwordTest.evaluate(with: password)
        return true
    }
}
