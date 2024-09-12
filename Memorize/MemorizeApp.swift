//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Shirin Sitara AJ on 24/07/2024.
//

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
