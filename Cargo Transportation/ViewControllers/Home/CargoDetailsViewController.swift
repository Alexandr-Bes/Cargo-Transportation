//
//  CargoDetailsViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 13.12.2020.
//

import UIKit

class CargoDetailsTableViewController: UITableViewController {
    
    @IBOutlet var deliverySchemePickerView: UIPickerView!
    @IBOutlet var cashOnDeliveryTextField: UITextField!
    @IBOutlet var insuranceTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var sizeTextField: UITextField!
    
    
    private var receivedData:[DeliverySchemeDataModel]?
    private var appRepository: MainAppRepositoryProtocol?
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
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
    
    func setupUI() {
        title = "Детали"
        navigationItem.backButtonTitle = "Назад"
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            let screenWidth = view.frame.width
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(screenWidth - 48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
        }
        
        deliverySchemePickerView.dataSource = self
        deliverySchemePickerView.delegate = self
        cashOnDeliveryTextField.delegate = self
        insuranceTextField.delegate = self
        weightTextField.delegate = self
        sizeTextField.delegate = self
        
        tableView.keyboardDismissMode = .onDrag
    }

    func downloadData() {
        self.showProgress()
        let appModel = AppDelegateProvider().provide().appModel
        guard let citySendId = appModel.areasSendId,
              let cityReceiveId = appModel.areasReceiveId,
              let warehouseReceiveID = appModel.warehouseReceiveId else {
            return
        }
        
        appRepository?.getDeliveryScheme(citySendID: citySendId, cityReceiveID: cityReceiveId, warehouseReceiveID: warehouseReceiveID, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.receivedData = response.data
                self?.deliverySchemePickerView.reloadAllComponents()
            case .failure(let error):
                print(error.debugDescription)
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        })
    }
    
    @objc private func confirmAction() {
        if isTextFieldsEmpty() {
            showAlertMessage()
        } else {
            let selected = receivedData?[deliverySchemePickerView.selectedRow(inComponent: 0)]
            print(selected?.name as Any)
            showAdditionalServicesVC()
        }
    }
    
    private func showAdditionalServicesVC() {
        configAppModel()
        let viewController = AdditionalServicesViewController()
        guard let citySendId = AppDelegateProvider().provide().appModel.areasSendId,
              let cityReceiveId = AppDelegateProvider().provide().appModel.areasReceiveId else {
            return
        }
        viewController.citySendID = citySendId
        viewController.cityReceiveID = cityReceiveId
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func isTextFieldsEmpty() -> Bool {
        if cashOnDeliveryTextField.text?.isEmpty ?? true
            || insuranceTextField.text?.isEmpty ?? true
            || weightTextField.text?.isEmpty ?? true
            || sizeTextField.text?.isEmpty ?? true
            {
            return true
        } else {
            return false
        }
    }
    
    private func showAlertMessage() {
        let alert = UIAlertController(title: nil, message: "Пожалуйста введите все данные о грузе", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

private extension CargoDetailsTableViewController {
    func configAppModel() {
        //Delivery Scheme
        guard let schemeString = receivedData?[deliverySchemePickerView.selectedRow(inComponent: 0)].id,
              let scheme = Int(schemeString) else { return }
        AppDelegateProvider().provide().appModel.deliveryScheme = scheme
        
        // CashOnDelivery
        guard let cashOnDeliveryString = cashOnDeliveryTextField.text,
              let cashOnDelivery = Double(cashOnDeliveryString) else { return }
        AppDelegateProvider().provide().appModel.cashOnDeliveryValue = cashOnDelivery
        
        // Insurance
        guard let insuranceString = insuranceTextField.text,
              let insurance = Double(insuranceString) else { return }
        AppDelegateProvider().provide().appModel.insuranceValue = insurance
        
        // Weight
        guard let weightString = weightTextField.text,
              let weight = Double(weightString) else { return }
        AppDelegateProvider().provide().appModel.weight = weight
        
        // Size
        guard let sizeString = sizeTextField.text,
              let size = Double(sizeString) else { return }
        AppDelegateProvider().provide().appModel.size = size
    }
}

extension CargoDetailsTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cashOnDeliveryTextField {
            insuranceTextField.becomeFirstResponder()
        } else if textField == insuranceTextField {
            weightTextField.becomeFirstResponder()
        } else if textField == weightTextField {
            sizeTextField.becomeFirstResponder()
        } else if textField == sizeTextField {
            view.endEditing(true)
        }
        return true
    }
}

extension CargoDetailsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return receivedData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = receivedData?[row] else { return "No data" }
        return data.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = receivedData?[row] else { return }
        print(data.id)
        print(data.name)
    }
    
}
