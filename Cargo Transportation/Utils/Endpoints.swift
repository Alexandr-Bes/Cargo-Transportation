//
//  Endpoints.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

enum Endpoints: String {
    
    case login = "PostLogin"
    
    private var basePath : String {
        return "https://www.delivery-auto.com/api/v4/Public/"
    }
}
