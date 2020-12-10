//
//  HomeViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var appRepository: MainAppRepositoryProtocol?
    private var userLocation: UserLocationProtocol?
    private var responseData: [SearchByCoordinatesDataModel]?
    private static let cell = [HomeTableViewCell.self]
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = .lightGray
        tableView.register(cells: HomeViewController.cell)
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 70
//        tableView.estimatedRowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        appRepository = AppDelegateProvider().provide().sharedBuilder?.buildMainRepository()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        downloadData()
//        dateArrival()
    }
    
    private func setupUI() {
        title = "Home"
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func downloadData() {
        appRepository?.getUserLocation(completion: { [weak self] (result) in
            switch result {
            case .success(let userLoc):
                print(userLoc)
                self?.userLocation = userLoc
                self?.searchRepresentations()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func searchRepresentations() {
        guard let _userLocation = userLocation else { return }
        
        self.showProgress()
        appRepository?.searchRepresentationsWithUserLocation(longitude: _userLocation.longitude,
                                                             latitude: _userLocation.latitude,
                                                             completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                print(response.data.first)
                self?.responseData = response.data
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        })
    }
    
    private func dateArrival() {
        let networkManager = NetworkManager()
        self.showProgress()
        
        networkManager.getDateArrival(areaID: "", arrivalID: "") { [weak self] (result) in
            switch result {
            case .success(let data):
                print(data.data)
            case .failure(let error):
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        }
        
    }
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        guard let data = responseData?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: data)
        cell.backgroundColor = .lightGray
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = responseData?[indexPath.row] else {
            return
        }
        createRepresentationDetailVC(with: data.id)
    }
    
    private func createRepresentationDetailVC(with id: String) {
        print(id)
        let representationDetailsVC = RepresentationDetailsViewController()
        representationDetailsVC.representationID = id
        navigationController?.pushViewController(representationDetailsVC, animated: true)
    }
}
