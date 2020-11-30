//
//  RepresentationList.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct RepresentationList: Codable {
    let status: Bool
    let message: String
    let data: [RepresentationListData]
}

struct RepresentationListData: Codable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let cityID: String
    let latitudeCorrect, longitudeCorrect: Double
    let isCashOnDelivery: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, address
        case latitude = "Latitude"
        case longitude = "Longitude"
        case cityID = "CityId"
        case latitudeCorrect = "LatitudeCorrect"
        case longitudeCorrect = "LongitudeCorrect"
        case isCashOnDelivery = "IsCashOnDelivery"
    }
}
