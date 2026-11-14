//
//  LoginViewModel.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
    @Published private(set) var authState: AuthState = .loggedOut
    let authRepo: AuthRepository
    var user: User?
    
    init(authRepo: AuthRepository) {
        self.authRepo = authRepo
    }
    
    func checkCredentials() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    func login() async {
        guard checkCredentials() else {
            authState = .failed("Email and password are required.")
//            errorMessage = "Email and password are required."
            return
        }
        
//        isLoading = true
//        errorMessage = nil
//        defer {
//            isLoading = false
//        }
        authState = .loading
        do {
            user = try await authRepo.login(email: email, password: password)
            if let user = user {
                authState = .authenticated(user)
            }
        } catch let error as AuthenticationError {
            
            switch error {
            case .invalidCredentials:
                authState = .failed("Invalid email or password.")
//                errorMessage = "Invalid email or password."

            case .emptyCredentials:
                authState = .failed("Email and password are required.")
//                errorMessage = "Email and password are required."
            }

        } catch {
            authState = .failed("Something went wrong.")
//            errorMessage = "Something went wrong."
        }
        
    }
}
