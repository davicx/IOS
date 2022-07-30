//
//  ViewController.swift
//  KeyChainTwo
//
//  Created by Vasquez, Charles Geoffrey David [C] on 7/29/22.
//

import UIKit

//TYPE 2: Apple
struct Credentials {
    var username: String
    var password: String
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TYPE 1: Video
        savePassword()
        var password = getPassword()
        print("PASSWORD \(password)")
        //updatePassword()
        deletePassword()
        password = getPassword()
        print("PASSWORD \(password)")
        
        //TYPE 2: Apple
        //addItem()
        //getItem()
    }
    
    //TYPE 1: Keychain Video
    func getPassword() -> String {
        do {
            let data = try KeyChainManager.get(service: "kite.com", account: "davey")
            let password = String(decoding: data!, as: UTF8.self)
            
            print(password)
            return password
            
        } catch {
            print(error)
            return "0"
        }
    }
    
    func savePassword() {
        do {
            try KeyChainManager.save(
                service: "kite.com",
                account: "davey",
                password: "password".data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
    
    func updatePassword() {
        do {
            print("updating pasword to newy!")
            try KeyChainManager.update(
                service: "kite.com",
                account: "davey",
                password: "oh my!".data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }
    
    
    func deletePassword() {
        do {
            print("deleting now! ")
            try KeyChainManager.delete(service: "kite.com", account: "davey")
        } catch {
            print(error)
        }
    }
    
    
    
    //TYPE 2: Apple
    enum KeychainError: Error {
        case noPassword
        case duplicateEntry
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    func addItem() {
        do {
   
            //static let server = "www.kite.com"
            let credentials = Credentials(username: "frodo", password: "password")
            let server = "www.kite.com"
 
            print(credentials)
            
            let account = credentials.username
            let password = credentials.password.data(using: String.Encoding.utf8)!
            var query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                        kSecAttrAccount as String: account,
                                        kSecAttrServer as String: server,
                                        kSecValueData as String: password]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            print(status)
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
                
        } catch {
            print(error)
        }
    }
    
    
    
    func getItem() {
        do {
            print("Getting Item")
            let server = "www.kite.com"
            
            let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                        kSecAttrServer as String: server,
                                        kSecMatchLimit as String: kSecMatchLimitOne,
                                        kSecReturnAttributes as String: true,
                                        kSecReturnData as String: true]
            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            guard status != errSecItemNotFound else { throw KeychainError.noPassword }
            guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
            
            guard let existingItem = item as? [String : Any],
                let passwordData = existingItem[kSecValueData as String] as? Data,
                let password = String(data: passwordData, encoding: String.Encoding.utf8),
                let account = existingItem[kSecAttrAccount as String] as? String
            else {
                throw KeychainError.unexpectedPasswordData
            }
            let credentials = Credentials(username: account, password: password)
            print(credentials)
            
        } catch {
            print(error)
        }
    }
    
    func updateItem () {
        let credentials = Credentials(username: "frodo2", password: "password")
        print(credentials)
        do {
            let query: [String: Any] = [kSecClass as String:
                                        kSecClassInternetPassword,
                                        kSecAttrServer as String: "www.kite.com"]
            let account = credentials.username
            let password = credentials.password.data(using: String.Encoding.utf8)!
            let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                             kSecValueData as String: password]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            print(status)
            guard status != errSecItemNotFound else { throw KeychainError.noPassword }
            guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
            
        } catch {
            print(error)
        }
    }
    
    

}


//TYPE 1: KeyChain Video
class KeyChainManager {
    enum KeychainError: Error {
        case itemNotFound
        case duplicateEntry
        case unknown(OSStatus)
        
    }
    
    //Save
    static func save(service: String, account: String, password: Data) throws {
        print("______SAVE___________")
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
             print("Saved")
    }

    

    
    //Get
    static func get(service: String, account: String) throws -> Data? {
        print("______GET___________")
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
        
        print("status: \(status)")
        
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




