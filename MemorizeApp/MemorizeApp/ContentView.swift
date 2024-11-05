//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//

import SwiftUI

struct ContentView: View { // ContentView "behaves like a" View
   
    var viewModel: EmojiMemoryGame // Don't call it viewModel. Only for instruction
    
    
    let emojis = ["👻", "🎃", "😈", "🕷️", "🤖", "👽", "👾"] // "Inferred Array of String" emojis: Array<String>
    
    @State var cardCount: Int = 4
    
    var body: some View { // Computed Property - Lego analogy
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjuster
        }
        .padding()
        }
    
    var cards: some View {
        //  HStack { // Implicit return doesn't require return since it's only one line of code
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { emoji in
                CardView(cardContent: emojis[emoji])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
        
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardCountAdjuster: some View {
   //     Text("\(cardCount)")
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }

    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
}

struct CardView: View {
    let cardContent: String
    @State var isFaceUp = true // Default value - Has to be a var
    // @State creates a pointer!!
    
    
    var body: some View {
        ZStack(alignment: .center, content: { // Tuple view
            let cardBase =  RoundedRectangle(cornerRadius: 12) //Type Inference
            //let cardBase: RoundedRectangle =  RoundedRectangle(cornerRadius: 12) // Lego blocks cornerRadius: Named parameter //let is constant
            Group {
                cardBase.fill(.white)
                cardBase.strokeBorder(lineWidth: 10)
                Text(cardContent).font(.largeTitle) // Text struct
            }
            .opacity(isFaceUp ? 1 : 0)
            cardBase.fill().opacity(isFaceUp ? 0 : 1)
            
        })
        .onTapGesture {
            // print("Tapped")
            isFaceUp.toggle()
        }
        
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}
