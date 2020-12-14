//
//  CalculationReceiveModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 14.12.2020.
//

import Foundation

struct CalculationReceiveModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: CalculationReceiveDataModel
}

struct CalculationReceiveDataModel: Codable {
//    let areasSendIdName: String
//    let areasResiveIdName: String
    let warehouseSendIdName: String
    let warehouseResiveIdName: String
    let dateResive: String
    let allSumma: Double
    let comment: String
}

