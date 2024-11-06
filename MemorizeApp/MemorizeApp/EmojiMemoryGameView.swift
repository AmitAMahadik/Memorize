//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//
//   VIEW
//



import SwiftUI

struct EmojiMemoryGameView: View { // ContentView "behaves like a" View
   
   @ObservedObject var viewModel: EmojiMemoryGame  // Don't call it viewModel. Only for instruction
    
    var body: some View { // Computed Property - Lego analogy
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing: 0) { //id: \.self -> Needs card to be hashable
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.orange)
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let cardBase =  RoundedRectangle(cornerRadius: 12) //Type Inference
            Group {
                cardBase.fill(.white)
                cardBase.strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.system(size: 200)) // Text struct
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            cardBase.fill()
                .opacity(card.isFaceUp ? 0 : 1)
            
        }
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
