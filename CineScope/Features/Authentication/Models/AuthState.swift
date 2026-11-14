//
//  AuthState.swift
//  CineScope
//
//  Created by Medhavi Magar on 13/11/26.
//

import Foundation

enum AuthState {
    case loggedOut
    case loading
    case authenticated(User)
    case failed(String)
}
