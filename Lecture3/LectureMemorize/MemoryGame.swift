//
//  MemorizeGame.swift
//  LectureMemorize
//
//  model
//
//  Created by sun on 2021/09/28.
//

import Foundation
import SwiftUI

struct Theme {
    
    var supportedTheme: String {
        switch name {
        case .transport:
            return "Transport"
        case .earth:
            return "Earth"
        case .wind:
            return "Wind"
        case .fire:
            return "Fire"
        case .water:
            return "Water"
        case .space:
            return "Space"
        }
    }
    
    enum themes: CaseIterable {
    case transport, earth, wind, fire, water, space
    }
    
    static let reference_emojis: [String:[String]] = ["Transport":  ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛"],
                                                      "Earth": ["🌎", "🌞","🌳", "🥕","🪵"],
                                                      "Wind": ["💨", "🍃","🎐", "🌬️","😮‍💨", "💨","🚁", "𐑺"],
                                                      "Fire": ["🔥", "❤️‍🔥","🧯", "👨‍🚒","☄️", "🌞","🚒", "🕯️"],
                                                      "Water": ["💦", "🔫","🎣", "🦆","🌊", "💧","🏄‍♂️", "🦈"],
                                                      "Space": ["🔭", "🪐","🛸", "👽","🚀", "👩🏼‍🚀","👾", "🌏"]
    ]
    
    static let reference_color: [String:String] = ["Transport":  "Grey",
                                                      "Earth": "Green",
                                                      "Wind": "Teal",
                                                      "Fire": "Red",
                                                      "Water": "Blue",
                                                      "Space": "Black"
    ]
    
    let name: themes
    var cardPairs: Int
    var color: String { return Theme.reference_color[supportedTheme]!}
    var emojis: [String] { return Theme.reference_emojis[supportedTheme]!}
    
}

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var score: Int = 0
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
                    score += 2
                } else if cards[chosenIndex].previousSeen && cards[potentialMatch].previousSeen {
                    score -= 2
                } else if cards[chosenIndex].previousSeen || cards[potentialMatch].previousSeen {
                    score -= 1
                }
                cards[chosenIndex].previousSeen = true
                cards[potentialMatch].previousSeen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        
        var unshuffledCards: [Card] = []
        // add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            unshuffledCards.append(Card(content: content, id: pairIndex*2))
            unshuffledCards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        self.cards = { return unshuffledCards.shuffled() }()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var previousSeen: Bool = false
    }
}
