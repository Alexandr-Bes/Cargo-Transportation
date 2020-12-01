//
//  MainAppRepositoryProtocols.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

protocol MainAppRepositoryProtocol: LocationModuleProtocol {
    
}

protocol LocationModuleProtocol: class {
    func getUserLocation(completion: @escaping GeneralNetworkCompletion<Bool, LocationFailureReason>)
    func status() -> AuthorizationStatus
}
