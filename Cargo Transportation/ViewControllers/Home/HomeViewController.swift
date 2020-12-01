//
//  HomeViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var locationManager: LocationManager?
    
    override func loadView() {
        super.loadView()
        locationManager = LocationManager(location: LocationService())
        checkUserLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        title = "Home"
        
    }
    
    private func checkUserLocation() {
        locationManager?.getCurrentLocation(completion: { [weak self] (result) in
            switch result {
            case .success(let userLocation):
                print(userLocation)
                self?.searchRepresentations(longitude: userLocation.longitude, latitude: userLocation.latitude)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func searchRepresentations(longitude: Double, latitude: Double) {
        let networkManager = NetworkManager()
        self.showProgress()
        networkManager.searchRepresentations(with: longitude, and: latitude) { [weak self] (result) in
            switch result {
            case .success(let data):
                print(data.data.first)
            case .failure(let error):
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        }
    }
    
}
