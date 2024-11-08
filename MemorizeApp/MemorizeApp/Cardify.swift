//
//  Cardify.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/7/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack {
            let cardBase =  RoundedRectangle(cornerRadius: Constants.cornerRadius) //Type Inference
            cardBase.strokeBorder(lineWidth: Constants.lineWidth)
                .background(cardBase.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1 : 0)
            cardBase.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
    
}

extension View {
    public func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
