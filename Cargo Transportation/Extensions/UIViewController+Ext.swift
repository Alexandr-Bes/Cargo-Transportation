//
//  UIViewController+Ext.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import Foundation
import MBProgressHUD

extension UIViewController {
            
    func showProgress(with animation: Bool = true, offset: Bool = true) {
        let hud = MBProgressHUD.showAdded(to:view, animated: animation)
        hud.contentColor = .red
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .clear
        hud.offset = offset ? CGPoint(x: 0, y: -50) : .zero
    }
    
    func hideProgress(with animation: Bool = true) {
        MBProgressHUD.hide(for: view, animated: animation)
    }
    
    func showWhiteProgress() {
        
        let hud = MBProgressHUD.showAdded(to:view, animated:true)
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .clear
        hud.offset = CGPoint(x: 0, y: 50)
    }
    
    func unloadViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    var safeAreaBottomWithTabBar: CGFloat {
        if let tabBarController = tabBarController {
            return tabBarController.tabBar.frame.height
        } else if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
        
    static func loadXib<T: UIViewController>() -> T? {
        
        let bundle = Bundle.main
        let name = T.identifier()
        let nib = bundle.loadNibNamed(name, owner: nil, options: nil)
        let vc = nib?.first as? T
        
        return vc
    }
    
    static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper()
    }
    
    private class func instantiateFromStoryboardHelper<T>() -> T {
        let storyboardName = String(describing: self)
        return UIStoryboard(name: storyboardName,
                            bundle: nil).instantiateInitialViewController() as! T
    }
    
}

protocol NibProtocol {

}

extension NibProtocol {
    
    static func loadNib<T: NibProtocol>() -> T? {
        let bundle = Bundle.main
        let name = String(describing: T.self)
        let nib = bundle.loadNibNamed(name, owner: nil, options: nil)
        let vc = nib?.first as? T
        return vc
    }
}

extension UIView: NibProtocol {
    
}

extension UIViewController: NibProtocol {
    
}
extension UIViewController {
    
    func showAlert(error: Error?) {
        UIAlertController.present(in: self, title: "Error", message: error?.localizedDescription)
    }
}
