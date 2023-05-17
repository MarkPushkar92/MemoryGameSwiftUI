//
//  MemoryGameViewModel.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 16.05.2023.
//

import SwiftUI


class MemoryGameViewModel: ObservableObject {
    
    static let emojis = ["🚗", "🛺", "🏎️", "🚎", "🚜", "🚒", "🛴", "🛻", "🏍️" ]
    
    static func createMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
        
    @Published private var model: MemoryGameModel<String> = createMemoryGame()

    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }
    
    //MARK: User interaction
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    

}


//
//var vehicles = ["🚗", "🛺", "🏎️", "🚎", "🚜", "🚒", "🛴", "🛻", "🏍️" ]
//
//var animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️" ]
//
//var sports = ["⚽️", "🏈", "🥎", "🏐", "🥏", "🏓", "🏒", "🪃", "🥊" ]
