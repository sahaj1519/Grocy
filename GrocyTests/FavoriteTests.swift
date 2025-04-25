//
//  FavoriteTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Testing
@testable import Grocy

struct FavoriteTests {
    
    @Test func testAddToFavorite() {
        let favorite = Favorite()
        let product = ObservableProduct.example
        favorite.addToFavorite(product: product)
        
        #expect(favorite.observableProducts.contains { $0.id == product.id })
    }
    
    @Test func testAddDuplicateToFavorite() {
        let favorite = Favorite()
        let product = ObservableProduct.example
        favorite.addToFavorite(product: product)
        favorite.addToFavorite(product: product)
        
        #expect(favorite.observableProducts.count == 1)
    }
    
    @Test func testRemoveFromFavorite() {
        let favorite = Favorite()
        let product = ObservableProduct.example
        favorite.addToFavorite(product: product)
        favorite.removeFromFavorite(product: product)
        
        #expect(!favorite.observableProducts.contains { $0.id == product.id })
    }
    
    @Test func testIsFavorite() {
        let favorite = Favorite()
        let product = ObservableProduct.example
        
        #expect(!favorite.isFavorite(product))
        favorite.addToFavorite(product: product)
        #expect(favorite.isFavorite(product))
    }
    
    @Test func testFavoritesAreEqual() {
        let favorite1 = Favorite()
        let favorite2 = Favorite()
        let product = ObservableProduct.example
        
        favorite1.addToFavorite(product: product)
        favorite2.addToFavorite(product: product)
        
        #expect(favorite1 == favorite2)
    }
    
    @Test func testExampleFavorite() {
        let example = Favorite.example
        #expect(!example.observableProducts.isEmpty)
    }
}
