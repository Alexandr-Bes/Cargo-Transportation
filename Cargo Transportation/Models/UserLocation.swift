//
//  UserLocation.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

protocol UserLocationProtocol {
    var latitude: Double { get }
    var longitude: Double { get }
}

struct UserLocation: UserLocationProtocol {
    var latitude: Double
    var longitude: Double
}
