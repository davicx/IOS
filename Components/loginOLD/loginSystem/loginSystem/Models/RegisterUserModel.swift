//
//  User.swift
//  loginSystem
//
//  Created by David Vasquez on 7/21/20.
//  Copyright © 2020 David Vasquez. All rights reserved.
//


import Foundation

struct RegisterUserModel: Codable {
    var user_name = ""
    var full_name = ""
    var email = ""
    var password = ""
    var salt = 0
    var final_password = ""
    var user_key = ""
    var username_failure = 1
    var user_name_message = ""
    var full_name_failure = 1
    var full_name_message = ""
    var password_failure = 1
    var password_message = ""
    var email_failure = 1
    var email_message = ""
    var master_success = 0
}
