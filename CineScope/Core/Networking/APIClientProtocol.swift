//
//  APIClientProtocol.swift
//  CineScope
//
//  Created by Medhavi Magar on 15/11/26.
//

import Foundation
protocol APIClientProtocol {
    func request<T: Decodable>(from endPoint: APIEndpoint) async throws -> T
    func parsingData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
