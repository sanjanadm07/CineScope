//
//  MainTabView.swift
//  CineScope
//
//  Created by Medhavi Magar on 19/11/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
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
        .preferredColorScheme(.dark)
        .tint(.white)
    }
}

#Preview {
    MainTabView()
}
