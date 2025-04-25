//
//  LoadAllProductsTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy


struct LoadAllProductsTests {
    
    
    @Test func testDecodeValidFile() {
        // Assuming you have a JSON file named "validData.json" in the bundle
        let fileName = "products.json"
        
        // Create a mock type to decode the data into
        struct Product: Decodable {
            let id: UUID
            let name: String
        }
        
        // Attempt to decode the file
        let decodedData: [Product] = Bundle.main.decode(file: fileName)
        
        // Assert that the data is correctly decoded
        #expect(decodedData.count > 0) // Assuming the file contains data, we should have at least one decoded object
        #expect(decodedData.first?.name == "Bananas") // Example: checking if the first product's name matches
    }
    
}
