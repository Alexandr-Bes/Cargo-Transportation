//
//  RepresentationSearchModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation
// Poka hz zachem
struct RepresentationSearchModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [RepresentationSearchDataModel]
}

struct RepresentationSearchDataModel: Codable {
    var id, name: String
    var distance, longitude, latitude, longitudeCorrect: Double
    var latitudeCorrect: Double
    var cityName: String
    var address: String
    var isWarehouse: Bool
    var phone, workingTime: String

    enum CodingKeys: String, CodingKey {
        case id, name, distance, longitude, latitude, longitudeCorrect, latitudeCorrect, cityName, address
        case isWarehouse = "IsWarehouse"
        case phone
        case workingTime = "working_time"
    }
}
