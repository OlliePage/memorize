//
//  MemorizeGame.swift
//  LectureMemorize
//
//  model
//
//  Created by sun on 2021/09/28.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
               !cards[chosenIndex].isFaceUp,
               !cards[chosenIndex].isMatched {
            if let potentialMatch = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatch].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatch].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            
        }
        print("Couldn't find card")
    }
    

init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // add numberOfPairsOfCards * 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
        let content = createCardContent(pairIndex)
        cards.append(Card(content: content, id: pairIndex*2))
        cards.append(Card(content: content, id: pairIndex*2+1))
    }
    
}

struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
}

}
