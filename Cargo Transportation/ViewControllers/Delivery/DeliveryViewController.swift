//
//  DeliveryViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit
import CoreData

class DeliveryViewController: UIViewController {
    
    private var userDelivery: [NSManagedObject] = []
    private static let cell = [DeliveryCell.self]
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray
        tableView.register(cells: DeliveryViewController.cell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserDelivery()
        tableView.reloadData()
    }
    
    private func setupUI() {
        title = "Отправки"
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func getUserDelivery() {
        let appDelegate = AppDelegateProvider().provide()

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDelivery")

        do {
          userDelivery = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension DeliveryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDelivery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeliveryCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let dataBaseData = userDelivery[indexPath.row]
        guard let data = createUserDeliveryModel(data: dataBaseData) else { return UITableViewCell() }
        cell.configCell(with: data)
        cell.backgroundColor = .systemGray
        return cell
    }
    
    private func createUserDeliveryModel(data: NSManagedObject) -> UserDeliveryModel? {
        guard let citySend = data.value(forKeyPath: "citySend") as? String,
              let cityReceive = data.value(forKey: "cityReceive") as? String,
              let warehouseSend = data.value(forKey: "warehouseSend") as? String,
              let warehouseReceive = data.value(forKey: "warehouseReceive") as? String,
              let dateSend = data.value(forKey: "dateSend") as? Date,
              let dateReceive = data.value(forKey: "dateReceive") as? String,
              let cashOnDelivery = data.value(forKey: "cashOnDeliveryValue") as? Double,
              let status = data.value(forKey: "status") as? String
        else {
            return nil
        }
        
        return UserDeliveryModel(citySend: citySend, cityReceive: cityReceive, warehouseSend: warehouseSend, warehouseReceive: warehouseReceive, dateSend: dateSend, dateReceive: dateReceive, cashOnDelivery: cashOnDelivery, status: status)
    }

}
