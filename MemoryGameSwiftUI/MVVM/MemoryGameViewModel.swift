//
//  MemoryGameViewModel.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 16.05.2023.
//

import SwiftUI


class MemoryGameViewModel: ObservableObject {
    
    typealias Card = MemoryGameModel<String>.Card
    
    //MARK: Properties
    
    var theme: Theme
    
    var title: String

    var color: Color
    
    @Published var score: Int = 0
    
    @Published private var model: MemoryGameModel<String>

    var cards: [Card] {
        model.cards
    }
    
    //MARK: Funcs
        
    static func createMemoryGame(theme: Theme) -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    // User interaction
    
    func newGame() {
        let theme = Theme(name: .allCases.randomElement() ?? .animals)
        model = MemoryGameViewModel.createMemoryGame(theme: theme)
        color = Color[theme.color]
        title = theme.name.rawValue.capitalized
        score = 0
    }
    
    func choose(_ card:  Card) {
        model.choose(card)
        score = model.score
    }
    
    //MARK: Init
            
    init(theme: Theme) {
        self.theme = theme
        self.model = MemoryGameModel<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
        self.color = Color[theme.color]
        self.title = theme.name.rawValue.capitalized
        self.score = model.score
    }
}

//MARK: Color extension 

extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "green":
            return Color.green
        case "orange":
            return Color.orange
        case "blue":
            return Color.blue
        case "red":
            return Color.red
        case "yellow":
            return Color.yellow
        case "purple":
            return Color.purple
        default:
            return Color.accentColor
        }
    }
}


