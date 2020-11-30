//
//  UserDefaultsLocalStorageAdapter.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

final class UserDefaultsLocalStorageAdapter: LocalStorageAdapter {
    func set<T>(object: T, for key: String) where T: Codable {
        let defaults = UserDefaults.standard
        let container = UserDefaultsContainer(object: object)
        guard let encodedData = try? JSONEncoder().encode(container) else {
            return
        }
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
    
    func get<T>(for key: String) -> T? where T: Codable {
        let defaults = UserDefaults.standard
        guard let encodedData = defaults.data(forKey: key) else {
            return nil
        }
        guard let container = try? JSONDecoder().decode(UserDefaultsContainer<T>.self, from: encodedData) else {
            return nil
        }
        return container.object
    }
    
    func remove(forKey: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey)
    }
}

struct UserDefaultsContainer<T: Codable>: Codable {
    let object: T
}
