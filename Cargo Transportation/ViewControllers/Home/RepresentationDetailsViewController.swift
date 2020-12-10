//
//  RepresentationDetailsViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import UIKit
import MapKit

class RepresentationDetailsViewController: UIViewController {
    
    var representationID: String?
    
    private var appRepository: MainAppRepositoryProtocol?
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
       let label = UILabel()
//        label.font = .systemFont(ofSize: 11)
//        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var operatingTimeLabel: UILabel = {
       let label = UILabel()
//        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        return mapView
    }()
    
    override func loadView() {
        super.loadView()
        appRepository = AppDelegateProvider().provide().sharedBuilder?.buildMainRepository()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(nameLabel)
        view.addSubview(operatingTimeLabel)
        view.addSubview(addressLabel)
        view.addSubview(phoneLabel)
        view.addSubview(okButton)
        view.addSubview(mapView)
        setupConstraints()
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        addressLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).inset(-20)
        }
        operatingTimeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(addressLabel.snp.bottom).inset(-10)
        }
        phoneLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(operatingTimeLabel.snp.bottom).inset(-10)
        }
        okButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLabel.snp.bottom).inset(-30)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(okButton.snp.top).inset(-30)
        }
    }
    
    func downloadData() {
        guard let id = representationID else { return }
        showProgress()
        appRepository?.getRepresentationInfo(id: id, completion: { [weak self] (result) in
            self?.hideProgress()
            switch result {
            case .success(let responseData):
                self?.fillData(data: responseData)
            case .failure(let error):
                self?.showAlert(error: error)
            }
        })
    }
    
    func fillData(data: RepresentationInfoModel) {
        nameLabel.text = data.data.rcName
        addressLabel.text = "Адресс: \(data.data.address)"
        operatingTimeLabel.text = "Время работы: \(data.data.operatingTime)"
        phoneLabel.text = "Телефон: \(data.data.phoneManagers)"
        title = data.data.cityName
        
        let center = CLLocationCoordinate2D(latitude: data.data.longitude, longitude: data.data.latitude)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = center//CLLocationCoordinate2DMake(data.data.longitude, data.data.latitude);
        myAnnotation.title = data.data.rcName
        mapView.addAnnotation(myAnnotation)

    }

}
