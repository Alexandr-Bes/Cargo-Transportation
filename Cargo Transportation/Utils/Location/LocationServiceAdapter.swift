//
//  LocationServiceAdapter.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

enum LocationFailureReason {
    case locationServicesDisabled // Location services disabled on device
    case notDetermined // User has not yet made a choice with regards to this application
    case restricted // This application is not authorized to use location. User cannot change this status
    case denied // User has explicitly denied authorization for this application, or location services are disabled in Settings.
    case didFailWithError(Error) // The location manager was unable to retrieve a location value
    case unknown
}

// mapped CLAuthorizationStatus
enum AuthorizationStatus: Int32 {
    case notDetermined
    case restricted
    case denied
    case authorizedAlways
    case authorizedWhenInUse
    case unknown
}

typealias LocationHandler = (UserLocationProtocol?, LocationFailureReason?)->()

protocol LocationServiceAdapter {
    
    func getCurrentLocation(completion: @escaping LocationHandler)
    var currentAuthorizationStatus: AuthorizationStatus { get }
}
