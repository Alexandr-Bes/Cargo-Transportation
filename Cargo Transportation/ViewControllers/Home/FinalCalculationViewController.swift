//
//  FinalCalculationViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 14.12.2020.
//

import UIKit
import CoreData

class FinalCalculationViewController: UIViewController {
    
    var servicesIDs: [String]?
    private var appRepository: MainAppRepositoryProtocol?
    private var responseData: CalculationReceiveDataModel?
    
    private var userDelivery: [NSManagedObject] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var dispatchLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateReceiveLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 16)
         label.numberOfLines = 1
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private lazy var finalSumLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.alpha = 0.5
        button.setTitle("Подтверждаю", for: .normal)
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
        title = "Расчет стоимости"
        setupScrollView()
        setupLabels()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupLabels() {
        scrollView.addSubview(dispatchLabel)
        scrollView.addSubview(dateReceiveLabel)
        scrollView.addSubview(finalSumLabel)
        scrollView.addSubview(descriptionLabel)
        view.addSubview(confirmButton)
        dispatchLabel.sizeToFit()
        dateReceiveLabel.sizeToFit()
        finalSumLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        
        setLabelsConstraint()
    }
    
    private func setLabelsConstraint() {
        dispatchLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        dateReceiveLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(scrollView.snp.trailing).inset(16)
            make.top.equalTo(dispatchLabel.snp.bottom).inset(-20)
        }
        finalSumLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(scrollView.snp.trailing).inset(-16)
            make.top.equalTo(dateReceiveLabel.snp.bottom).inset(-10)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(350)
//            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(finalSumLabel.snp.bottom).inset(-10)
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
        }
    }
    
    private func configLabels(with data: CalculationReceiveDataModel) {
        dispatchLabel.text = "\(data.warehouseSendIdName) -> \(data.warehouseResiveIdName)"
        dateReceiveLabel.text = "Дата получения посылки: \(dateFormat(from: data.dateResive))"
        finalSumLabel.text = "Стоимость: \(data.allSumma) грн"
        descriptionLabel.text = "Полная расшифровка: \n\(data.comment)"
    }
    
    @objc private func confirmAction(sender: UIButton) {
        saveUserDelivery()
        //TODO: - MOCKED activity indicator
        
    }

    private func dateFormat(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "HH:mm - dd MMM yyyy"
        
        let date = dateFormatter.date(from: dateString) ?? Date()
        return dateFormatterReturn.string(from: date)
    }
    
    private func downloadData() {
        self.showProgress()
        guard let requestModel = createRequestModel() else { return }
        appRepository?.calculateDelivery(model: requestModel, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.responseData = response.data
                self?.configLabels(with: response.data)
            case .failure(let error):
                print(error.debugDescription)
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        })
    }
    
    private func createRequestModel() -> CalculatorModel? {
        let appModel = AppDelegateProvider().provide().appModel
        guard let weight = appModel.weight,
              let size = appModel.size,
              let areasSendId = appModel.areasSendId,
              let areasReceiveId = appModel.areasReceiveId,
              let warehouseSendId = appModel.warehouseSendId,
              let warehouseReceiveId = appModel.warehouseReceiveId,
              let insuranceValue = appModel.insuranceValue,
              let cashOnDeliveryValue = appModel.cashOnDeliveryValue,
              let deliveryScheme = appModel.deliveryScheme
        else {
            return nil
        }
        
        //TODO: - Check if empty?
        guard let IDs = servicesIDs else { return nil }
        let category = CategoryModel(categoryId: "00000000-0000-0000-0000-000000000000", countPlace: 1, helf: weight, size: size)
        var dopUsluga = [DopUslugaModel]()
        for element in IDs {
            let model = DopUslugaModel(uslugaId: element, count: 1)
            dopUsluga.append(model)
        }
        let dopUslugi = DopUslugaClassificationModel(dopUsluga: dopUsluga)
        
        let model = CalculatorModel(culture: "ru-RU", areasSendId: areasSendId, areasResiveId: areasReceiveId, warehouseSendId: warehouseSendId, warehouseResiveId: warehouseReceiveId, InsuranceValue: insuranceValue, CashOnDeliveryValue: cashOnDeliveryValue, dateSend: AppDateFormatter.getLocalFormattedDate(), deliveryScheme: deliveryScheme, category: [category], dopUslugaClassificator: [dopUslugi])
    
        return model
    }
}

private extension FinalCalculationViewController {
    
    func saveUserDelivery() {
        let appModel = AppDelegateProvider().provide().appModel
        guard let insuranceValue = appModel.insuranceValue,
              let cashOnDeliveryValue = appModel.cashOnDeliveryValue,
              let dateReceive = responseData?.dateResive,
              let cost = responseData?.allSumma,
              let warehouseReceive = responseData?.warehouseResiveIdName,
              let warehouseSend = responseData?.warehouseSendIdName,
              let cityReceive = responseData?.areasResiveIdName,
              let citySend = responseData?.areasSendIdName
        else {
            return
        }
        
        let appDelegate = AppDelegateProvider().provide()
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "UserDelivery", in: managedContext) else { return }
        
        let userDelivery = NSManagedObject(entity: entity, insertInto: managedContext)
        userDelivery.setValue(cashOnDeliveryValue, forKeyPath: "cashOnDeliveryValue")
        userDelivery.setValue(cityReceive, forKey: "cityReceive")
        userDelivery.setValue(citySend, forKey: "citySend")
        userDelivery.setValue(cost, forKey: "cost")
        userDelivery.setValue(dateReceive, forKey: "dateReceive")
        userDelivery.setValue(Date(), forKey: "dateSend")
        userDelivery.setValue(insuranceValue, forKey: "insuranceValue")
        userDelivery.setValue("Отправлено", forKey: "status")
        userDelivery.setValue(warehouseReceive, forKey: "warehouseReceive")
        userDelivery.setValue(warehouseSend, forKey: "warehouseSend")

      do {
        try managedContext.save()
        self.userDelivery.append(userDelivery)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
}
