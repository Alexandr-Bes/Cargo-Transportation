//
//  HomeTableViewCell.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 09.12.2020.
//

import SnapKit

final class HomeTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
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
        addSubview(addressLabel)
        addSubview(workingTimeLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(8)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(8)
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.trailing.lessThanOrEqualTo(workingTimeLabel.snp.leading).inset(-10)
        }
    
        workingTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(with data: SearchByCoordinatesDataModel) {
        nameLabel.text = data.name
        addressLabel.text = data.address
        workingTimeLabel.text = data.workingTime
//        publishDateLabel.text = getLocalTime(for: datas.publishDate)
    }
    
//    private func getLocalTime(for dateString: String) -> String {
//        let appDateFormatter = AppDateFormatter()
//        let date = appDateFormatter.date(from: dateString)
//        let dateFormat = "HH:mm - dd MMM yyyy"
//        let newDateFormater = DateFormatter()
//        newDateFormater.dateFormat = dateFormat
//        let newTime = newDateFormater.string(from: date ?? Date())
//        return newTime
//    }
}
