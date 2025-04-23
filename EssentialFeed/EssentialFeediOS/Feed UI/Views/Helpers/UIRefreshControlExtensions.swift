//
//  UIRefreshControlExtensions.swift
//  EssentialFeediOS
//
//  Created by Work on 23.04.2025.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
