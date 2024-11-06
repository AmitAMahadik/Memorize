//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/4/24.
//
//  MODEL
//


import Foundation   // Model

struct MemoryGame<CardContent> where CardContent: Equatable { //Don't care type for CardContent - BUT require to be Equatable for animation
    private(set) var cards: Array<Card> // Access controls
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) { // Init all the vars
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) { // Use _ since don't care
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle() // TODO: tada!
        print(cards) // FIXME: Bogus!
    }
    
    mutating func choose(card: Card) {
        let chosenIndex = cards.firstIndex(of: card)!
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
/*       static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched
        } */ //Not needed since Equatable
        
        var isFaceUp = true
        var isMatched: Bool = true
        let content: CardContent // Read only
        var id: String // For Pr Indentifiable
        var debugDescription: String { // Make your debugging easier
            return "\(id): faceUp: \(isFaceUp ? "up" : "down"), matched: \(isMatched ? "matched" : "not matched"), content:\(content)"
        }
    }
}
