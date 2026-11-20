//
//  MainTabView.swift
//  CineScope
//
//  Created by Medhavi Magar on 19/11/26.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var coordinator: AppCoordinator
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            TabView {
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                
                FavoritesView()
                    .tabItem{
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
            .toolbar(.visible, for: .navigationBar)
            .preferredColorScheme(.dark)
            .tint(.white)
            .environmentObject(coordinator)
            .navigationDestination(for: AppRoute.self) {
                route in
                switch route {
                case .movieDetail:
                    if let movie = coordinator.selectedMovie {
                        MovieDetailView(movie: movie)
                    }
                }
            }
        }
    }
}
