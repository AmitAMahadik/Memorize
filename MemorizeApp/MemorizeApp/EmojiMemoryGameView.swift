//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Mahadik, Amit on 11/3/24.
//
//   VIEW
//



import SwiftUI


struct EmojiMemoryGameView: View {
   
    typealias Card = EmojiMemoryGame.Card

    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let deckWidth: CGFloat = 100
    private let dealInterval: TimeInterval = 0.15
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck
                    .foregroundStyle(viewModel.color)
                Spacer()
               // shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealtNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                  /*  .transition(.offset(
                        x: CGFloat.random(in: -1000...1000),
                        y: CGFloat.random(in: -1000...1000)
                    ))*/
            }
        }
    }
    
    private func deal() {
        // Deal the cards
       
        viewModel.shuffle()
        
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) } // Returns cards that are not dealt
    }
    
    @Namespace private var dealtNamespace // Need separate NS for another deck
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealtNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth/aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardID: card.id)
        }
    }
    
   // @State private var lastScoreChange: (amount: Int, causedByCardID: Card.ID) = (amount: 0, causedByCardID: "")
   // Identical to below. Using a tuple.
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardID: id) = lastScoreChange
        return card.id == id ? amount : 0
    }

}
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
