//
//  FavoritesView.swift
//  CineScope
//
//  Created by Medhavi Magar on 19/11/26.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(key: "title", ascending: true)
    ], animation: .default)
    private var favorites: FetchedResults<FavoriteMovie>
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if favorites.isEmpty {
                VStack(spacing: 15) {
                    Text("No Favourites Yet")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                }
            } else {
                List {
                    ForEach(favorites, id: \.objectID) { movie in
                        HStack(spacing: 15) {
                            
                            if let posterPath = movie.posterPath,
                               let posterURL = URL(
                                string: "https://image.tmdb.org/t/p/w500\(posterPath)"
                               ) {
                                MoviePosterView(posterPath: posterURL)
                                    .frame(width: 65, height: 95)
                                    .clipped()
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(movie.title ?? "Unknown Movie")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text("Release: \(movie.releaseDate ?? "N/A")")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                                Label(
                                    String(format: "%.1f", movie.voteAverage),
                                    systemImage: "star.fill"
                                )
                                .font(.caption)
                                .foregroundStyle(.yellow)
                            }
                            
                            Spacer()
                        }
                        .listRowBackground(Color.black)
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteFavorite(movie)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("My Favourites")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func deleteFavorite(_ movie: FavoriteMovie) {
        viewContext.delete(movie)
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete favorite movie: \(error)")
        }
    }
}

#Preview {
    FavoritesView()
}
