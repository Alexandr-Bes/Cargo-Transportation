//
//  UITableViewCell+Reusable.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 28.11.2020.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableView {
    func register<C: ReusableCell & NibInstantiatable>(cell: C.Type) {
        self.register(C.nib, forCellReuseIdentifier: C.reuseIdentifier)
    }

    func register<T: UITableViewCell>(cells: Array<T.Type>) {
        
        cells.forEach { self.register($0, forCellReuseIdentifier: $0.identifier()) }
    }

    func registerNib<T: UITableViewCell>(cellClass: T.Type) {
        let reuseIdentifier = String(describing: cellClass)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: ReusableCell>(withType type: Cell.Type, forRowAt indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue reusable cell with \(Cell.reuseIdentifier) reuse identifier.")
        }

        return cell
    }
    
    
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T where T: UITableViewCell {
            
        let reuseIdentifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T
            else {
                fatalError("\(reuseIdentifier) can't find")
        }
        return cell
    }
}
