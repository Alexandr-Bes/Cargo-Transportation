//
//  AdditionalServicesViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 13.12.2020.
//

import UIKit

class AdditionalServicesViewController: UIViewController {
    
    var citySendID: String?
    var cityReceiveID: String?
    
    private var appRepository: MainAppRepositoryProtocol?
    private var responseData: [AdditionalServicesDataModel]?
    private let cell = [AdditionalServicesCell.self]
    private var selectedServicesIDs = [String]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.backgroundColor = .darkGray
        tableView.register(cells: cell)
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.alpha = 0.5
        button.setTitle("Дальше", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        button.layer.cornerRadius = 9
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        title = "Дополнительные услуги"
        setupTableView()
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func downloadData() {
        self.showProgress()
        appRepository?.getAdditionalServices(citySendID: citySendID ?? "", cityReceiveID: cityReceiveID ?? "", completion: { [weak self] (result) in
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
    
    @objc private func confirmAction(sender: UIButton) {
        if tableView.indexPathsForSelectedRows?.isEmpty ?? true {
            showAlertMessage()
        } else {
            selectedServicesIDs = [String]()
            if let selectedItems = tableView.indexPathsForSelectedRows {
//                let servicesIDs = selectedItems.map { responseData?[$0.section].services[$0.row].uslugaId }
                for element in selectedItems {
                    guard let serviceId = responseData?[element.section].services[element.row].uslugaId else { return }
                    selectedServicesIDs.append(serviceId)
                }
                print("Service name: \(selectedItems.map { responseData?[$0.section].services[$0.row].name})")
                print("Service id: \(selectedItems.map { responseData?[$0.section].services[$0.row].uslugaId})")
            }
            showResultVC(with: selectedServicesIDs)
        }
    }
    
    private func showAlertMessage() {
        let alert = UIAlertController(title: nil, message: "Вы уверены, что не хотите выбрать дополнительные услуги?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Подтверждаю", style: .default) { [weak self] (action) in
            guard let _self = self else { return }
            _self.showResultVC(with: _self.selectedServicesIDs)
        }
        alert.addAction(UIAlertAction(title: "Вернуться", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showResultVC(with servicesIDs: [String]) {
        let viewController = FinalCalculationViewController()
        viewController.servicesIDs = servicesIDs
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension AdditionalServicesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let headerString = responseData?[section].name else { return ""}
        return headerString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = responseData?[section] else { return 0 }
        return data.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AdditionalServicesCell = tableView.dequeueReusableCell(indexPath: indexPath)
        guard let data = responseData?[indexPath.section].services[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: data.name, and: Int(data.cost))
        return cell
    }
    
}

extension AdditionalServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class AdditionalServicesViewModel {
    var model: [AdditionalServicesDataModel]
    var isSelected = false
    
    init(model: [AdditionalServicesDataModel]) {
        self.model = model
    }
}
