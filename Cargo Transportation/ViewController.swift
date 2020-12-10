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
        
//        appRepo?.getRegionList(completion: { (result) in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error.debugDescription)
//            }
//        })
        
//        appRepo?.getCitiesList(id: 3919, completion: { (result) in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error.debugDescription)
//            }
//        })

        
        appRepo?.getRepresentationList(cityID: "aa3250a4-402b-e311-8b0d-00155d037960", regionID: "0c6d7ee9-b42c-e211-9e9c-00155d053b5d", completion: { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.debugDescription)
            }
        })
        
        
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

