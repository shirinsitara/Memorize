//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Shirin Sitara AJ on 24/07/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var gameModel: EmojiMemoryGame
    
    var body: some View {
        ZStack {
            VStack{
                Text("Score: \(gameModel.score)")
                    .font(.title2)
                    .foregroundStyle(.blue)
                ScrollView {
                    cards
                        .padding()
                        .animation(.default, value: gameModel.cards)
                }
                Spacer()
                Button("Shuffle"){
                    gameModel.shuffle()
                }
                .padding()
                .font(.title3)
                .foregroundColor(.blue)
            }
            .padding()
            .onAppear {
                gameModel.cards.forEach {
                    print($0.debugDescription)
                }
            }
            
            if gameModel.isGameOver {
                VStack {
                    Text("Congratulations!🥳")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Text("You won with a score of \(gameModel.score)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Button("Restart game"){
                        gameModel.restartGame()
                    }
                    .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: gameModel.isGameOver)
    }

    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(gameModel.cards){ card in
                CardView(card: card)
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        gameModel.choose(card)
                    }
            }
        }

        .foregroundColor(.orange)
    }
}
    

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content.name).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)

            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isVisible ? (card.isFaceUp || !card.isMatched ? 1:0): 0)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider{
    static var previews: some View{
        EmojiMemoryGameView(gameModel: EmojiMemoryGame())
    }
}
    
    
