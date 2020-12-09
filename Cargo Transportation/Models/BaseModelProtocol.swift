//
//  BaseModelProtocol.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 06.12.2020.
//

import Foundation

protocol BaseModelProtocol: Codable {
    var status: Bool { get }
    var message: String { get }
}
