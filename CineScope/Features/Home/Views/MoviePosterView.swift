//
//  MoviePosterView.swift
//  CineScope
//
//  Created by Medhavi Magar on 18/11/26.
//

import SwiftUI

struct MoviePosterView: View {
    @StateObject var viewModel: MovieImageViewModel
    let posterPath: URL?
    
    init(posterPath: URL?) {
        let imageLoader = ImageLoader()
        _viewModel = StateObject(wrappedValue: MovieImageViewModel(imageLoader: imageLoader))
        self.posterPath = posterPath
    }
    var body: some View {
        VStack {
            if viewModel.isImageLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
            } else {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 220)
                        .clipped()
                } else {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .padding(45)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                }
            }
            
        }
        .task {
            await viewModel.fetchImage(urlString: posterPath)
        }
    }
}

