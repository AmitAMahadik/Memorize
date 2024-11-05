//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/4/24.
//

import SwiftUI // View Model - needs SwiftUI to interface with UI, but no UI implementation

class EmojiMemoryGame {
    private static let emojis = ["👻", "🎃", "☠️", "👽", "🤖", "👹", "👺", "👻", "🎃", "☠️", "👽", "🤖", "👹", "👺"]
    
    private var model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
        EmojiMemoryGame.emojis[pairIndex]
    
    }
                                   
                                   
                                   
                                   
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) { // Intent function // _ External name is not needed
        model.choose(card: card)
    }
    

    
}
