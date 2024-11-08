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
        ZStack {
            let cardBase =  RoundedRectangle(cornerRadius: Constants.cornerRadius) //Type Inference
            Group {
                cardBase.fill(.white)
                cardBase.strokeBorder(lineWidth: Constants.lineWidth)
                Pie(endAngle: .degrees(240))
                    .opacity(0.3)
                    .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest)) // Text struct
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit))
            }
            .opacity(card.isFaceUp ? 1 : 0)
            cardBase.fill()
                .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp  || !card.isMatched ? 1 : 0)
        .foregroundColor(.orange)
       // .padding()
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
