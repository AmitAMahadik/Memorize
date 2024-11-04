//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//

import SwiftUI

struct ContentView: View { // ContentView "behaves like a" View
    let emojis = ["👻", "🎃", "😈", "🕷️"] // "Inferred Array of String" emojis: Array<String>
    
    var body: some View { // Computed Property - Lego analogy
        HStack {
            ForEach(emojis.indices, id: \.self) { emoji in
                CardView(cardContent: emojis[emoji])
            }
/*            CardView(cardContent: "👻", isFaceUp: true)
            CardView(cardContent: "🎃")
            CardView(cardContent: "😈")
            CardView(cardContent: "🕷️", isFaceUp: true) */
        }
        .foregroundColor(.orange)
        .padding()
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
            if isFaceUp {
                cardBase.fill(.white)
                cardBase.strokeBorder(lineWidth: 10)
                Text(cardContent).font(.largeTitle) // Text struct
            } else {
                cardBase.fill()
            }
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
