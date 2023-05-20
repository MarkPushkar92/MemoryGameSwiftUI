//
//  MemoryGameViewModel.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 16.05.2023.
//

import SwiftUI


class MemoryGameViewModel: ObservableObject {
    
    var theme: Theme
    
    var title: String
    
    var color: Color
    
    @Published private var model: MemoryGameModel<String>

    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }
        
    static func createMemoryGame(theme: Theme) -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    func newGame() {
        let theme = Theme(name: .allCases.randomElement() ?? .animals)
        model = MemoryGameViewModel.createMemoryGame(theme: theme)
        color = Color[theme.color]
        title = theme.name.rawValue.capitalized
    }
            
    init(theme: Theme) {
        self.theme = theme
        model = MemoryGameModel<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
        color = Color[theme.color]
        title = theme.name.rawValue.capitalized
    }
    
    //MARK: User interaction
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}

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


