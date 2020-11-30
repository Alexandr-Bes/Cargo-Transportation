//
//  Helper.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation

func executeOnBackgroundThread(_ clouser: @escaping ()->()) {
    if Thread.isMainThread {
        DispatchQueue.global().async(execute: clouser)
    } else {
        clouser()
    }
}

func executeOnMainThread(_ clouser: @escaping ()->()) {
    if Thread.isMainThread {
        clouser()
    } else {
        DispatchQueue.main.async(execute: clouser)
    }
}
