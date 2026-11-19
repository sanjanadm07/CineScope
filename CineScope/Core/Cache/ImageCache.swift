//
//  ImageCache.swift
//  CineScope
//
//  Created by Medhavi Magar on 18/11/26.
//

import Foundation
import UIKit
final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    let cacheLimit: Int = 20
    
    private init() {}
    
    func retrieveImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func cacheImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
