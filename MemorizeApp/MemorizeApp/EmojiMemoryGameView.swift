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
             cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding()
        }
    }
 
private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
        
    }
}

// @ViewBuilder
/*   var cards: some View {
     LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) { //id: \.self -> Needs card to be hashable
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
     .padding()
 } */

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
