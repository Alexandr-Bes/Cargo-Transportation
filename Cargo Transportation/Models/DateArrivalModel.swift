//
//  DateArrivalModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 06.12.2020.
//

import Foundation

struct DateArrivalModel: BaseModelProtocol {
    var status: Bool
    var message: String
    
    var data: DateArrivalDataModel
}

struct DateArrivalDataModel: Codable {
    var arrivalDate: String
}


