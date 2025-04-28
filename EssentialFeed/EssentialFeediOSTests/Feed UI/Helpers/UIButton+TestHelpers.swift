//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Work on 28.04.2025.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
