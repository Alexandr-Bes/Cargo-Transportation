//
//  MainAppRepository+Location.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

extension MainAppRepository {
    func getUserLocation(completion: @escaping GeneralNetworkCompletion<Bool, LocationFailureReason>) {
        
    }
    
    func status() -> AuthorizationStatus {
        return location.currentAuthorizationStatus
    }
}
