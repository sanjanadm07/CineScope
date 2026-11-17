//
//  MovieCardView.swift
//  CineScope
//
//  Created by Medhavi Magar on 17/11/26.
//

import SwiftUI

struct MovieCardView: View {
    let movie: [Movie]
    let heading: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movie)
                    { movie in
                        VStack(alignment: .leading, spacing: 8) {
                            ZStack(alignment: .topTrailing) {
                                // Poster Image
                                if let image = movie.posterPath {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 240)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .overlay(ProgressView())
                                        .frame(height: 240)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
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
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                        .padding()
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    MovieCardView(movie: [Movie(id: 123, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4), Movie(id: 127, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4), Movie(id: 128, title: "Dune: Part Two", overview: "Something overview description for preview", posterPath: "", releaseDate: "July 12, 2026", voteAverage: 4)], heading: "Popular")
}
