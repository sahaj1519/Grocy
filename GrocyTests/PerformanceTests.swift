//
//  PerformanceTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing

@Suite("Performance Tests")
struct PerformanceTests {
    struct Product: Codable {
        let id: Int
        let name: String
        let price: Decimal
    }

    @Test("Decode 1 million products from JSON in background")
    func testLargeJSONDecodingInBackground() async throws {
        let startTime = CFAbsoluteTimeGetCurrent()

        let products: [Product] = try await Task.detached(priority: .userInitiated) {
            guard let url = Bundle.main.url(forResource: "LargeProducts", withExtension: "json") else {
                throw NSError(domain: "com.yourApp", code: 404, userInfo: [NSLocalizedDescriptionKey: "Could not find LargeProducts.json in bundle"])
            }

            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Product].self, from: data)
        }.value

        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = endTime - startTime

        print("Decoded \(products.count) products in \(elapsed) seconds")

        #expect(products.count == 1_000_000)
        #expect(elapsed < 5.0) // Adjust based on your machine’s capabilities
    }
}
