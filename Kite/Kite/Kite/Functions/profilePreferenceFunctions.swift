//
//  profilePreferenceFunctions.swift
//  Kite
//
//  Created by David Vasquez on 9/9/26.
//

import Foundation


/*
FUNCTIONS A: Preference API helpers
    1) Function A1: Fetch preferences for a user
    2) Function A2: Add preference
    3) Function A3: Edit preference
    4) Function A4: Remove preference
*/

final class profilePreferenceFunctions {
    static let shared = profilePreferenceFunctions()
    private init() {}

    private let profileAPI = ProfileAPI()
    private let userDefaultManager = UserDefaultManager()

    // Length limits match api preferenceFunctions.js
    static let categoryMax = 100
    static let titleMax = 150
    static let descriptionMax = 500

    //Function A1: Fetch preferences for a user
    func fetchPreferences(userName: String) async -> [ProfilePreference]? {
        do {
            let response = try await profileAPI.getUserPreferencesAPI(userName: userName)
            guard response.success else {
                print("profilePreferenceFunctions: fetch failed — \(response.message)")
                return nil
            }
            return response.data.map { ProfilePreference(model: $0) }
        } catch {
            print("profilePreferenceFunctions: fetch error — \(error)")
            return nil
        }
    }

    //Function A2: Add preference
    func addPreference(
        preferenceCategory: String,
        preferenceTitle: String,
        preferenceDescription: String
    ) async -> ProfilePreference? {
        let currentUser = userDefaultManager.getLoggedInUser()
        do {
            let response = try await profileAPI.addUserPreferenceAPI(
                currentUser: currentUser,
                preferenceCategory: preferenceCategory,
                preferenceTitle: preferenceTitle,
                preferenceDescription: preferenceDescription
            )
            guard response.success, response.data.userPreferenceID > 0 else {
                print("profilePreferenceFunctions: add failed — \(response.message) \(response.errors)")
                return nil
            }
            return ProfilePreference(model: response.data)
        } catch {
            print("profilePreferenceFunctions: add error — \(error)")
            return nil
        }
    }

    //Function A3: Edit preference
    func editPreference(
        userPreferenceID: Int,
        preferenceCategory: String,
        preferenceTitle: String,
        preferenceDescription: String,
        displayOrder: Int = 0
    ) async -> ProfilePreference? {
        let currentUser = userDefaultManager.getLoggedInUser()
        do {
            let response = try await profileAPI.editUserPreferenceAPI(
                currentUser: currentUser,
                userPreferenceID: userPreferenceID,
                preferenceCategory: preferenceCategory,
                preferenceTitle: preferenceTitle,
                preferenceDescription: preferenceDescription,
                displayOrder: displayOrder
            )
            guard response.success, response.data.userPreferenceID > 0 else {
                print("profilePreferenceFunctions: edit failed — \(response.message) \(response.errors)")
                return nil
            }
            return ProfilePreference(model: response.data)
        } catch {
            print("profilePreferenceFunctions: edit error — \(error)")
            return nil
        }
    }

    //Function A4: Remove preference
    func removePreference(userPreferenceID: Int) async -> Bool {
        let currentUser = userDefaultManager.getLoggedInUser()
        do {
            let response = try await profileAPI.removeUserPreferenceAPI(
                currentUser: currentUser,
                userPreferenceID: userPreferenceID
            )
            guard response.success else {
                print("profilePreferenceFunctions: remove failed — \(response.message) \(response.errors)")
                return false
            }
            return true
        } catch {
            print("profilePreferenceFunctions: remove error — \(error)")
            return false
        }
    }
}
