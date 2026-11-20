//
//  MovieDetailView.swift
//  CineScope
//
//  Created by Medhavi Magar on 20/11/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                MoviePosterView(posterPath: movie.posterURL)
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .clipped()

                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                HStack(spacing: 16) {
                    Label(
                        String(format: "%.1f", movie.voteAverage),
                        systemImage: "star.fill"
                    )
                    .foregroundStyle(.yellow)

                    if let releaseDate = movie.releaseDate {
                        Text(releaseDate)
                            .foregroundStyle(.gray)
                    }
                }

                Text("Overview")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)

                Text(movie.overview)
                    .font(.body)
                    .foregroundStyle(.gray)
                    .lineSpacing(5)
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Movie Description")
        .navigationBarTitleDisplayMode(.inline)
    }
}

