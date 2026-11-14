//
//  AuthServiceProtocol.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws  -> User
}
