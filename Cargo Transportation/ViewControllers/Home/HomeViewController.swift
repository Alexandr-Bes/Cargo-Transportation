//
//  HomeViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        title = "Home"
        
        LocationManager(location: LocationService()).getCurrentLocation { (result) in
            switch result {
            case .success(let userLocation):
                print(userLocation)
            case .failure(let error):
                print(error)
            }
        }
    }

}
