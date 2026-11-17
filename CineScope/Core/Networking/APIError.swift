//
//  APIError.swift
//  CineScope
//
//  Created by Medhavi Magar on 15/11/26.
//

import Foundation
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed
    case networkError(Error)
}
