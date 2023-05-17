//
//  MemoryGameSwiftUIApp.swift
//  MemoryGameSwiftUI
//
//  Created by Марк Пушкарь on 13.05.2023.
//

import SwiftUI

@main
struct MemoryGameSwiftUIApp: App {
    
    let game = MemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
