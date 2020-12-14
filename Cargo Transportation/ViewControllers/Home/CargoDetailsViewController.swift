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
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(" Подтвердить ", for: .normal)
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
        
        view.addSubview(agreeButton)
        agreeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
        }
        
        deliverySchemePickerView.dataSource = self
        deliverySchemePickerView.delegate = self
        cashOnDeliveryTextField.delegate = self
        insuranceTextField.delegate = self
        weightTextField.delegate = self
        sizeTextField.delegate = self
        
        tableView.keyboardDismissMode = .onDrag
        
//        let confirmButton = UIBarButtonItem(title: "Подтвердить", style: .plain, target: self, action: #selector(confirmAction))
//        navigationItem.rightBarButtonItems = [confirmButton]
    }

    func downloadData() {
        self.showProgress()
        appRepository?.getDeliveryScheme(citySendID: "16617df3-a42a-e311-8b0d-00155d037960", cityReceiveID: "aa3250a4-402b-e311-8b0d-00155d037960", warehouseReceiveID: "f33b6d45-b249-e211-ab75-00155d012d0d", completion: { [weak self] (result) in
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
            print(selected?.name)
            showAdditionalServicesVC()
        }
    }
    
    private func showAdditionalServicesVC() {
        let viewController = AdditionalServicesViewController()
        viewController.citySendID = "16617df3-a42a-e311-8b0d-00155d037960"
        viewController.cityReceiveID = "aa3250a4-402b-e311-8b0d-00155d037960"
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

extension CargoDetailsTableViewController {
    
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
