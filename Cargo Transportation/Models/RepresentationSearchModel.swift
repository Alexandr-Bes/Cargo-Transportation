//
//  RepresentationSearchModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct RepresentationSearchModel: Codable {
    let status: Bool
    let message: String
    let data: [RepresentationSearchDataModel]
}

struct RepresentationSearchDataModel: Codable {
    let id, name: String
    let distance, longitude, latitude, longitudeCorrect: Double
    let latitudeCorrect: Double
    let cityName: String
    let address: String
    let isWarehouse: Bool
    let phone, workingTime: String

    enum CodingKeys: String, CodingKey {
        case id, name, distance, longitude, latitude, longitudeCorrect, latitudeCorrect, cityName, address
        case isWarehouse = "IsWarehouse"
        case phone
        case workingTime = "working_time"
    }
}
