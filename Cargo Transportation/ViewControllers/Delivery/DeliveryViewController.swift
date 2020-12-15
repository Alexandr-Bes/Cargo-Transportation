//
//  DeliveryViewController.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import UIKit
import CoreData

class DeliveryViewController: UIViewController {
    
    var userDelivery: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserDelivery()
        print(userDelivery)
    }
    
    private func setupUI() {
        title = "Отправки"
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
