//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Work on 04.02.2025.
//

import XCTest

class LocalFeedLoader {
    
    init(store: FeedStore) {
        
    }
}

class FeedStore {
    var deleteCachedFeedCallCount = 0
    
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteStoreUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
}
