//
//  PreferenceModel.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


struct PreferenceModel: Codable {
    let userPreferenceID: Int
    let userName: String
    let preferenceCategory: String
    let preferenceTitle: String?
    let preferenceDescription: String?
    let displayOrder: Int
    let active: Int
    let updated: String?
    let created: String?

    init(
        userPreferenceID: Int = 0,
        userName: String = "",
        preferenceCategory: String = "",
        preferenceTitle: String? = nil,
        preferenceDescription: String? = nil,
        displayOrder: Int = 0,
        active: Int = 1,
        updated: String? = nil,
        created: String? = nil
    ) {
        self.userPreferenceID = userPreferenceID
        self.userName = userName
        self.preferenceCategory = preferenceCategory
        self.preferenceTitle = preferenceTitle
        self.preferenceDescription = preferenceDescription
        self.displayOrder = displayOrder
        self.active = active
        self.updated = updated
        self.created = created
    }
}
