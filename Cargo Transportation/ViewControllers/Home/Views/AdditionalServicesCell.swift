//
//  AdditionalServicesCell.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 13.12.2020.
//

import UIKit

class AdditionalServicesCell: UITableViewCell {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
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
        addSubview(nameLabel)
        addSubview(costLabel)
        nameLabel.sizeToFit()
        setConstraints()
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.leading.equalToSuperview().inset(16)
        }
        costLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).inset(-10)
        }
    }
    
    func configure(with name: String, and cost: Int) {
        nameLabel.text = name
        costLabel.text = "\(cost) грн"
    }
    
}
