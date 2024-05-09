//
//  UITableview+Extension.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import Foundation
import UIKit
extension UITableView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    func register<Cell: UITableViewCell>(_ cellType: Cell.Type, reuseIdentifier: String? = nil) {
         let identifier = reuseIdentifier ?? String(describing: cellType)
         let nib = UINib(nibName: identifier, bundle: nil)

         // Try to register using NIB (XIB), fallback to direct class registration
         if let _ = Bundle.main.path(forResource: identifier, ofType: "nib") {
             self.register(nib, forCellReuseIdentifier: identifier)
         } else {
             self.register(cellType, forCellReuseIdentifier: identifier)
         }
     }

    public func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: reuseIndentifier(for: headerFooterView))
    }

    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIndentifier(for: type)) as? T else {
            fatalError("Failed to dequeue footer view.")
        }

        return view
    }
}
