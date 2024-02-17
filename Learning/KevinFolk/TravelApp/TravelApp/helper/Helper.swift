//
//  Helper.swift
//  TravelApp
//
//  Created by David Vasquez on 11/13/23.
//

import Foundation

//Global Function
func delay(durationInSeconds seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
