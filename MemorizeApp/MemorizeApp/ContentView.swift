//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//

import SwiftUI

struct ContentView: View { // ContentView "behaves like a" View
    var body: some View { // Computed Property - Lego analogy
        HStack {
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false // Default value - Has to be a var
    // @State creates a pointer!!
    
    
    var body: some View {
        ZStack(alignment: .center, content: { // Tuple view
            let cardBase =  RoundedRectangle(cornerRadius: 12) //Type Inference
            //let cardBase: RoundedRectangle =  RoundedRectangle(cornerRadius: 12) // Lego blocks cornerRadius: Named parameter //let is constant
            if isFaceUp {
                cardBase.fill(.white)
                cardBase.strokeBorder(lineWidth: 10)
                Text("👻").font(.largeTitle) // Text struct
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
