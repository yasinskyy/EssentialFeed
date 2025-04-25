//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Work on 17.01.2025.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private struct UnexpectedValuesRepresentation: Error { }
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask

        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            completion(Result(catching: {
                if let error {
                    throw error
                } else if let data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            }))
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
