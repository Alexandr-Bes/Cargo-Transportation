//
//  CitiesListModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct CitiesListModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [CitiesListDataModel]
}

struct CitiesListDataModel: Codable {
    var id: String
    var name: String
    var regionID: String
    var regionName: String
    var districtName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regionID = "RegionId"
        case regionName
        case districtName
    }
}


