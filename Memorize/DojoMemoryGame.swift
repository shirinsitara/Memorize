import SwiftUI
import Combine

class DojoMemoryGame: ObservableObject {
    
//    @Published var timeRemaining: Int
//    private var timer: AnyCancellable?
//    private let gameDuration: Int = 90
//    
//    init() {
//            game2.score = 0
//            game2.isGameOver = false
//            timeRemaining = gameDuration
//            startTimer()
//        }
    
    static var dojoImages: [IdentifiableImage] = [
        IdentifiableImage(name: "1"),
        IdentifiableImage(name: "2"),
        IdentifiableImage(name: "3"),
        IdentifiableImage(name: "4"),
        IdentifiableImage(name: "5"),
        IdentifiableImage(name: "6"),
        IdentifiableImage(name: "7"),
        IdentifiableImage(name: "8"),
        IdentifiableImage(name: "9"),
        IdentifiableImage(name: "10")
    ]
    
    private static func createMemoryGame2()->MemoryGame {
        return MemoryGame(numberOfPairs: 7, cardContectFactory: {
            pairIndex in
            if dojoImages.indices.contains(pairIndex){
                return dojoImages[pairIndex]
            } else {
                return dojoImages[0]
            }
        }, completion: {
            
        })
    }
    
    @Published private var game2 = createMemoryGame2()
    
    var cards2: Array<Card> {
        return game2.cards
    }
    
    var score: Int {
        return game2.score
    }
    
    var isGameOver: Bool {
        return game2.isGameOver
    }
    
    func shuffle(){
        game2.shuffle()
    }
    
    func restartGame(){
        game2.restart()
    }
    
    func choose(_ card: Card){
        game2.choose(card: card)
    }

    
    //tried implementing the time --> error required me to convert the model game 2 to a class from its original form of a class
    
//    private func startTimer() {
//            timer?.cancel() // Cancel any existing timer
//            timer = Timer.publish(every: 1, on: .main, in: .common)
//                .autoconnect()
//                .sink { [weak self] _ in
//                    guard let self = self else { return }
//                    if self.timeRemaining > 0 {
//                        self.timeRemaining -= 1
//                    } else {
//                        game2.isGameOver = true
//                        self.timer?.cancel()
//                    }
//                }
//        }
    
    
}



