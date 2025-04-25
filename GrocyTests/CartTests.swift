//
//  CartTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable @preconcurrency import Grocy

struct CartTests {
    
    // MARK: - Setup and Teardown
    
    // Setup method to clear UserDefaults before each test
    func setUp() {
        UserDefaults.standard.removeObject(forKey: Cart.userDefaultsKey)
    }
    
    // Teardown method to clear UserDefaults after each test
    func tearDown() {
        UserDefaults.standard.removeObject(forKey: Cart.userDefaultsKey)
    }
    
    // MARK: - Cart Tests
    
    @Test func testCartAddAndRemoveProduct() {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        let cart = Cart()
        let product = ObservableProduct(product: Product.example)
        
        // Adding product to cart
        cart.addToCart(product: product)
        #expect(cart.totalItems == 1)
        
        // Removing product from cart
        cart.removeProductFromCart(product: product)
        #expect(cart.totalItems == 0)
    }
    
    @Test func testCartTotalAndSavings() {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        let cart = Cart()
        let product = ObservableProduct(product: Product.example)
        
        // Adding product to cart
        cart.addToCart(product: product)
        
        // Checking total price and savings
        #expect(cart.totalPrice() > 0)
        #expect(cart.totalSavings() >= 0)
    }
    
    @Test func testCartGrandTotalIncludesTaxAndDelivery() {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        let cart = Cart()
        let product = ObservableProduct(product: Product.example)
        
        // Adding product to cart
        cart.addToCart(product: product)
        
        let total = cart.totalPrice()
        let grandTotal = cart.grandTotal
        
        // Checking if grand total includes tax and delivery
        #expect(grandTotal >= total)
    }
    
    @Test func testSaveCartToUserDefaults() async {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        // Create a Cart instance with a sample product
        let cart = Cart()
        let sampleProduct = ObservableProduct(product: Product.example)
        cart.addToCart(product: sampleProduct)

        // Save the cart to UserDefaults
        cart.saveToUserDefaults()

        // Simulate a short delay for async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Load the cart back from UserDefaults
            if let loadedCart = Cart.loadFromUserDefaults() {
                // Compare the observable products in both carts
                compareProducts(lhs: cart.observableProducts, rhs: loadedCart.observableProducts)
            }
        }
    }

    @Test func testLoadEmptyCart() async {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        // Clear UserDefaults to simulate an empty cart scenario
        Cart.clearFromUserDefaults()
        
        // Add a small delay to ensure UserDefaults changes are completed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Try loading the cart (should return nil or an empty cart)
            if let loadedCart = Cart.loadFromUserDefaults() {
                #expect(loadedCart.observableProducts.isEmpty == true) // Should be empty
            }
        }
    }

    @Test func testSaveAndRemoveProductFromCart() async {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        // Create a Cart instance and add a product
        let cart = Cart()
        let sampleProduct = ObservableProduct(product: Product.example)
        cart.addToCart(product: sampleProduct)
        
        // Remove the product
        cart.removeProductFromCart(product: sampleProduct)
        
        // Save the cart to UserDefaults
        cart.saveToUserDefaults()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Load the cart back from UserDefaults and perform the test
            if let loadedCart = Cart.loadFromUserDefaults() {
                // Assert that the product is removed (cart should be empty)
                #expect(loadedCart.observableProducts.isEmpty)
            }
        }
    }


    
    @Test func testSaveCartWithMultipleProducts() async {
        setUp() // Call setUp() to clear UserDefaults before test
        defer { tearDown() } // Ensure tearDown() is called after the test
        
        // Create a Cart instance with multiple products
        let cart = Cart()
        let sampleProduct1 = ObservableProduct(product: Product.example)
        let sampleProduct2 = ObservableProduct(product: Product.example) // Add another product
        
        cart.addToCart(product: sampleProduct1)
        cart.addToCart(product: sampleProduct2)
        
        // Save the cart to UserDefaults
        cart.saveToUserDefaults()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Load the cart back from UserDefaults
            if let loadedCart = Cart.loadFromUserDefaults() {
                // Assert that both products are in the cart
                #expect(loadedCart.observableProducts.count == 2) // Should contain 2 products
            }
        }
    }

    // Helper function to compare products
    func compareProducts(lhs: [ObservableProduct], rhs: [ObservableProduct]) {
        guard lhs.count == rhs.count else {
            assert(false, "The arrays have different lengths.")  // Failure if lengths don't match
            return
        }

        for (index, lhsProduct) in lhs.enumerated() {
            let rhsProduct = rhs[index]

            if lhsProduct != rhsProduct {  // Compare using Equatable's `==` implementation
                assert(false, "Products do not match at index \(index).")
            }
        }
    }
}
