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
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only}
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    /*
     var indexOfTheOnlyFaceUpCard: Int? {
         get {
             var faceUpCardIndices = [Int]()
             for index in cards.indices {
                 if cards[index].isFaceUp {
                     faceUpCardIndices.append(index)
                 }
             }
             if faceUpCardIndices.count == 1 {
                 return faceUpCardIndices.first
             } else {
                 return nil
             }
             
         }
         set {
             for index in cards.indices {
                 if index == newValue {
                     cards[index].isFaceUp = true
                 } else {
                     cards[index].isFaceUp = false
                 }
             }
         }
     }
     */
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                  //  indexOfTheOnlyFaceUpCard = nil
                } else {
                 /*   for index in cards.indices {
                        cards[index].isFaceUp = false
                    } */
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle() // TODO: tada!
     //   print(cards) // FIXME: Bogus!
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
/*       static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched
        } */ //Not needed since Equatable
        
        var isFaceUp = true
        var isMatched: Bool = false
        let content: CardContent // Read only
        var id: String // For Pr Indentifiable
        var debugDescription: String { // Make your debugging easier
            return "\(id): faceUp: \(isFaceUp ? "up" : "down"), matched: \(isMatched ? "matched" : "not matched"), content:\(content)"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
