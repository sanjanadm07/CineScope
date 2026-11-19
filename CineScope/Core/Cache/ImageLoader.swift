//
//  ImageLoader.swift
//  CineScope
//
//  Created by Medhavi Magar on 18/11/26.
//

import Foundation
import UIKit
class ImageLoader {
    let imageCache = ImageCache.shared
    
    func loadImage(posterURL: URL) async throws -> UIImage {
        if let image = imageCache.retrieveImage(for: posterURL) {
            return image
        } else {
            let (data, response) = try await URLSession.shared.data(from: posterURL)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                throw ImageLoaderError.invalidResponse
            }
            guard let image = UIImage(data: data) else {
                throw ImageLoaderError.invalidImage
            }
            imageCache.cacheImage(image, for: posterURL)
            return image
            
        }
    }
    
}

enum ImageLoaderError: Error {
    case invalidImage
    case invalidResponse
}
