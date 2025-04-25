//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Work on 25.04.2025.
//

import Foundation

public protocol FeedImageDataStore {
    typealias RetrievalResult = Swift.Result<Data?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    typealias InsertionResult = Swift.Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void

    func retrieve(dataForURL url: URL, completion: @escaping RetrievalCompletion)
    func insert(_ data: Data, for url: URL, completion: @escaping InsertionCompletion)
}
