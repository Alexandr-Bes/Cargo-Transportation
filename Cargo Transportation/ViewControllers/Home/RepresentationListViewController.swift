//
//  RepresentationListViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import UIKit

class RepresentationListViewController: UIViewController {
    
    var cityID: String?
    var regionID: String?
    
    private var appRepository: MainAppRepositoryProtocol?
    private let cellIdentifier = "Cell"
    private var responseData: [RepresentationListDataModel]?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = .systemGray3
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 50
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
    }
    
    private func setupUI() {
        title = "Отделения"
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func downloadData() {
        self.showProgress()
        appRepository?.getRepresentationList(cityID: cityID ?? "", regionID: regionID ?? "", completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.responseData = response.data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.debugDescription)
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        })
    }

}

extension RepresentationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        guard let data = responseData?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = data.address
        cell.backgroundColor = .systemGray3
        return cell
    }
}

extension RepresentationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = responseData?[indexPath.row] else {
            return
        }
        createRepresentationDetailVC(with: data.id)
    }
    
    private func createRepresentationDetailVC(with id: String) {
        let representationDetailsVC = RepresentationDetailsViewController()
        representationDetailsVC.representationID = id
        representationDetailsVC.isFromSearch = true
        navigationController?.pushViewController(representationDetailsVC, animated: true)
    }
}
