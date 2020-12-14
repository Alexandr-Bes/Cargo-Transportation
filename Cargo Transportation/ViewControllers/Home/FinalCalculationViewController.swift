//
//  FinalCalculationViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 14.12.2020.
//

import UIKit

class FinalCalculationViewController: UIViewController {
    
    var servicesIDs: [String]?
    private var appRepository: MainAppRepositoryProtocol?
    private var responseData: CalculationReceiveDataModel?
    
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
    }
    
    private func configLabels(with data: CalculationReceiveDataModel) {
        dispatchLabel.text = "\(data.warehouseSendIdName) -> \(data.warehouseResiveIdName)"
        dateReceiveLabel.text = "Дата получения посылки: \(dateFormat(from: data.dateResive))"
        finalSumLabel.text = "Стоимость: \(data.allSumma) грн"
        descriptionLabel.text = data.comment
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
        //TODO: - Check if empty?
        guard let ids = servicesIDs else { return nil }
        let category = CategoryModel(categoryId: "00000000-0000-0000-0000-000000000000", countPlace: 1, helf: 2, size: 2)
        var dopUsluga = [DopUslugaModel]()
        for element in ids {
            let model = DopUslugaModel(uslugaId: element, count: 1)
            dopUsluga.append(model)
        }
        let dopUslugi = DopUslugaClassificationModel(dopUsluga: dopUsluga)
        let model = CalculatorModel(culture: "ru-RU", areasSendId: "16617df3-a42a-e311-8b0d-00155d037960", areasResiveId: "63e72aa4-3f2b-e311-8b0d-00155d037960", warehouseSendId: "71322701-ca82-e511-8f9d-000d3a200160", warehouseResiveId: "5aca54b4-f858-e411-afed-000d3a200936", InsuranceValue: 10000.2, CashOnDeliveryValue: 4000, dateSend: "15.12.2020", deliveryScheme: 2, category: [category], dopUslugaClassificator: [dopUslugi])
        return model
    }
    


}
