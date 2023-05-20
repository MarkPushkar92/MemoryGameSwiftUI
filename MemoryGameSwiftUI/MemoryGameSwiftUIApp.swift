//
//  MemoryGameSwiftUIApp.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 13.05.2023.
//

import SwiftUI

@main
struct MemoryGameSwiftUIApp: App {
    
    let game = MemoryGameViewModel(theme: Theme(name: .vehicles))
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

