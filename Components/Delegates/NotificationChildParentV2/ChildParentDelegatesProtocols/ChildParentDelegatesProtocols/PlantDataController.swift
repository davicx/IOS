//
//  PlantDataController.swift
//  ChildParentDelegatesProtocols
//
//  Created by David Vasquez on 6/7/25.
//

import UIKit


class PlantDataController {
    static let shared = PlantDataController()

    private(set) var plants: [String: Int] = [
        "Tree": 1,
        "Flower": 1,
        "Bush": 1
    ]

    func addPlant(_ name: String) {
        plants[name, default: 0] += 1
        NotificationCenter.default.post(name: .plantUpdated, object: nil)
    }

    func getPlantCount(_ name: String) -> Int {
        return plants[name, default: 0]
    }

    func getAllPlantsText() -> String {
        return plants.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
    }
}

extension Notification.Name {
    static let plantUpdated = Notification.Name("plantUpdated")
}
