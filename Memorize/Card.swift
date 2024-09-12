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
