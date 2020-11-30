//
//  LoginModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

struct LoginModel: Codable {
    var userName: String
    var password: String
    var rememberMe: Bool
}
