//
//  MainAppRepository.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

class MainAppRepository {
    
    private let _location: LocationServiceAdapter
    private let _pathProvider: PathProviderProtocol
    private let _networkManager: NetworkManager
    
    init(location: LocationServiceAdapter,
         pathProvider: PathProviderProtocol,
         networkManager: NetworkManager) {
        self._location = location
        self._pathProvider = pathProvider
        self._networkManager = networkManager
    }
}

extension MainAppRepository: MainAppRepositoryProtocol {
    
    var location: LocationServiceAdapter {
        return _location
    }
    
    var pathProvider:PathProviderProtocol {
        return _pathProvider
    }
    
    var networkManager: NetworkManager {
        return _networkManager
    }
    
}
