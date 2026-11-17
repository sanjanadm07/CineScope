//
//  MockAuthServices.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation
enum AuthenticationError: Error {
    case invalidCredentials
    case emptyCredentials
}

struct MockAuthServices : AuthServiceProtocol {
  
    func login(email: String, password: String) async throws -> User {
        
        // 1. Simulate network delay
        try await Task.sleep(for: .seconds(1.5))
        
        // 2. Validate empty credentials
        if email.isEmpty || password.isEmpty {
            throw AuthenticationError.emptyCredentials
        }
        
        // 3. Check mock credentials
        if email == "1234@ex.com" && password == "1234" {
            return User(id: 123, name: "test", email: "1234@ex.com")
        } else {
            throw AuthenticationError.invalidCredentials
        }
        
    }
}


