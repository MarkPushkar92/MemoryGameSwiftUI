//
//  ThemeModel.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 20.05.2023.
//

import Foundation

struct Theme {
    var name: Themes
    var color: String
    var numberOfPairsOfCards: Int
    var emojis: [String]
    
    init(name: Themes) {
        self.name = name
        switch name {
        case .vehicles:
            color = "red"
            numberOfPairsOfCards = 5
            emojis = vehicles.shuffled()
        case .animals:
            color = "yellow"
            numberOfPairsOfCards = 5
            emojis = animals.shuffled()
        case .sports:
            color = "blue"
            numberOfPairsOfCards = 5
            emojis = sports.shuffled()
        case .fruit:
            color = "orange"
            numberOfPairsOfCards = 5
            emojis = fruit.shuffled()
        case .insects:
            color = "green"
            numberOfPairsOfCards = 5
            emojis = insects.shuffled()
        case .devices:
            color = "purple"
            numberOfPairsOfCards = 5
            emojis = devices.shuffled()
        }
    }
    
    enum Themes: String, CaseIterable {
        case vehicles
        case animals
        case sports
        case fruit
        case insects
        case devices
    }
    
    private let vehicles = ["🚗", "🛺", "🏎️", "🚎", "🚜", "🚒", "🛴", "🛻", "🏍️" ]
    private let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️" ]
    private let sports = ["⚽️", "🏈", "🥎", "🏐", "🥏", "🏓", "🏒", "🪃", "🥊" ]
    private let fruit = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓" ]
    private let insects = ["🐝", "🪳", "🐜", "🪲", "🐞", "🦗", "🦟", "🕷️", "🦂" ]
    private let devices = ["💾", "💿", "📼", "📷", "📹", "📽️", "📟", "📺", "⏰" ]
    
}

























