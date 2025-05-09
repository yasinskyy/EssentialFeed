//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Work on 09.05.2025.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
