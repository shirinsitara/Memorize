import SwiftUI

@main
//struct MemorizeApp: App {
//    @StateObject var game = EmojiMemoryGame()
//    var body: some Scene {
//        WindowGroup {
//            EmojiMemoryGameView(gameModel: game)
//        }
//    }
//}
struct MemorizeApp: App {
    @StateObject var game = DojoMemoryGame()
    var body: some Scene {
        WindowGroup {
            DojoMemoryView(gameModel: game)
        }
    }
}
