//
//  backupVC.swift
//  keyChain
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/28/22.
//

/*

//https://developer.apple.com/documentation/security/keychain_services/keychain_items/adding_a_password_to_the_keychain
//https://swiftsenpai.com/development/persist-data-using-keychain/

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //savePassword()
        getPassword()
        
        
    }
    
    func getPassword() {

        //Returns optional
        guard let data = KeyChainManager.get(
            service: "kite2",
            account: "davey2"
        ) else {
            print("couldn't get yo!")
            return
        }
        
        let password = String(decoding: data, as: UTF8.self)
        
        print(password)
        
  
    }
    
    func savePassword() {
        do {
            try KeyChainManager.save(
                service: "kite2",
                account: "davey2",
                //password: "password".data(using: .utf8) ?? Data()
                
                password: "password".data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
}

class KeyChainManager {
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

*/





////
///
//
//  ViewController.swift
//  keyChain
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/6/22.
//
/*
//STOP: 10:30
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func getPassword() {
        do {
            let data = try KeyChainManager.get(service: "facebook.com", account: "davey")
            
            try KeyChainManager.save(
                service: "kite",
                account: "davey",
                password: "password".data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
    
    func savePassword() {
        do {
            try KeyChainManager.save(
                service: "kite",
                account: "davey",
                password: "password".data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
}

class KeyChainManager {
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
    ) throws -> Data? {
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
    

}
*/

