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
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
    }
    
    var headers: [String : String]? {
        return nil
    }
}
