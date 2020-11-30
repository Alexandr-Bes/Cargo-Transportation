//
//  AlertController+extension.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func present(in viewController: UIViewController,
                        title: String? = nil,
                        message: String? = nil,
                        actionTitle: String? = "Close",
                        cancelTitle: String? = nil,
                        withAnimation: Bool = true,
                        completion: (()->())? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel) { _ in
            if let _completion = completion {
                _completion()
            }
        }
        alert.addAction(action)
        if let _cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: _cancelTitle, style: .default)
            alert.addAction(cancelAction)
        }
        
        viewController.present(alert, animated: withAnimation)
    }
}
