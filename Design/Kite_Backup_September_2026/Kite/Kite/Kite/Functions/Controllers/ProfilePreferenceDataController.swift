//
//  ProfilePreferenceDataController.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


extension Notification.Name {
    static let preferencesUpdated = Notification.Name("preferencesUpdated")
}

/*
FUNCTIONS A: Fetch / read preferences
    1) Function A1: Preferences for a username (cache)
    2) Function A2: Fetch preferences from API

FUNCTIONS B: Mutate preferences
    1) Function B1: Create preference via API, then update cache
    2) Function B2: Update preference via API, then update cache
    3) Function B3: Remove preference via API, then update cache
*/

final class ProfilePreferenceDataController {
    static let shared = ProfilePreferenceDataController()
    private init() {}

    private var preferencesByUsername: [String: [ProfilePreference]] = [:]
    private let queue = DispatchQueue(label: "com.kite.profilePreferenceDataController")
    private let preferenceFunctions = profilePreferenceFunctions.shared
    private let userDefaultManager = UserDefaultManager()

    var currentUser: String {
        userDefaultManager.getLoggedInUser()
    }

    //FUNCTIONS A: Fetch / read preferences
    //Function A1: Preferences for a username (cache)
    func preferences(for userName: String) -> [ProfilePreference] {
        queue.sync {
            preferencesByUsername[userName] ?? []
        }
    }

    //Function A2: Fetch preferences from API
    func fetchPreferences(userName: String) async {
        guard let fetched = await preferenceFunctions.fetchPreferences(userName: userName) else {
            return
        }
        queue.sync {
            preferencesByUsername[userName] = fetched
        }
        notifyUpdated(userName: userName)
    }

    //FUNCTIONS B: Mutate preferences
    //Function B1: Create preference via API, then update cache
    @discardableResult
    func createPreference(
        preferenceCategory: String,
        preferenceTitle: String,
        preferenceDescription: String
    ) async -> ProfilePreference? {
        let category = preferenceCategory.trimmingCharacters(in: .whitespacesAndNewlines)
        let title = preferenceTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = preferenceDescription.trimmingCharacters(in: .whitespacesAndNewlines)

        guard validateFields(category: category, title: title, description: description) else {
            return nil
        }

        guard let created = await preferenceFunctions.addPreference(
            preferenceCategory: category,
            preferenceTitle: title,
            preferenceDescription: description
        ) else {
            return nil
        }

        let owner = created.userName
        queue.sync {
            var list = preferencesByUsername[owner] ?? []
            list.append(created)
            preferencesByUsername[owner] = sorted(list)
        }
        notifyUpdated(userName: owner)
        return created
    }

    //Function B2: Update preference via API, then update cache
    @discardableResult
    func updatePreference(
        userPreferenceID: Int,
        preferenceCategory: String,
        preferenceTitle: String,
        preferenceDescription: String,
        displayOrder: Int = 0
    ) async -> ProfilePreference? {
        let category = preferenceCategory.trimmingCharacters(in: .whitespacesAndNewlines)
        let title = preferenceTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = preferenceDescription.trimmingCharacters(in: .whitespacesAndNewlines)

        guard userPreferenceID > 0 else { return nil }
        guard validateFields(category: category, title: title, description: description) else {
            return nil
        }

        guard let updated = await preferenceFunctions.editPreference(
            userPreferenceID: userPreferenceID,
            preferenceCategory: category,
            preferenceTitle: title,
            preferenceDescription: description,
            displayOrder: displayOrder
        ) else {
            return nil
        }

        let owner = updated.userName
        queue.sync {
            var list = preferencesByUsername[owner] ?? []
            if let index = list.firstIndex(where: { $0.userPreferenceID == updated.userPreferenceID }) {
                list[index] = updated
            } else {
                list.append(updated)
            }
            preferencesByUsername[owner] = sorted(list)
        }
        notifyUpdated(userName: owner)
        return updated
    }

    //Function B3: Remove preference via API, then update cache
    @discardableResult
    func removePreference(userPreferenceID: Int, userName: String) async -> Bool {
        guard userPreferenceID > 0 else { return false }

        let success = await preferenceFunctions.removePreference(userPreferenceID: userPreferenceID)
        guard success else { return false }

        queue.sync {
            var list = preferencesByUsername[userName] ?? []
            list.removeAll { $0.userPreferenceID == userPreferenceID }
            preferencesByUsername[userName] = list
        }
        notifyUpdated(userName: userName)
        return true
    }

    private func validateFields(category: String, title: String, description: String) -> Bool {
        guard !category.isEmpty, !title.isEmpty else { return false }
        guard category.count <= profilePreferenceFunctions.categoryMax else { return false }
        guard title.count <= profilePreferenceFunctions.titleMax else { return false }
        guard description.count <= profilePreferenceFunctions.descriptionMax else { return false }
        return true
    }

    private func sorted(_ list: [ProfilePreference]) -> [ProfilePreference] {
        list.sorted {
            if $0.displayOrder == $1.displayOrder {
                return $0.userPreferenceID < $1.userPreferenceID
            }
            return $0.displayOrder < $1.displayOrder
        }
    }

    private func notifyUpdated(userName: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: .preferencesUpdated,
                object: nil,
                userInfo: ["userName": userName]
            )
        }
    }
}
