//
//  NSObject+ext.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

extension NSObject {
            
    static func identifier() -> String {
        return String(describing: self)
    }
}
