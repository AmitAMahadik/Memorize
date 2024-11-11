//
//  CardView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/7/24.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView (.animation(minimumInterval: 1/10)) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.3)
                    .overlay(cardContent.padding(Constants.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContent: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest)) // Text struct
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let smallest: CGFloat = 10
            static let largest: CGFloat = 200
            static let scaleFactor: CGFloat = smallest / largest
        }
    }
        
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

//typealias Card = MemoryGame<String>.Card
#Preview {
    VStack {
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp: true, content: "A", id: "test1"))
            CardView(MemoryGame<String>.Card(isFaceUp: false, isMatched: true, content: "A", id: "test1"))
        }
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp: true, content: "A", id: "test1"))
            CardView(MemoryGame<String>.Card(isFaceUp: false, content: "A", id: "test1"))
        }
    }
        .padding()
        .foregroundStyle(.orange)
        
}
