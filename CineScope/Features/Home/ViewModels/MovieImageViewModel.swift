//
//  MovieImageViewModel.swift
//  CineScope
//
//  Created by Medhavi Magar on 18/11/26.
//

import Foundation
import UIKit
@MainActor
final class MovieImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isImageLoading: Bool = false
    @Published var error: String?
    let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func fetchImage(urlString: URL?) async {
        isImageLoading = true
        error = nil
        defer {
            isImageLoading = false
        }
        guard let urlString = urlString else {
            error = "Invalid poster URL"
            return
        }
        do {
            image = try await imageLoader.loadImage(posterURL: urlString)
        } catch {
            self.error = error.localizedDescription
        }
        
    }
}
