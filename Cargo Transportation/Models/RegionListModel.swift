//
//  RegionListModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

struct RegionListModel: Codable {
    let status: Bool
    let message: String
    let data: [RegionListDataModel]
}

struct RegionListDataModel: Codable {
    let id: Int
    let name: String
    let externalId: String
}
