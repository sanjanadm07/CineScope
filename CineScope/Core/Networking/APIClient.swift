//
//  APIClient.swift
//  CineScope
//
//  Created by Medhavi Magar on 15/11/26.
//

import Foundation
final class APIClient: APIClientProtocol {
    private let urlSession: URLSession
    private let apiConfig: APIConfiguration
    
    init(apiConfig: APIConfiguration, urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        self.apiConfig = apiConfig
    }
    
    func request<T>(from endPoint: any APIEndpoint) async throws -> T where T : Decodable {
        guard var components = URLComponents(url: apiConfig.baseURL, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        let path = endPoint.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        components.path += "/" + path
        components.queryItems = endPoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.timeoutInterval = apiConfig.timeoutInterval
        var headers = apiConfig.commonHeaders
        endPoint.headers?.forEach{ key, value in
            headers[key] = value
        }
        urlRequest.allHTTPHeaderFields = headers
        print("URLRequest: \(urlRequest)")
        let data: Data
                let response: URLResponse
        do {
            (data, response) = try await urlSession.data(for: urlRequest)
            
        } catch {
            throw APIError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
        return try parsingData(T.self, from: data)
        
    }
    
    func parsingData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.decodingFailed
        }
    }
}
