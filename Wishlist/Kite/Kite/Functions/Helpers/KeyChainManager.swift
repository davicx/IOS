//
//  KeyChainManager.swift
//  Kite
//
//  Created by David Vasquez on 2/9/25.
//

import Foundation
import Security
import UIKit

func getDeviceId() -> String {
    let key = "com.yourapp.deviceId"
    if let storedDeviceId = KeychainHelper.shared.read(service: key, account: "user") {
        return storedDeviceId
    }
    let newDeviceId = UUID().uuidString
    KeychainHelper.shared.save(newDeviceId, service: key, account: "user")
    return newDeviceId
}


