//
//  AuthRepositoryImpl.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation

struct AuthRepositoryImpl: AuthRepository {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func login(email: String, password: String) async throws -> User {
        let user = try await authService.login(email: email, password: password)
        return user
    }
    
//    func register() {
//        <#code#>
//    }
//    
//    func logout() {
//        <#code#>
//    }
//    
//    func currentUser() async throws -> User? {
//        <#code#>
//    }
    
    
}
