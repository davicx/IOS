//
//  Helpers.swift
//  Photos
//
//  Created by David Vasquez on 1/10/25.
//

import Foundation


extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
