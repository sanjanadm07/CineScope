//
//  MovieCardView.swift
//  CineScope
//
//  Created by Medhavi Magar on 17/11/26.
//

import SwiftUI

struct MovieCardView: View {
    let movies: [Movie]
    let heading: String
    var isLoadingMore: Bool = false
    var paginationError: String? = nil
    var onLastMovieAppeared: (() -> Void)? = nil
    var onRetry: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movies)
                    { movie in
                        movieCard(movie: movie)
                            .onAppear {
                                guard let lastIndex = movies.firstIndex(where: {
                                    $0.id == movie.id
                                }) else {
                                    return
                                }
                                if lastIndex >= movies.count - 3 {
                                    onLastMovieAppeared?()
                                }
                            }
                    }
                    if isLoadingMore {
                        ProgressView()
                            .tint(.white)
                            .frame(width: 60, height: 220)
                    }
                    if let paginationError {
                        VStack(spacing: 8) {
                            Text("Couldn't load more movies")
                                .font(.caption)
                                .foregroundStyle(.white)
                            
                            Button("Retry") {
                                onRetry?()
                            }
                            .foregroundStyle(.white)
                        }
                        .frame(width: 150, height: 220)
                    }
                }
            }.fixedSize(horizontal: false, vertical: true)
        }
        
    }
}

extension MovieCardView {
    func movieCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // Poster Image
                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.gray.opacity(0.2))
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                            
                        case .failure:
                            Image(systemName: "film")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .padding(45)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.gray.opacity(0.2))
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 150, height: 220)
                    .clipped()
                } else {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .frame(width: 150, height: 220)
                        .background(Color.gray.opacity(0.2))
                }
                
                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .clipShape(Capsule())
                .padding(8)
            }
            
            // Movie Details
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundStyle(.primary)
                
                if let date = movie.releaseDate {
                    Text(date)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                }
                
            }
            .padding([.horizontal, .bottom], 12)
        }
        .frame(width: 150)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

#Preview {
    MovieCardView(movies: [Movie(id: 123, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4), Movie(id: 127, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4), Movie(id: 128, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4)], heading: "Popular")
}
