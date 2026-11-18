//
//  MovieServiceProtocol.swift
//  CineScope
//
//  Created by Medhavi Magar on 16/11/26.
//

import Foundation
protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int) async throws -> MovieResponse
    func fetchTrendingMovies() async throws -> MovieResponse
    func fetchUpcomingMovies() async throws -> MovieResponse
    func searchMovies(query: String) async throws -> MovieResponse
}
