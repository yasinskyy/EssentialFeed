//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Innocode on 08.01.2025.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
                
        let items = root.items
        return items
    }
}
