//
//  User.swift
//  CineScope
//
//  Created by Medhavi Magar on 12/11/26.
//

import Foundation

struct User: Identifiable, Sendable, Equatable {
    let id: Int
    let name: String
    let email: String
}
