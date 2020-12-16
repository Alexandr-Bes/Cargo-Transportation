//
//  DeliveryCell.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 16.12.2020.
//

import UIKit

final class DeliveryCell: UITableViewCell {
    
    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var warehouseSendLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var warehouseReceiveLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateReceiveLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateSendLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cashOnDeliveryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(destinationLabel)
        addSubview(warehouseSendLabel)
        addSubview(warehouseReceiveLabel)
        addSubview(dateSendLabel)
        addSubview(dateReceiveLabel)
        addSubview(cashOnDeliveryLabel)
        addSubview(statusLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        destinationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        warehouseSendLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(destinationLabel.snp.bottom).inset(-8)
//            make.trailing.lessThanOrEqualTo(warehouseReceiveLabel.snp.leading).inset(-10)
        }
        warehouseReceiveLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(warehouseSendLabel.snp.bottom).inset(-8)
        }
        dateSendLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(warehouseReceiveLabel.snp.bottom).inset(-8)
        }
        dateReceiveLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(dateSendLabel.snp.bottom).inset(-8)
        }
        cashOnDeliveryLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(dateReceiveLabel.snp.bottom).inset(-8)
        }
        statusLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(cashOnDeliveryLabel.snp.bottom).inset(-8)
        }
    }
    
    func configCell(with data: UserDeliveryModel) {
        destinationLabel.text = "\(data.citySend) -> \(data.cityReceive)"
        warehouseSendLabel.attributedText = makeAttributtedString(title: "Склад отправления: ", text: data.warehouseSend)
        warehouseReceiveLabel.attributedText = makeAttributtedString(title: "Склад получения: ", text: data.warehouseReceive)
        dateSendLabel.attributedText = makeAttributtedString(title: "Дата отправки: ", text: formatDate(data.dateSend))
        dateReceiveLabel.attributedText = makeAttributtedString(title: "Дата получения: ", text: dateFormat(from: data.dateReceive))
        cashOnDeliveryLabel.attributedText = makeAttributtedString(title: "Наложенный платеж: ", text: "\(data.cashOnDelivery)")
        statusLabel.attributedText = makeAttributtedString(title: "Статус: ", text: data.status)
    }
    
    private func makeAttributtedString(title: String, text: String) -> NSAttributedString {
        let titleAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let result = NSMutableAttributedString(string: title, attributes: titleAttribute)
        let textAttribute = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        result.append(textAttribute)
        return result
    }
    
    private func dateFormat(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "HH:mm - dd MMM yyyy"
        
        let date = dateFormatter.date(from: dateString) ?? Date()
        return dateFormatterReturn.string(from: date)
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm - dd MMM yyyy"
        return dateFormatter.string(from: date)
    }

}
