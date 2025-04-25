//
//  HTTPURLResponseExtensions.swift
//  EssentialFeed
//
//  Created by Work on 25.04.2025.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    var isOK: Bool { return statusCode == HTTPURLResponse.OK_200 }
}
