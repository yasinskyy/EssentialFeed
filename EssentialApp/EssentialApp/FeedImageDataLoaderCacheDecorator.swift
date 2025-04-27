//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Work on 27.04.2025.
//

import Foundation
import EssentialFeed

public class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            if let imageData = try? result.get() {
                self?.cache.save(imageData, for: url) { _ in }
            }
            completion(result)
        }
    }
}
