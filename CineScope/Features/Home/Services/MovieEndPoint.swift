//
//  MovieEndPoint.swift
//  CineScope
//
//  Created by Medhavi Magar on 16/11/26.
//

import Foundation
enum MovieEndPoint: APIEndpoint {
    case popular
    case trending
    case upcoming
    case search(query: String)
}

extension MovieEndPoint {
    var path: String {
        switch self {
        case .popular:
            return "3/movie/popular"
        case .trending:
            return "3/trending/movie/day"
        case .upcoming:
            return "3/movie/upcoming"
        case .search:
            return "3/search/movie"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        default:
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
