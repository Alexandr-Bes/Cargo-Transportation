//
//  NibInstantiatable.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import UIKit

protocol NibInstantiatable {
    static var nib: UINib { get }
    static var nibName: String { get }

    static func instanstiateFromNib() -> Self
}

extension NibInstantiatable {

    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    static func instanstiateFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Could not instanstiate view \(nibName) from nib")
        }

        return view
    }
}
