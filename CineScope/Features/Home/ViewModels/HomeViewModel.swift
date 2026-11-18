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
    @Published var currentPage: Int = 1
    @Published var isLoadingMorePage: Bool = false
    @Published var totalPages: Int = 1
    @Published var paginationError: String?
    
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
            let response = try await movieService.fetchPopularMovies(page: currentPage)
            popularMovies = response.results
            totalPages = response.totalPages
            currentPage = response.page + 1
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
            let response = try await movieService.fetchUpcomingMovies()
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
    
    func loadNextPopularPage() async {
        guard !isLoadingMorePage else { return }
        guard hasMorePopularPages else { return }
        isLoadingMorePage = true
        paginationError = nil
        defer {
            isLoadingMorePage = false
        }
        do {
            let response = try await movieService.fetchPopularMovies(page: currentPage)
            totalPages = response.totalPages
            popularMovies.append(contentsOf: response.results)
            currentPage = response.page + 1
        } catch {
            self.paginationError = error.localizedDescription
        }
    }
    
    var hasMorePopularPages: Bool {
        currentPage <= totalPages
    }
    
}
