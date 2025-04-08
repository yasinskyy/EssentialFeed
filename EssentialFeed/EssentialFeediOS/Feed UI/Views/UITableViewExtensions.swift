//
//  UITableViewExtensions.swift
//  EssentialFeediOS
//
//  Created by Work on 08.04.2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
