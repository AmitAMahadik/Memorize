//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/4/24.
//

import SwiftUI // View Model - needs SwiftUI to interface with UI, but no UI implementation

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "☠️", "👽", "🤖", "👹", "👺", "👻", "🎃", "☠️", "👽", "🤖", "👹", "👺"]
    
   private static func createMemoryGame() -> MemoryGame<String> {
       return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
           if emojis.indices.contains(pairIndex) {
               return emojis[pairIndex]
           } else {
               return "🙊!"
           }
       }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
                                    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() { // Intent function
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) { // Intent function // _ External name is not needed
        model.choose(card: card)
    }
    

    
}
