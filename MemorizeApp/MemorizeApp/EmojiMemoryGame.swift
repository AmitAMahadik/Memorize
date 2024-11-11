//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/4/24.
//
//  VIEW MODEL
//



import SwiftUI // View Model - needs SwiftUI to interface with UI, but no UI implementation

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👻", "🎃", "☠️", "👽", "🤖", "👹", "👺", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    
   private static func createMemoryGame() -> MemoryGame<String> {
       return MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
           if emojis.indices.contains(pairIndex) {
               return emojis[pairIndex]
           } else {
               return "🙊!"
           }
       }
    }
    
    @Published private var model = createMemoryGame() // Don't call it model. Only for instruction.
                                    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    func shuffle() { // Intent function
        model.shuffle()
        //objectWillChange.send()
    }
    
    func choose(_ card: Card) { // Intent function // _ External name is not needed
        model.choose(card)
    }
}
