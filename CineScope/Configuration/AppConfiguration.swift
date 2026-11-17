//
//  AppConfiguration.swift
//  CineScope
//
//  Created by Medhavi Magar on 16/11/26.
//

import Foundation
enum AppConfigurationError: Error {
    case missingValue
    case invalidBaseURL
}

struct AppConfiguration {
    
    let accessToken: String
    let baseURL: URL
    
    init() throws {
        let token =  Bundle.main.object(forInfoDictionaryKey: "TMDB_ACCESS_TOKEN") as? String
        let url =  Bundle.main.object(forInfoDictionaryKey: "TMDB_BASE_URL") as? String
        guard let token = token, let url = url else {
            throw AppConfigurationError.missingValue
        }
        self.accessToken = token
        guard let baseURL = URL(string: url) else {
            throw AppConfigurationError.invalidBaseURL
        }
        self.baseURL = baseURL
    }
}
