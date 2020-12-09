//
//  SharedBuilder.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 08.12.2020.
//

import Foundation

final class SharedBuilder {
    func buildMainRepository() -> MainAppRepository {
        let locationService = LocationService()
        let pathProvider = PathProvider()
        let networkManager = NetworkManager()
        let appRepository = MainAppRepository(location: locationService,
                                              pathProvider: pathProvider,
                                              networkManager: networkManager)
        return appRepository
    }
    
    
}
