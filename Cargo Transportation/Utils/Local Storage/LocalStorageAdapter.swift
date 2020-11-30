//
//  LocalStorageAdapter.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

protocol LocalStorageAdapter: class {
    func set<T: Codable>(object: T, for key: String)
    func get<T: Codable>(for key: String) -> T?
    func remove(forKey: String)
}
