//
//  ContentView.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 13.05.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: MemoryGameViewModel
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack{
                    shuffleButton
                    Spacer()
                    newGameButton
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    private var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if isUndelt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
    
        .foregroundColor(viewModel.color)
    }
    
    private var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndelt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeigt)
        .foregroundColor(viewModel.color)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    //MARK: Buttons n stuff
    
    @State private var dealt  = Set<Int>()
    
    private func deal(_ card: MemoryGameViewModel.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndelt(_ card: MemoryGameViewModel.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: MemoryGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: {$0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: MemoryGameViewModel.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    private var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                dealt = []
                viewModel.newGame()
            }
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.largeTitle)
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let unDealtHeigt: CGFloat = 90
        static let unDealtWidth = unDealtHeigt * aspectRatio
        
    }
}

//MARK: CardView

struct CardView: View {
    let card: MemoryGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 2), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.70
        static let fontSize: CGFloat = 32
        
    }
}

//MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel(theme: Theme(name: .animals))
        return EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
