//
//  SearchRegionsViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import UIKit

class SearchRegionsViewController: UIViewController {
    
    private var appRepository: MainAppRepositoryProtocol?
    private let cellIdentifier = "Cell"
    private var responseData: [RegionListDataModel]?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = .lightGray
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
        title = "Область"
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
        appRepository?.getRegionList(completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                var tempData = response.data
                tempData.removeFirst()
                self?.responseData = tempData
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.debugDescription)
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        })
    }

}

extension SearchRegionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        guard let data = responseData?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = data.name
        cell.backgroundColor = .systemGray3
        return cell
    }
}

extension SearchRegionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = responseData?[indexPath.row] else {
            return
        }
        createCitiesVC(with: data.id)
    }
    
    private func createCitiesVC(with id: Int) {
        let citiesViewController = CitiesViewController()
        citiesViewController.regionId = id
        navigationController?.pushViewController(citiesViewController, animated: true)
    }
}
