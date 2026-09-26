//
//  PlantModel.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit

class PlantModel {
    static let shared = PlantModel()

    private init() {}

    var plants: [String: Int] = [
        "Tree": 1,
        "Flower": 1,
        "Bush": 1
    ]
}
