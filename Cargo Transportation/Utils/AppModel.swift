//
//  AppModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 14.12.2020.
//

import Foundation

struct AppModel {
    var areasSendId: String?    // CityID
    var warehouseSendId: String?    // Representation ID
    
    var areasReceiveId: String?
    var warehouseReceiveId: String?
    
    var insuranceValue: Double?
    var cashOnDeliveryValue: Double?
    var dateSend: String?
    var deliveryScheme: Int?
    var weight: Double?
    var size: Double?
}
