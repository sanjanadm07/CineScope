//
//  MovieService.swift
//  CineScope
//
//  Created by Medhavi Magar on 16/11/26.
//

import Foundation
final class MovieService: MovieServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchPopularMovies(page: Int) async throws -> MovieResponse {
        try await apiClient.request(from: MovieEndPoint.popular(page: page))
    }
    
    func fetchTrendingMovies() async throws -> MovieResponse {
        try await apiClient.request(from: MovieEndPoint.trending)
    }
    
    func fetchUpcomingMovies() async throws -> MovieResponse {
        try await apiClient.request(from: MovieEndPoint.upcoming)
    }
    
    func searchMovies(query: String) async throws -> MovieResponse {
        try await apiClient.request(from: MovieEndPoint.search(query: query))
    }
}
