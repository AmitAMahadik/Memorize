//
//  MemorizeAppApp.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame() // Reactive UI
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
