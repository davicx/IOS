//
//  KeyChainManagerTwo.swift
//  keyChain
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/28/22.
//

import Foundation


class KeyChainManagerTwo {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    //Save
    static func save(
        service: String,
         account: String,
         password: Data) throws {
            //service, account, password, class, data
             print("Starting Keychain Save")
             
            let query:[String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecValueData as String: password as AnyObject,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
             
         guard status != errSecDuplicateItem else {
             throw KeychainError.duplicateEntry
         }
         guard status == errSecSuccess else {
             throw KeychainError.unknown(status)
         }
    }

    
    //Get
    static func get(
         service: String,
         account: String
    ) -> Data? {
            let query:[String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )
        
        print(status)
       
        return result as? Data
        
    }
    
    //Update
    static func update() {
        /*
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
         */
        
    }

}
