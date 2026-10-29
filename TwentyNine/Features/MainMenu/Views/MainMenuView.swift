//
//  MainMenuView.swift
//  TwentyNine
//
//  Created by Amit Sen on November 22, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import SwiftUI

/// Main menu screen.
///
/// Placeholder until Stage 2.1; renders only what the view model exposes.
struct MainMenuView: View {
    let viewModel: MainMenuViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("TwentyNine")
                .font(.largeTitle.bold())

            Button("New Game") {
                viewModel.startNewGame()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel(onStartGame: {}))
}
