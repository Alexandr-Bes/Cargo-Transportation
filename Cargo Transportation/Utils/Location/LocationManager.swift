//
//  LocationManager.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation
import CoreLocation

class LocationManager {
    
    // MARK: - Properties
    
    private let _location: LocationServiceAdapter
    
    var location: LocationServiceAdapter {
        return _location
    }
    
    // MARK: - Init
    
    init(location: LocationServiceAdapter) {
        self._location = location
    }
    
    func getCurrentLocation(completion: @escaping GeneralNetworkCompletion<UserLocationProtocol, LocationFailureReason>) {
        location.getCurrentLocation { (userLocation, error) in
            guard let userLocation = userLocation else {
                completion(.failure(error ?? LocationFailureReason.unknown))
                return
            }
            completion(.success(userLocation))
        }
    }
}
