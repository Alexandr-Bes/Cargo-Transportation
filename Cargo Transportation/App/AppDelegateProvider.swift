//
//  AppDelegateProvider.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import UIKit

class AppDelegateProvider {
    func provide() -> AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("App Delegate nil ! What are you doing?")
        }
        return appDelegate
    }
}
