//
//  emojiMemoryGame.swift
//  LectureMemorize
//
//  view model
//  View models are for expressing intents. ContentView should only reference ViewModel intents with verbs, e.g choose
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    @Published private(set) var model = createMemoryGame()
    static var theme: Theme = Theme(name: .fire, cardPairs: 8)
    
    var themeColor: Color {
        switch EmojiMemoryGame.theme.color {
        case "Red":
            return .red
        case "Purple":
            return .purple
        case "Blue":
            return .blue
        case "Green":
            return .green
        case "Teal":
            return .teal
        default:
            return .gray
        }
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        if theme.cardPairs > theme.emojis.count {
            theme.cardPairs = theme.emojis.count
        }
        // randomize theme.emojis
        let shuffled_emojis = theme.emojis.shuffled()
        
        return MemoryGame(numberOfPairsOfCards: theme.cardPairs) { pairIndex in shuffled_emojis[pairIndex] }
    }
    
    // and make public, parts that need to be so
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restartGame() -> Void {
        EmojiMemoryGame.theme = Theme(name: Theme.themes.allCases.randomElement()!, cardPairs: Int.random(in: 4..<9))
        model = EmojiMemoryGame.createMemoryGame()
    }
}
