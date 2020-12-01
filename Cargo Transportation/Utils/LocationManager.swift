//
//  LocationManager.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation
import CoreLocation

class LocationManager {
    private let _location: LocationServiceAdapter
    
    var location: LocationServiceAdapter {
        return _location
    }
    
    var geocoder: CLGeocoder {
        return CLGeocoder()
    }
    
    init(location: LocationServiceAdapter) {
        self._location = location
    }
    
    func getCurrentLocation(completion: @escaping GeneralNetworkComplition<UserLocationProtocol, LocationFailureReason>) {
        location.getCurrentLocation { (userLocation, error) in
            guard let userLocation = userLocation else {
                completion(.failure(error ?? LocationFailureReason.unknown))
                return
            }
            completion(.success(userLocation))
        }
    }
}
