//
//  RepresentationInfoModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct RepresentationInfoModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [RepresentationInfoDataModel]
}

struct RepresentationInfoDataModel: Codable {
    var id, name, address, operatingTime: String
    var phone, emailStorage: String
    var latitude, longitude, latitudeCorrect, longitudeCorrect: Double
    var cityID, cityName: String
    var rcPhoneSecurity, rcPhoneManagers: String
    var rcName, warehouseForDeliveryID: String
    var warehouseType: Int

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
