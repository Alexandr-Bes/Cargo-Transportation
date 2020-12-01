//
//  SearchByCoordinatesModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 02.12.2020.
//

import Foundation

struct SearchByCoordinatesModel: Codable {
    let status: Bool
    let message: String
    let data: [SearchByCoordinatesDataModel]
}

struct SearchByCoordinatesDataModel: Codable {
    let id, name: String
    let distance, longitude, latitude: Double
    let cityName, address: String
    let phone, workingTime: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, distance, longitude, latitude, cityName, address, phone
        case workingTime = "working_time"
    }
}
