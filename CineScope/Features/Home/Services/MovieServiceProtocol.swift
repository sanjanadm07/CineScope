//
//  MovieServiceProtocol.swift
//  CineScope
//
//  Created by Medhavi Magar on 16/11/26.
//

import Foundation
protocol MovieServiceProtocol {
    func fetchPopularMovies() async throws -> MovieResponse
}
