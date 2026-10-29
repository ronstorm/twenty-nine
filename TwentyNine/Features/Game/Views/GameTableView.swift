//
//  GameTableView.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import SwiftUI

/// Main game screen with the 4-player table.
///
/// Placeholder until Stage 2.2; renders only what the view model exposes.
struct GameTableView: View {
    let viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.state.gamePhase.displayName)
                .font(.title2)

            Button("Leave Game", role: .cancel) {
                viewModel.exitGame()
            }
        }
        .padding()
        .navigationTitle("TwentyNine")
    }
}

#Preview {
    NavigationStack {
        GameTableView(viewModel: GameViewModel())
    }
}
