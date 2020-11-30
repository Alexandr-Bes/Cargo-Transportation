//
//  CitiesList.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 29.11.2020.
//

import Foundation

struct CitiesList: Codable {
    let status: Bool
    let message: String
    let data: [CitiesListData]
}

struct CitiesListData: Codable {
    let id: String
    let name: String
    let regionID: String
    let regionName: String
    let districtName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regionID = "RegionId"
        case regionName
        case districtName
    }
}


