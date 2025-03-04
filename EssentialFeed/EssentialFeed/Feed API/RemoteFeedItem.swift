//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Work on 06.02.2025.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
