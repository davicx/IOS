//
//  KeychainHelper.swift
//  Kite
//
//  Created by David Vasquez on 2/9/25.
//


import Foundation
import Security
import UIKit

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}

    func save(_ value: String, service: String, account: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary) // Ensure old value is deleted
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
           let data = result as? Data,
           let value = String(data: data, encoding: .utf8) {
            return value
        }
        return nil
    }

    //Retrieves the stored device ID or generates a new one if not found.
    func getOrCreateDeviceId() -> String {
        let key = "com.yourapp.deviceId"
        let account = "user"

        if let storedDeviceId = read(service: key, account: account) {
            return storedDeviceId
        }
        
        let newDeviceId = UUID().uuidString
        save(newDeviceId, service: key, account: account)
        return newDeviceId
    }
}


/*
class KeychainHelper {
    static let shared = KeychainHelper()

    private init() {}

    func save(_ value: String, service: String, account: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary) // Ensure old value is deleted
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
           let data = result as? Data,
           let value = String(data: data, encoding: .utf8) {
            return value
        }
        return nil
    }
}


*/
