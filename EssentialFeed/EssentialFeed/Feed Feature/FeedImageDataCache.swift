//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Work on 27.04.2025.
//

import Foundation

public protocol FeedImageDataCache {
    typealias SaveResult = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (FeedImageDataCache.SaveResult) -> Void)
}
