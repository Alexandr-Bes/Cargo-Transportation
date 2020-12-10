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
    var data: RepresentationInfoDataModel
}

struct RepresentationInfoDataModel: Codable {
    var id, name, address, operatingTime: String
//    var distance: Double
    var phone, email: String
    var latitude, longitude: Double //, latitudeCorrect, longitudeCorrect: Double
    var cityID, cityName: String
    var phoneSecurity, phoneManagers: String
    var rcName: String //, warehouseForDeliveryID: String
    var warehouseType: Int

    enum CodingKeys: String, CodingKey {
        case id, name, address, operatingTime
        case phone = "Phone"
        case email = "EmailStorage"
        case latitude, longitude //, latitudeCorrect, longitudeCorrect
        case cityID = "CityId"
        case cityName = "CityName"
        case phoneSecurity = "RcPhoneSecurity"
        case phoneManagers = "RcPhoneManagers"
        case rcName = "RcName"
//        case warehouseForDeliveryID = "WarehouseForDeliveryId"
        case warehouseType = "WarehouseType"
    }
}
