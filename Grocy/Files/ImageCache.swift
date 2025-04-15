//
//  ImageCache.swift
//  Grocy
//
//  Created by Ajay Sangwan on 15/04/25.
//

import Foundation

final class ImageCache: ObservableObject {
    static let shared = ImageCache()
    
    @Published var cache: [URL: Data] = [:] 
    
    func getImage(for url: URL) -> Data? {
        return cache[url]
    }
    
    func cacheImage(_ data: Data, for url: URL) {
        cache[url] = data
    }
}
