//
//  DeliverySchemeModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 13.12.2020.
//

import Foundation

struct DeliverySchemeModel: Codable {
    var data: [DeliverySchemeDataModel]
}

struct DeliverySchemeDataModel: Codable {
    var id: String
    var name: String
}
