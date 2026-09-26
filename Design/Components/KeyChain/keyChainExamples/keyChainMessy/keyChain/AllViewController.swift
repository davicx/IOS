//
//  ViewController.swift
//  keyChain
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/6/22.
//

//https://developer.apple.com/documentation/security/keychain_services/keychain_items/adding_a_password_to_the_keychain
//https://swiftsenpai.com/development/persist-data-using-keychain/

import UIKit

/*
struct Credentials {
    var username: String
    var password: String
}
*/


class AllViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //savePassword()
        //getPassword()
        let service = "Kite"
        let account = "frodo"
        let password = "password!"

        //KeychainService.savePassword(service: service, account: account, data: password)
        /*
        if let str = KeychainService.loadPassword(service: service, account: account) {
            //retrievedPassword.stringValue = str
            print(str)
        } else {
            //retrievedPassword.stringValue = "Password does not exist"
            print( "Password does not exist")
        }
         
         */
    }
    
    /*
     class ViewController: NSViewController {
         @IBOutlet weak var enterPassword: NSTextField!
         @IBOutlet weak var retrievedPassword: NSTextField!
         
         let service = "myService"
         let account = "myAccount"
         
         // will only work after
         @IBAction func updatePassword(_ sender: Any) {
             KeychainService.updatePassword(service: service, account: account, data: enterPassword.stringValue)
         }
         
         @IBAction func removePassword(_ sender: Any) {
             KeychainService.removePassword(service: service, account: account)
         }
         
         @IBAction func passwordSet(_ sender: Any) {
             let password = enterPassword.stringValue
             KeychainService.savePassword(service: service, account: account, data: password)
         }
         
         @IBAction func passwordGet(_ sender: Any) {
             if let str = KeychainService.loadPassword(service: service, account: account) {
                 retrievedPassword.stringValue = str
             }
             else {retrievedPassword.stringValue = "Password does not exist" }
         }
     }
    
    func getPassword() {

        //Returns optional
        guard let data = KeyChainManager.get(
            username: "davey"
        ) else {
            print("couldn't get yo!")
            return
        }
        
        let password = String(decoding: data, as: UTF8.self)
        
        print(password)
    
    }

    func savePassword() {
        print("saving")
        do {
            try AppleKeyChainManager.save(
                username: "frodo",
                password: "password"
            )
        } catch {
            print(error)
        }
         
    }
     */
}




class AppleKeyChainManager {
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
        case duplicateEntry
        case unknown(OSStatus)
    }
    static var server = "www.kite.com"
    
    //Save
    static func save(username: String, password: String) throws {
        print("save \(username)")
  
        var query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: username,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard status != errSecDuplicateItem else { throw KeychainError.duplicateEntry}
        guard status == errSecSuccess else { throw KeychainError.unknown(status) }
        print(status)
    
    }
    
    //Get
    static func get() {
        print("get")
    }
    
    //Update
    static func update() {
        print("update")
    }
    
    //Delete
    static func delete() {
        print("delete")
    }
    
}


class KeyChainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    //Save
    static func save( username: String, password: Data) throws {
            //service, account, password, class, data
             print("Starting Keychain Save")
             
            let query:[String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: username as AnyObject,
                kSecValueData as String: password as AnyObject,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
             
         guard status != errSecDuplicateItem else {
             throw KeychainError.duplicateEntry
         }
         guard status == errSecSuccess else {
             throw KeychainError.unknown(status)
         }
        print("Saved yo!")
    }

    
    //Get
    static func get(username: String) -> Data? {
            let query:[String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: username as AnyObject,
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

/*
func getPassword() {

    //Returns optional
    guard let data = KeyChainManager.get(
        username: "davey"
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
            username: "davey",
            password: "password".data(using: .utf8) ?? Data()
        )
    } catch {
        print(error)
    }
}
*/

/*
func getPassword() {

    //Returns optional
    guard let data = KeyChainManager.get(
        service: "kite",
        account: "davey"
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
*/

