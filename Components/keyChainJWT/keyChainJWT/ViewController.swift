//
//  ViewController.swift
//  keyChainJWT
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/30/22.
//


import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TYPE 1: Video
        let service = "kite"
        let account = "davey"
        let password = "password"
        var userPassword = ""
        
        //Save Password
        //savePassword(service: service, account: account, password: password)

        //Get Password
        userPassword = getPassword(service: service, account: account)
        print("PASSWORD \(userPassword)")
          
        //Update Password
        //updatePassword(service: service, account: account, password: password)
   
        //Delete password
        //deletePassword(service: service, account: account)
        
        //Print
        //userPassword = getPassword(service: service, account: account)
        //print("PASSWORD \(userPassword)")
        

    

    }

    
    //TYPE 1: Keychain Video
    func getPassword(service: String, account: String) -> String {
        do {
            let data = try KeyChainManager.get(service: service, account: account)
            let password = String(decoding: data!, as: UTF8.self)
            
            print("The password for account \(account) is \(password)")
            return password
            
        } catch {
            print(error)
            return "nopassword"
        }
    }
    
    func savePassword(service: String, account: String, password: String) {
        do {
            try KeyChainManager.save(
                service: service,
                account: account,
                password: password.data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
    
    func updatePassword(service: String, account: String, password: String) {
        do {
            print("updating pasword to newy!")
            try KeyChainManager.update(
                service: service,
                account: account,
                password: password.data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
    
    
    func deletePassword(service: String, account: String) {
        do {
            print("deleting now! ")
            try KeyChainManager.delete(service: service, account: account)
        } catch {
            print(error)
        }
    }
    
}

class KeyChainManager {
    enum KeychainError: Error {
        case itemNotFound
        case duplicateEntry
        case unknown(OSStatus)
        
    }
    
    //Save
    static func save(service: String, account: String, password: Data) throws {
        //print("______SAVE___________")
        //print("Starting Keychain Save")
         
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
             print("SAVED: \(account)")
    }

    
    //Get
    static func get(service: String, account: String) throws -> Data? {
        //print("______GET___________")
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
        
        //print("status: \(status)")
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
 
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
               
        return result as? Data
        
    }
    
    //Update
    static func update(service: String, account: String, password: Data) throws {
        print("______UPDATE___________")
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        // attributes is passed to SecItemUpdate with kSecValueData as the updated item value
        let attributes: [String: AnyObject] = [
            kSecValueData as String: password as AnyObject
        ]
        
        // SecItemUpdate attempts to update the item identified by query, overriding the previous value
        let status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )
        print("status: \(status)")

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
 
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }

    }
    
    //Delete
    static func delete(service: String, account: String) throws {
        print("______DELETE___________")
        let query: [String: AnyObject] = [
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)
        print("status: \(status)")

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }

}




