//
//  MainAppRepository+Location.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

extension MainAppRepository {
    func getUserLocation(completion: @escaping GeneralNetworkCompletion<UserLocationProtocol, LocationFailureReason>) {
        location.getCurrentLocation { (userLocation, error) in
            guard let userLocation = userLocation else {
                completion(.failure(error ?? LocationFailureReason.unknown))
                return
            }
            completion(.success(userLocation))
        }
    }
    
    func autorizationStatus() -> AuthorizationStatus {
        return location.currentAuthorizationStatus
    }
    
}
