//
//  AppCoordinator.swift
//  CineScope
//
//  Created by Medhavi Magar on 20/11/26.
//

import Foundation
import SwiftUI
final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedMovie: Movie?
    
    func showMovieDetail(movie: Movie) {
        selectedMovie = movie
        path.append(AppRoute.movieDetail)
    }
    
    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
        selectedMovie = nil
    }
    
    func popToRoot() {
        path = NavigationPath()
        selectedMovie = nil
    }
}

enum AppRoute {
    case movieDetail
}
