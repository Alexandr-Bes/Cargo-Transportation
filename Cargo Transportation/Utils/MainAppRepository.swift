//
//  MainAppRepository.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

class MainAppRepository {
    private let _location: LocationServiceAdapter
    
    init(location: LocationServiceAdapter) {
        self._location = location
    }
}

extension MainAppRepository: MainAppRepositoryProtocol {
    
    var location: LocationServiceAdapter {
        return _location
    }
    
}
