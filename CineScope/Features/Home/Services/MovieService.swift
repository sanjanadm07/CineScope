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
    
    func fetchPopularMovies() async throws -> MovieResponse {
        try await apiClient.request(from: MovieEndPoint.popular)
    }
}
