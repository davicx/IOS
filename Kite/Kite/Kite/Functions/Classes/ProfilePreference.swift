//
//  ProfilePreference.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


final class ProfilePreference {
    let userPreferenceID: Int
    let userName: String
    var preferenceCategory: String
    var preferenceTitle: String
    var preferenceDescription: String
    var displayOrder: Int
    var active: Int

    init(
        userPreferenceID: Int,
        userName: String,
        preferenceCategory: String,
        preferenceTitle: String,
        preferenceDescription: String = "",
        displayOrder: Int = 0,
        active: Int = 1
    ) {
        self.userPreferenceID = userPreferenceID
        self.userName = userName
        self.preferenceCategory = preferenceCategory
        self.preferenceTitle = preferenceTitle
        self.preferenceDescription = preferenceDescription
        self.displayOrder = displayOrder
        self.active = active
    }

    convenience init(model: PreferenceModel) {
        self.init(
            userPreferenceID: model.userPreferenceID,
            userName: model.userName,
            preferenceCategory: model.preferenceCategory,
            preferenceTitle: model.preferenceTitle ?? "",
            preferenceDescription: model.preferenceDescription ?? "",
            displayOrder: model.displayOrder,
            active: model.active
        )
    }
}
