//
//  ContentView.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 13.05.2023.
//

import SwiftUI

struct ContentView: View {
    
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
            }
            .foregroundColor(viewModel.color)
            .padding(.horizontal)
            .navigationTitle("Memorize! \(viewModel.title)")
        }
        Spacer()
        newGameButton
    }
    
    //MARK: Buttons
    var newGameButton: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.largeTitle)
    }
    
}

//MARK: CardView

struct CardView: View {
    let card: MemoryGameModel<String>.Card
    var body: some View {
         ZStack {
             let shape = RoundedRectangle(cornerRadius: 20)
             if card.isFaceUp {
                 shape.fill().foregroundColor(.white)
                 shape.strokeBorder(lineWidth: 3)
                 Text(card.content).font(.largeTitle)
             } else if card.isMatched {
                 shape.opacity(0)
             } else {
                 shape.fill()
             }
        }
    }
}

//MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel(theme: Theme(name: .animals))
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
