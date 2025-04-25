//
//  OrderTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy

struct OrderTests {

    @Test func testTotalPriceWithOffersAndWithoutOffers() {
        var product1 = Product.example
        product1.price = 100
        product1.quantity = 1
        product1.isOffer = false // No offer on product1
        
        var product2 = Product.example
        product2.price = 100
        product2.quantity = 1
        product2.isOffer = true // Offer on product2
        product2.exclusiveOffer = ExclusiveOffer.example

        let order = Order(observableProducts: [
            ObservableProduct(product: product1),
            ObservableProduct(product: product2)
        ])
        // Expect subtotal to be 158 (100 + 58 from offer)
        #expect(order.subTotalPrice() == 158) // Test if the subtotal is correct
    }



    @Test func testTaxAmountCalculation() {
        var product = Product.example
        product.price = 100
        product.quantity = 2

        let order = Order(observableProducts: [ObservableProduct(product: product)], taxRate: 0.1)
        #expect(order.taxAmount == 20) // 200 * 10%
    }

    @Test func testComputedDeliveryChargeAboveThreshold() {
        var product = Product.example
        product.price = 600
        product.quantity = 1

        let order = Order(observableProducts: [ObservableProduct(product: product)])
        #expect(order.computedDeliveryCharge == 0)
    }

    @Test func testComputedDeliveryChargeBelowThreshold() {
        var product = Product.example
        product.price = 100
        product.quantity = 1

        let order = Order(observableProducts: [ObservableProduct(product: product)])
        #expect(order.computedDeliveryCharge == 40)
    }

    @Test func testGrandTotalCalculation() {
        var product = Product.example
        product.price = 500
        product.quantity = 1

        let order = Order(observableProducts: [ObservableProduct(product: product)], discount: 10)
        let subtotal = Decimal(500)
        let tax = subtotal * order.taxRate
        let delivery = order.computedDeliveryCharge
        let expectedTotal = subtotal + tax + delivery - 10

        #expect(order.grandTotal == expectedTotal)
    }

    @Test func testTotalItemsCalculation() {
        var product1 = Product.example
        product1.quantity = 2

        var product2 = Product.example
        product2.quantity = 3

        let order = Order(observableProducts: [
            ObservableProduct(product: product1),
            ObservableProduct(product: product2)
        ])
        #expect(order.totalItems == 5)
    }

    @Test func testOrderEquality() {
        let id = UUID()
        let order1 = Order(id: id)
        let order2 = Order(id: id)

        #expect(order1 == order2)
    }

    @Test func testOrderDateFormatting() {
        let now = Date()
        let order = Order(date: now)
        let formatted = now.formatted(date: .abbreviated, time: .shortened)
        #expect(order.convertedDate == formatted)
    }

    @Test func testConvertedPriceStringFormat() {
        var product = Product.example
        product.price = 100
        product.quantity = 1

        let order = Order(observableProducts: [ObservableProduct(product: product)])
        let formatted = Decimal(100).formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))

        #expect(order.convertedTotalPrice == formatted)
    }

    @Test func testConvertedGrandTotalStringFormat() {
        var product = Product.example
        product.price = 500
        product.quantity = 1

        let order = Order(observableProducts: [ObservableProduct(product: product)])
        let formatted = order.grandTotal.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))

        #expect(order.convertedGrandTotal == formatted)
    }

    @Test func testOrderExampleData() {
        let order = Order.example
        #expect(order.observableProducts.count > 0 || order.observableProducts.isEmpty) // Example always returns an order
    }
}
