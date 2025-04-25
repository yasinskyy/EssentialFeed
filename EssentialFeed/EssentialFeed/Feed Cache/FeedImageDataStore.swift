//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Work on 25.04.2025.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
