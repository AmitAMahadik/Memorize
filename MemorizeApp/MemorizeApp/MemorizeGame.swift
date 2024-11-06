//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/4/24.
//

import Foundation   // Model

struct MemoryGame<CardContent>{ //Don't care type for CardContent
    private(set) var cards: Array<Card> // Access controls
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) { // Init all the vars
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) { // Use _ since don't care
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content)) 
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched: Bool = true
        let content: CardContent // Read only
        
    }
}
