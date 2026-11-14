//
//  AuthRepository.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async throws  -> User
//    func register()
//    func logout()
//    func currentUser() async throws -> User?
}
