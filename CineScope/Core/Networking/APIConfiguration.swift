//
//  APIConfiguration.swift
//  CineScope
//
//  Created by Medhavi Magar on 15/11/26.
//

import Foundation
struct APIConfiguration {
    
    let baseURL: URL
    
    let accessToken: String
    
    let commonHeaders: [String: String]
    
    let timeoutInterval: TimeInterval
    
    init(appConfiguration: AppConfiguration) {
        self.baseURL = appConfiguration.baseURL
        self.accessToken = appConfiguration.accessToken
        self.commonHeaders = [
            "Authorization": "Bearer \(appConfiguration.accessToken)",
            "Accept": "application/json"]
        self.timeoutInterval = 30
    }
}
