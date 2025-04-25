//
//  ContentViewViewModelTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy

struct ContentViewViewModelTests {

    // MARK: - ViewModel Tests

    // Test for loading products from the JSON file
    @Test func testLoadProducts() async {
        // Create an instance of ViewModel
        let viewModel = ContentView.ViewModel()

        // Ensure products are initially empty
        #expect(viewModel.observableProducts.isEmpty == true)

        // Load products
        await viewModel.loadProducts()

        // Verify products are loaded correctly
        #expect(viewModel.observableProducts.count > 0)  // Ensure there are products after loading
    }

    // Test for retrieving a product by its ID
    @Test func testProductWithId() async {
        // Create an instance of ViewModel
        let viewModel = ContentView.ViewModel()
        
        // Load products first
        await viewModel.loadProducts()

        // Ensure the products are loaded
        #expect(viewModel.observableProducts.isEmpty == false)

        // Test retrieval of a product by ID
        if let firstProduct = viewModel.observableProducts.first {
            let retrievedProduct = viewModel.product(withId: firstProduct.id)
            
            // Verify that the retrieved product is the same as the first product
            #expect(retrievedProduct?.id == firstProduct.id)
        } 
    }
}

