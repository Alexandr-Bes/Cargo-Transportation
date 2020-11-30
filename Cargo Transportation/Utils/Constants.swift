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
    static let ParseBetModelError = "Can't create a Bet"
    
    struct HeaderProvider {
        static let xAuthToken = "Authorization"
        static let xTraceId = "x-trace-id"
        static let xSessionId = "x-session-id"
        static let xUserId = "x-user-id"
        static let contentType = "Content-Type"
    }
    
    
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
    
    struct PlaceBetNetwork {
        static let decodeErrorMessage = "Can't decode the bet"
        static let betsDecodeErrorMessage = "Can't decode placed bets"
    }
    
    struct PoolNetwork {
        
        static let parsingPoolsErrorMessage = "PoolNetwork parsing error"
    }
    
    struct Geocoding {
        static let geocodingError = "Geocoding error"
    }
    
    struct NetworkParameters {
        static let email = "email"
        static let password = "password"
        static let resetToken = "resetToken"
        static let username = "username"
        
        static let settled = "settled"
        
    }
    
    struct NotificationKeys {
        static let loginSucceeded = Notification.Name("loginSucceeded")
        static let proceedToLogInScreen = Notification.Name("proceedToLogInScreen")
        static let registrationSucceeded = Notification.Name("registrationSucceeded")
        static let openLogin = Notification.Name("OpenLogin")
    }
    
    // TODO: - RENAME!!!
    enum TabBarItems: CaseIterable {
        case cards
        case myBets
        case deposit
        case history
        case settings
        
        var index: Int {
            switch self {
            case .cards:
                return 0
            case .myBets:
                return 1
            case .deposit:
                return 2
            case .history:
                return 3
            case .settings:
                return 4
            }
        }
    }
}
