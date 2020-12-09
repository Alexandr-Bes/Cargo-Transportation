//
//  SearchByCoordinatesModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 02.12.2020.
//

import Foundation

struct SearchByCoordinatesModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [SearchByCoordinatesDataModel]
}

struct SearchByCoordinatesDataModel: Codable {
    var id, name: String
    var distance, longitude, latitude: Double
    var cityName, address: String
    var phone, workingTime: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, distance, longitude, latitude, cityName, address, phone
        case workingTime = "working_time"
    }
}
