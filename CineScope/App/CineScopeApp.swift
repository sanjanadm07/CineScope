//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import SwiftUI

@main
struct CineScopeApp: App {
    @StateObject private var coordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: coordinator)
                .environment(
                    \.managedObjectContext,
                    PersistenceController.shared.container.viewContext
                )
        }
    }
}
