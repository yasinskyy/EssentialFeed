//
//  CoreDataFeedStoreExtensions.swift
//  EssentialFeed
//
//  Created by Work on 25.04.2025.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    public func retrieve(dataForURL url: URL, completion: @escaping FeedImageDataStore.RetrievalCompletion) {
        completion(.success(.none))
    }
    
    public func insert(_ data: Data, for url: URL, completion: @escaping FeedImageDataStore.InsertionCompletion) {

    }
}
