//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Work on 24.03.2025.
//

import UIKit

public final class FeedRefreshViewController: NSObject {
    public lazy var view = binded(UIRefreshControl())
    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    @objc func refresh() {
        viewModel.loadFeed()
    }
}
