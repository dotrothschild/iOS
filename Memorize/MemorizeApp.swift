//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Shimon Rothschild on 1-02-21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemoryGame())
        }
    }
}
