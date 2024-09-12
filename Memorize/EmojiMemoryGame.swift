import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis: [IdentifiableImage] = [
        .init(name: "🎾"),
        .init(name: "🪁"),
        .init(name: "😊"),
        .init(name: "😎"),
        .init(name: "🛼"),
        .init(name: "⏰"),
        .init(name: "💻"),
        .init(name: "💿"),
        .init(name: "🏌️‍♂️"),
        .init(name: "🏈")
    ]
    
    private static func createMemoryGame()->MemoryGame {
        return MemoryGame(numberOfPairs: 7, cardContectFactory: {
            pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return .init(name: "⁉️")
            }
        }, completion: {
            
        })
    }
    
    //var objectWillChange: ObservableObjectPublisher
    @Published var game = createMemoryGame()
    
        
    var cards:Array<Card> {
        return game.cards
    }
    
    var score: Int {
        game.score
    }
    
    var isGameOver: Bool {
        return game.isGameOver
    }
    
    func restartGame() {
        game.restart()
    }

    
    //MARK: - Intents
    func shuffle(){
        game.shuffle()
        
        //objectWillChange.send()
    }
    
    func choose(_ card: Card){
        print("chose \(card)")
        game.choose(card: card)
    }
    
    
}
