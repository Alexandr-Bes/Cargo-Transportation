//
//  NewsViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import SnapKit

class NewsViewController: UIViewController {
    
    private static let cell = [NewsTableViewCell.self]
    private var data: NewsModel?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemGray3
        tableView.register(cells: NewsViewController.cell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadData()
    }
    
    func setupUI() {
        title = "Новости"
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func downloadData() {
        let networkManager = NetworkManager()
        self.showProgress()
        networkManager.downloadNews { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.data = data
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showAlert(error: error)
            }
            self?.hideProgress()
        }
    }
    

}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let datas = data?.data[indexPath.row]
        cell.configure(with: datas)
        cell.backgroundColor = .systemGray3
        return cell
    }
    
    
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
