//
//  RegionList.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

struct RegionList: Codable {
    let status: Bool
    let message: String
    let data: [RegionListData]
}

struct RegionListData: Codable {
    let id: Int
    let name: String
    let externalId: String
}
