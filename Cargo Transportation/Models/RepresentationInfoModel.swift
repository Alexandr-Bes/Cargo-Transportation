//
//  RepresentationInfoModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct RepresentationInfoModel: Codable {
    let status: Bool
    let message: String
    let data: [RepresentationInfoDataModel]
}

struct RepresentationInfoDataModel: Codable {
    let id, name, address, operatingTime: String
    let phone, emailStorage: String
    let latitude, longitude, latitudeCorrect, longitudeCorrect: Double
    let cityID, cityName: String
    let rcPhoneSecurity, rcPhoneManagers: String
    let rcName, warehouseForDeliveryID: String
    let warehouseType: Int

    enum CodingKeys: String, CodingKey {
        case id, name, address, operatingTime
        case phone = "Phone"
        case emailStorage = "EmailStorage"
        case latitude, longitude, latitudeCorrect, longitudeCorrect
        case cityID = "CityId"
        case cityName = "CityName"
        case rcPhoneSecurity = "RcPhoneSecurity"
        case rcPhoneManagers = "RcPhoneManagers"
        case rcName = "RcName"
        case warehouseForDeliveryID = "WarehouseForDeliveryId"
        case warehouseType = "WarehouseType"
    }
}
