//
//  Enums.swift
//  Kite
//
//  Created by David Vasquez on 12/10/24.
//

import UIKit


enum networkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case tokenRefreshFailed
    case unauthorized
    case serverError(statusCode: Int)
}



