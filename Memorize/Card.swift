//
//  Card.swift
//  Memorize
//
//  Created by Shirin Sitara AJ on 01/08/2024.
//

import Foundation

struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    var isFaceUp = false
    var isMatched = false
    var isVisible = true
    let content: IdentifiableImage
    var id: String
    var debugDescription: String {
        "\(id): \(content.id) \(content.name) \(isFaceUp ? "up": "down") \(isMatched ? "matched" : "")"
    }
}
