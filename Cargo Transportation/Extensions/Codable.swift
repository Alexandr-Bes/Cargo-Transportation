//
//  Codable.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

extension Decodable {
    /// Returns a value of the type you specify, decoded from a JSON object.
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

/// Encodable Extension
///
extension Encodable {
    /// Returns a JSON-encoded representation of himself.
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
