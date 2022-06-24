//
//  ViewController.swift
//  keyChain
//
//  Created by Vasquez, Charles Geoffrey David [C] on 6/6/22.
//

//STOP: 8
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}

class KeyChainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
        
    }
    
    static func save(
        service: String,
         account: String,
         password: Data) throws {
            //service, account, password, class, data
             
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
    
    static func get() {
        //service, account, class, return data, match limit
    }

}

