//
//  LectureMemorizeApp.swift
//  LectureMemorize
//
//  Created by sun on 2021/09/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
