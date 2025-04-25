//
//  ImageCacheTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy

struct ImageCacheTests {

    @Test func testCacheImage() {
        let imageCache = ImageCache.shared
        let testURL = URL(string: "https://example.com/test-image.jpg")!
        let imageData = Data([0x01, 0x02, 0x03])  // Simulated image data

        // Cache the image
        imageCache.cacheImage(imageData, for: testURL)

        // Check if the image is cached correctly
        let cachedImageData = imageCache.getImage(for: testURL)
        #expect(cachedImageData == imageData) // Ensure the cached data matches
    }

    
    @Test func testGetImage() {
        let imageCache = ImageCache.shared
        let testURL = URL(string: "https://example.com/test-image.jpg")!
        let imageData = Data([0x01, 0x02, 0x03])  // Simulated image data

        // Cache the image
        imageCache.cacheImage(imageData, for: testURL)

        // Retrieve the image
        if let cachedImageData = imageCache.getImage(for: testURL) {
            #expect(cachedImageData == imageData) // Ensure retrieved data is correct
        } else {
            #expect(Bool(false))  // If the image isn't found, the test fails
        }
    }



}
