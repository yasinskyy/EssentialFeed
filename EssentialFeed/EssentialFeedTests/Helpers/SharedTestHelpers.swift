//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Work on 11.02.2025.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}
