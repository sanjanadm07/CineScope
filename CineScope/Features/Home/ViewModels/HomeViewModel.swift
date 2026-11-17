//
//  HomeViewModel.swift
//  CineScope
//
//  Created by Medhavi Magar on 13/11/26.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    let movieService: MovieService
    @Published var movies: [Movie] = []
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchMovies() async {
        isLoading = true
        error = nil
        defer {
            isLoading = false
        }
        do {
            movies = try await movieService.fetchPopularMovies().results
        } catch {
            self.error = error.localizedDescription
        }
    }
    
}
