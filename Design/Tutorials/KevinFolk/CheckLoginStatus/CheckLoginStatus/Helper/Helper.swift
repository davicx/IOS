//
//  Helper.swift
//  CheckLoginStatus
//
//  Created by David on 4/12/23.
//

import Foundation

//Global Function (can be called anywhere) 
func delay(durationInSeconds seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    
}

