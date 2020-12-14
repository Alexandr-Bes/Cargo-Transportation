//
//  NewsTableViewCell.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title test"
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Date"
        label.font = .systemFont(ofSize: 9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Content"
        label.numberOfLines = 0
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
        addSubview(titleLabel)
        addSubview(publishDateLabel)
        addSubview(contentLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        publishDateLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(with data: NewsModelData?) {
        guard let datas = data else {
            return
        }
        
        let htmlText = Data(datas.content.utf8)
        
        if let attributedString = try? NSAttributedString(data: htmlText, options: [.documentType: NSAttributedString.DocumentType.plain], documentAttributes: nil) {
            contentLabel.attributedText = attributedString
        }
        
        titleLabel.text = datas.title
        publishDateLabel.text = getLocalTime(for: datas.publishDate)
    }
    
    private func getLocalTime(for dateString: String) -> String {
        let appDateFormatter = AppDateFormatter()
        let date = appDateFormatter.date(from: dateString)
        let dateFormat = "dd MMM yyyy"
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = dateFormat
        let newTime = newDateFormater.string(from: date ?? Date())
        return newTime
    }

}
