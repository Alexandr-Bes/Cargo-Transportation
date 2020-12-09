//
//  ViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 23.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appRepo = AppDelegateProvider().provide().sharedBuilder?.buildMainRepository()
        
        appRepo?.getRegionList(completion: { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.debugDescription)
            }
        })
        
//        networkManager.getRegionList { (result) in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error.debugDescription)
//            }
//        }
        
//        networkManager.authorize(email: "alex.morgan.mailfree@gmail.com", password: "strongp") { (result) in
//            switch result {
//            case .success(let login):
//                print(login.message)
//            case .failure(let error):
//                print(error.debugDescription)
//            }
//        }
        
    }


}

