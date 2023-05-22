//
//  ContentView.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 13.05.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: MemoryGameViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                score
                    .padding(.horizontal)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                    .foregroundColor(viewModel.color)
            }
                .padding(.horizontal)
                .navigationTitle("Memorize! \(viewModel.title)")
        }
        newGameButton
    }
    
    //MARK: Buttons n stuff
    private var newGameButton: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.largeTitle)
    }
}

//MARK: CardView

struct CardView: View {
    let card: MemoryGameViewModel.Card
    var body: some View {
        
        
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
           }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.6
    }
}

//MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel(theme: Theme(name: .animals))
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
