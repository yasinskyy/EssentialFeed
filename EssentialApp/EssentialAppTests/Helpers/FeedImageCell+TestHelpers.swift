//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Work on 28.04.2025.
//

import UIKit
import EssentialFeediOS

extension FeedImageCell {
    var isShowingLocation: Bool { return !locationContainer.isHidden }
    var isShowingImageLoadingIndicator: Bool { return feedImageContainer.isShimmering }
    var isShowingRetryAction: Bool { return !feedImageRetryButton.isHidden }
    var locationText: String? { return locationLabel.text }
    var descriptionText: String? { return descriptionLabel.text }
    var renderedImage: Data? { return feedImageView.image?.pngData() }
    
    func simulateRetryAction() {
        feedImageRetryButton.simulateTap()
    }
}
