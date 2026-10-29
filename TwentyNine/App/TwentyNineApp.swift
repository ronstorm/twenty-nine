//
//  TwentyNineApp.swift
//  TwentyNine
//
//  Created by Amit Sen on November 22, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import SwiftUI

@main
struct TwentyNineApp: App {
    @State private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: coordinator)
        }
    }
}
