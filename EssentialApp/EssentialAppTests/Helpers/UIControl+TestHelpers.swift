//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Work on 28.04.2025.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
