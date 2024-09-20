import Foundation
import Combine



struct MemoryGame: Equatable {
    
    var isGameOver: Bool = false
    
    //conforming to Equatable
    static func == (lhs: MemoryGame, rhs: MemoryGame) -> Bool {
        lhs.cards == rhs.cards
    }

    private(set) var cards: Array<Card>
    private let completion: () -> Void
    var score: Int = 0
    
    
    init(numberOfPairs: Int, cardContectFactory:(Int)->IdentifiableImage, completion: @escaping () -> Void){
        cards = []
        // adding 2 x number of cards
        for pair in 0..<numberOfPairs{
            let content = cardContectFactory(pair)
            cards.append(Card(content: content, id: "\(pair+1)a"))
            cards.append(Card(content: content, id: "\(pair+1)b"))
        }
        self.completion = completion
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter {index in cards[index].isFaceUp}.only
        }
        set{
            cards.indices.forEach {
                cards[$0].isFaceUp = (newValue == $0)
            }
        }
    }
    
    
    mutating func choose(card: Card){
        
        var visibleCards: Int
        
        if let chosenIndex = cards.firstIndex(where: {cardToCheck in cardToCheck.id == card.id}){
            //valid game choice
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched { //every time any card is chosen
                
                //if it the second card
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    //right match
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isVisible = false
                        cards[potentialMatchIndex].isVisible = false
                        score += 10
                    } else {
                        score -= 5
                    }

                    //last pair
                    visibleCards = 0
                    for index in cards.indices{
                        if cards[index].isVisible {
                            visibleCards += 1
                        }
                    }
                    if visibleCards == 0 {
                        print("GAME COMPLETED")
                        isGameOver = true
                    }
//                    completion() TODO:
                }
                
                //it is the first card
                else
                {
                    //it doesn't hurt to turn all cards down now, because if this is the first card you're turning, the actual turn in applied after this block
                    for index in cards.indices{
                        cards[index].isFaceUp = false
                    }
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            
            
        }
        //else will return nil
        //the return type of this function is 'optional int'
    }

    
    mutating func shuffle(){
        cards.shuffle()
        
        //        //helps with debugging, output -> console
        //        print(cards)
    }
    
    mutating func restart(){
        cards.shuffle()
        score = 0
        isGameOver = false
        
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isVisible = true
        }
    }
    
    
}

extension Array {
    var only: Element? {
        count == 1 ? first :nil
    }
}
