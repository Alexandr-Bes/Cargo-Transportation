//
//  RepresentationListModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct RepresentationListModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [RepresentationListDataModel]
}

struct RepresentationListDataModel: Codable {
    var id: String
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var cityID: String
    var latitudeCorrect, longitudeCorrect: Double // Fignya
    var isCashOnDelivery: Bool

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
