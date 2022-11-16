//
//  emojiMemoryGame.swift
//  LectureMemorize
//
//  view model
//  View models are for expressing intents. ContentView should only reference ViewModel intents with verbs, e.g choose
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(themeName: "wind", numberOfPairsOfCards: 3) { pairIndex in emojis[pairIndex] }
    }
    
    
    
    // each Model-View creates its own Model
    @Published private(set) var model = createMemoryGame()
    
    // and make public, parts that need to be so
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme {
        return model.theme
    }
    
    // MARK - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
