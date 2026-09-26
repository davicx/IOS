//
//  UploadResponse.swift
//  sendFormDataToAPI
//
//  Created by David Vasquez on 8/12/24.
//

import Foundation

struct UploadResponse: Codable {
    let postCaption: String
    let postFrom: String
    let success: Bool
}

/*
 var postOutcomeSmall = {
    postCaption: postCaption,
    postFrom: postFrom,
    success: true,
}
 */
