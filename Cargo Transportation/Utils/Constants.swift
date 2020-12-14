//
//  Constants.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

class Constants {
    
    static let NoURLErrorMessage = "No URL"
    static let NoActiveSessionErrorMessage = "No Active Session"
    static let ParseCalculateModelError = "Can't create a calculate request params"
    
    
    struct HTTP {
        static let code200 = 200
        static let code201 = 201
        static let code204 = 204
        static let code400 = 400
        static let code401 = 401
        static let code403 = 403
        static let code404 = 404
        static let code409 = 409
        static let code500 = 500
        static let code503 = 503
    }
    
    struct AuthNetwork {
        static let decodeUserErrorMessage = "Can't decode register user"
        static let parsingErrorMessage = "AuthNetwork parsing error"
        static let parsingAuthSessionErrorMessage = "AuthNetwork parsing session error"
    }
    
    struct Geocoding {
        static let geocodingError = "Geocoding error"
    }
    
    struct NotificationKeys {
        static let loginSucceeded = Notification.Name("loginSucceeded")
        static let proceedToLogInScreen = Notification.Name("proceedToLogInScreen")
        static let registrationSucceeded = Notification.Name("registrationSucceeded")
        static let openLogin = Notification.Name("OpenLogin")
    }
    
    enum TabBarItems: CaseIterable {
        case home
        case news
        case delivery
        case feedback
        
        var index: Int {
            switch self {
            case .home:
                return 0
            case .news:
                return 1
            case .delivery:
                return 2
            case .feedback:
                return 3
            }
        }
    }
}
