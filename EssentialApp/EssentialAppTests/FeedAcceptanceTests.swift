//
//  FeedAcceptanceTests.swift
//  EssentialAppTests
//
//  Created by Work on 28.04.2025.
//

import XCTest
import EssentialFeed
import EssentialFeediOS
@testable import EssentialApp

class FeedAcceptanceTests: XCTestCase {
    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let feed = launch(httpClient: .online(response), store: .empty)
        
        XCTAssertEqual(feed.numberOfRenderedFeedImageViews(), 2)
        XCTAssertEqual(feed.renderedFeedImageData(at: 0), makeImageData())
        XCTAssertEqual(feed.renderedFeedImageData(at: 1), makeImageData())
    }
    
    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {
        let sharedStore = InMemoryFeedStore.empty
        let onlineFeed = launch(httpClient: .online(response), store: sharedStore)
        onlineFeed.simulateFeedImageViewVisible(at: 0)
        onlineFeed.simulateFeedImageViewVisible(at: 1)
        
        let offlineFeed = launch(httpClient: .offline, store: sharedStore)
        
        XCTAssertEqual(offlineFeed.numberOfRenderedFeedImageViews(), 2)
        XCTAssertEqual(offlineFeed.renderedFeedImageData(at: 0), makeImageData())
        XCTAssertEqual(offlineFeed.renderedFeedImageData(at: 1), makeImageData())
    }
    
    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {
        let feed = launch(httpClient: .offline, store: .empty)
        
        XCTAssertEqual(feed.numberOfRenderedFeedImageViews(), 0)
    }
    
    func test_onEnteringBackground_deletesExpiredFeedCache() {
        let store = InMemoryFeedStore.withExpiredFeedCache
        
        enterBackground(with: store)
        
        XCTAssertNil(store.feedCache, "Expected to delete expired cache")
    }
    
    func test_onEnteringBackground_keepsNonExpiredFeedCache() {
        let store = InMemoryFeedStore.withNonExpiredFeedCache
        
        enterBackground(with: store)
        
        XCTAssertNotNil(store.feedCache, "Expected to keep non-expired cache")
    }
    
    // MARK: - Helpers
    
    private func launch(httpClient: HTTPClientStub = .offline, store: InMemoryFeedStore = .empty) -> FeedViewController {
        let sut = SceneDelegate(httpClient: httpClient, store: store)
        sut.window = UIWindow()
        sut.configureWindow()
        
        let navigationController = sut.window?.rootViewController as? UINavigationController
        let feedViewController = navigationController?.topViewController as! FeedViewController
        feedViewController.loadViewIfNeeded()
        feedViewController.simulateAppearance()
        
        return feedViewController
    }
    
    private func enterBackground(with store: FeedStore & FeedImageDataStore) {
        let sut = SceneDelegate(httpClient: HTTPClientStub.offline, store: store)
        sut.sceneWillResignActive(UIApplication.shared.connectedScenes.first!)
    }
    
    private class HTTPClientStub: HTTPClient {
        private class Task: HTTPClientTask {
            func cancel() {}
        }
        
        private let stub: (URL) -> HTTPClient.Result
        
        static var offline: HTTPClientStub {
            HTTPClientStub { _ in .failure(NSError(domain: "offlie", code: 0)) }
        }
        
        static func online(_ stub: @escaping (URL) -> (Data, HTTPURLResponse)) -> HTTPClientStub {
            HTTPClientStub { url in .success(stub(url)) }
        }
        
        init(stub: @escaping (URL) -> HTTPClient.Result) {
            self.stub = stub
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
            completion(stub(url))
            return Task()
        }
    }
    
    private class InMemoryFeedStore: FeedStore, FeedImageDataStore {
        private(set) var feedCache: CachedFeed?
        private var feedImageDataCache: [URL: Data] = [:]
        
        static var empty: InMemoryFeedStore { return InMemoryFeedStore() }
        
        static var withExpiredFeedCache: InMemoryFeedStore {
            return InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date.distantPast))
        }
        
        static var withNonExpiredFeedCache: InMemoryFeedStore {
            return InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date()))
        }
        
        private init(feedCache: CachedFeed? = nil) {
            self.feedCache = feedCache
        }
        
        func deleteCachedFeed(completion: @escaping DeletionCompletion) {
            feedCache = nil
            completion(.success(()))
        }
        
        func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
            feedCache = CachedFeed(feed: feed, timestamp: timestamp)
            completion(.success(()))
        }
        
        func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
            completion(.success(feedCache))
        }

        func insert(_ data: Data, for url: URL, completion: @escaping FeedImageDataStore.InsertionCompletion) {
            feedImageDataCache[url] = data
            completion(.success(()))
        }
        
        func retrieve(dataForURL url: URL, completion: @escaping FeedImageDataStore.RetrievalCompletion) {
            completion(.success(feedImageDataCache[url]))
        }
    }
    
    private func response(for url: URL) -> (Data, HTTPURLResponse) {
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (makeData(for: url), response)
    }
    
    private func makeData(for url: URL) -> Data {
        switch url.absoluteString {
        case "https://image.com":
            return makeImageData()
        default:
            return makeFeedData()
        }
    }
    
    private func makeImageData() -> Data {
        return UIImage.make(withColor: .red).pngData()!
    }
    
    private func makeFeedData() -> Data {
        return try! JSONSerialization.data(withJSONObject: ["items": [
            ["id": UUID().uuidString, "image": "https://image.com"],
            ["id": UUID().uuidString, "image": "https://image.com"]
        ]])
    }
}
