import SwiftUI

struct DojoMemoryView: View {
    
    @ObservedObject var gameModel: DojoMemoryGame
    
    var body: some View {
        ZStack{
            VStack{
                Text("Score = \(gameModel.score)")
                    .font(.title2)
                    .padding(.top)
                    .foregroundColor(Color(hex: "003F33"))
                
//                //time implementation trial
//                Text("Time: \(gameModel.timeRemaining)")
//                                    .font(.title2)
//                                    .foregroundStyle(.red)
//                                    .padding()
                ScrollView{
                    cards2
                        .padding()
                        .animation(.default, value: gameModel.cards2)
                }
                Spacer()
                Button("Shuffle"){
                    gameModel.shuffle()
                }
                .padding()
                .font(.title2)
                .foregroundColor(Color(hex:"003F33"))  //Active teal = "3CEAC7"
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
    }
    
    var cards2: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(gameModel.cards2){ card in
                CardView2(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        gameModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color(hex: "#3CEAC7"))
    }
}

struct CardView2: View{
    let card: Card
    
    let backImage = UIImage(named: "dojoIcon")!
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            //front side
            Group{
                base.fill(Color(hex: "#F1F1EC"))  //calm whie : #F1F1EC
                base.strokeBorder(lineWidth: 2)
                Image(uiImage: card.content.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1:0)
                .frame(width: 80, height: 110)
            
            //back side
            Group{
                //base.fill(Color(hex: "#003F33"))  //sea green
                //base.strokeBorder(lineWidth: 2)
                Image(uiImage: backImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12) )
            }
                .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isVisible ? (card.isFaceUp || !card.isMatched ? 1:0): 0)
    }
}

struct IdentifiableImage: Identifiable, Equatable {
    var id: String { name } //helps make it identifiable
    let name: String
    
    var image: UIImage {
        UIImage(named: name)!
    }
    
    init(name: String) {
        self.name = name
    }
}

struct DojoMemoryGame_Previews: PreviewProvider{
    static var previews: some View{
        DojoMemoryView(gameModel: DojoMemoryGame())
    }
}


//colour correction
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


