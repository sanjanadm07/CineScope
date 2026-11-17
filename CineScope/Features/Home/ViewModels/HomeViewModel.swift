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
    @Published var popularMovies: [Movie] = []
    @Published var error: String?
    @Published var isPopularLoading: Bool = false
    @Published var trendingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var isTrendingLoading: Bool = false
    @Published var isUpcomingLoading: Bool = false
    @Published var searchText: String = ""
    @Published var searchResults: [Movie] = []
    @Published var isSearchLoading: Bool = false
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchPopularMovies() async {
        isPopularLoading = true
        error = nil
        defer {
            isPopularLoading = false
        }
        do {
            popularMovies = try await movieService.fetchPopularMovies().results
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchTrendingMovies() async {
        isTrendingLoading = true
        error = nil
        defer {
            isTrendingLoading = false
        }
        do {
            let response = try await movieService.fetchTrendingMovies()
            trendingMovies = response.results
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchUpcomingMovies() async {
        isUpcomingLoading = true
        error = nil
        defer {
            isUpcomingLoading = false
        }
        do {
            let response = try await movieService.fetchTrendingMovies()
            upcomingMovies = response.results
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func searchMovies(query: String) async {
        let trimmedQuery = query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !trimmedQuery.isEmpty else {
            clearSearchResults()
            return
        }
        isSearchLoading = true
        error = nil
        defer {
            isSearchLoading = false
        }
        do {
           let response = try await movieService.searchMovies(query: trimmedQuery)
           try Task.checkCancellation()
           searchResults = response.results
        } catch is CancellationError {
            return
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func clearSearchResults() {
        searchResults = []
        error = nil
        isSearchLoading = false
    }
    
}
