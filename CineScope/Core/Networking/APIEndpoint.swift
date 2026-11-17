//
//  APIEndpoint.swift
//  CineScope
//
//  Created by Medhavi Magar on 15/11/26.
//

import Foundation
protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}
