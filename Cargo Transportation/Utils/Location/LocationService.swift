//
//  LocationService.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation
import CoreLocation

class LocationService : NSObject, LocationServiceAdapter {
    
    private typealias AuthorizationComplition = (_ status: AuthorizationStatus) -> Void
    
    private var locationManager = CLLocationManager()
    private let distanceFilter: Double = 100
    private var completionHandler: LocationHandler?
    
    private var authorizationHandler: AuthorizationComplition?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = distanceFilter
    }
    
    private static var currentAuthorizationStatus: AuthorizationStatus {
        return AuthorizationStatus(rawValue: CLLocationManager.authorizationStatus().rawValue) ?? .unknown
    }
    
    var currentAuthorizationStatus: AuthorizationStatus {
        return LocationService.currentAuthorizationStatus
    }
    
    func getCurrentLocation(completion: @escaping LocationHandler) {
        
        completionHandler = completion
        guard CLLocationManager.locationServicesEnabled() else {
            completion(nil, LocationFailureReason.locationServicesDisabled)
            return
        }
        
        guard currentAuthorizationStatus == .authorizedAlways ||
            currentAuthorizationStatus == .authorizedWhenInUse ||
            currentAuthorizationStatus == .notDetermined else
        {
            switch currentAuthorizationStatus {
            case .restricted:
                completionHandler?(nil, .restricted)
            case .denied:
                completionHandler?(nil, .denied)
            default:
                completionHandler?(nil, .unknown)
            }
            return
        }
        
        requestWhenInUseAuthorization { [weak self] (status) in
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                self?.locationManager.startUpdatingLocation()
                
            } else {
                var failure = LocationFailureReason.unknown
                switch status {
                case .denied:
                    failure = LocationFailureReason.denied
                case .notDetermined:
                    failure = LocationFailureReason.notDetermined
                case .restricted:
                    failure = LocationFailureReason.restricted
                default:
                    break
                }
                self?.completionHandler?(nil, failure)
            }
        }
    }
    
    private func requestWhenInUseAuthorization(complition: AuthorizationComplition?) {
        self.authorizationHandler = complition
        if currentAuthorizationStatus == .authorizedAlways ||
            currentAuthorizationStatus == .authorizedWhenInUse
        {
            self.authorizationHandler?(currentAuthorizationStatus)
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}


extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationHandler?(currentAuthorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            completionHandler?(nil, LocationFailureReason.unknown)
            return
        }
        self.locationManager.stopUpdatingLocation()
        let userLocation = location.coordinate.toCoordinate()
        completionHandler?(userLocation, nil)
        completionHandler = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(nil, LocationFailureReason.didFailWithError(error))
        completionHandler = nil
    }
}

extension CLLocationCoordinate2D {
    func toCoordinate() -> UserLocation {
        return UserLocation(latitude: latitude, longitude: longitude)
    }
}
