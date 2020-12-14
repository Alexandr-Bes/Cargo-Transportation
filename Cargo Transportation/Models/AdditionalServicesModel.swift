//
//  AdditionalServicesModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 13.12.2020.
//

import Foundation

struct AdditionalServicesModel: BaseModelProtocol {
    var status: Bool
    var message: String
    
    var data: [AdditionalServicesDataModel]
    
}

struct AdditionalServicesDataModel: Codable {
    var classification: Int
    var name: String
    var services: [ServiceModel]
    
    enum CodingKeys: String, CodingKey {
        case services = "dopUsluga"
        case classification, name
    }
}

struct ServiceModel: Codable {
    var uslugaId: String
    var name: String
    var cost: Int
}
