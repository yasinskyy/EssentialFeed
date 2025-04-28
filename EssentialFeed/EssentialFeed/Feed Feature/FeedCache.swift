//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Work on 27.04.2025.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (FeedCache.SaveResult) -> Void)
}
