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
    var isFaceUp: Bool = false // Default value
    
    var body: some View {
        ZStack(content: { // Tuple view
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12) // Lego blocks cornerRadius: Named parameter
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 10)
                Text("👻").font(.largeTitle) // Text struct
            } else {
                RoundedRectangle(cornerRadius: 12) // Lego blocks cornerRadius: Named parameter
                    .foregroundColor(.orange)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 10)
            }
        })
        
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}
