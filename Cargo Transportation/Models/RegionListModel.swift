//
//  RegionListModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

struct RegionListModel: BaseModelProtocol {
    var status: Bool
    var message: String
    var data: [RegionListDataModel]
}

struct RegionListDataModel: Codable {
    var id: Int
    var name: String
    var externalId: String
}
