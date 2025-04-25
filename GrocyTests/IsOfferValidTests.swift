//
//  IsOfferValidTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//
import  Foundation
import Testing
@testable import Grocy

struct IsOfferValidTests {

    @Test func testOfferValidity() {
        let validOffer = ExclusiveOffer(
            id: UUID(),
            discountedPrice: 50,
            expiresAt: Date().addingTimeInterval(3600), // 1 hour in future
            offerType: "Discount",
            offerDetails: "Valid for 1 hour"
        )
        #expect(validOffer.isOfferValid == true)

        let expiredOffer = ExclusiveOffer(
            id: UUID(),
            discountedPrice: 50,
            expiresAt: Date().addingTimeInterval(-3600), // 1 hour ago
            offerType: "Discount",
            offerDetails: "Expired offer"
        )
        #expect(expiredOffer.isOfferValid == false)
    }
  
    @Test func testOfferApplicationLogic() {
        var productWithValidOffer = Product.example
        productWithValidOffer.price = 100
        productWithValidOffer.quantity = 1
        productWithValidOffer.exclusiveOffer = ExclusiveOffer(
            id: UUID(),
            discountedPrice: 80,
            expiresAt: Date().addingTimeInterval(3600),
            offerType: "Limited Time",
            offerDetails: "20 off"
        )

        var productWithExpiredOffer = Product.example
        productWithExpiredOffer.price = 100
        productWithExpiredOffer.quantity = 1
        productWithExpiredOffer.exclusiveOffer = ExclusiveOffer(
            id: UUID(),
            discountedPrice: 80,
            expiresAt: Date().addingTimeInterval(-3600),
            offerType: "Expired",
            offerDetails: "Should not apply"
        )

        let order = Order(observableProducts: [
            ObservableProduct(product: productWithValidOffer),
            ObservableProduct(product: productWithExpiredOffer)
        ])

        // Should be 80 (valid discount) + 100 (expired ignored) = 180
        #expect(order.subTotalPrice() == 180)
    }
   
    @Test func testConvertedDiscountedPriceFormatting() {
        let offer = ExclusiveOffer(
            id: UUID(),
            discountedPrice: 42.5,
            expiresAt: Date().addingTimeInterval(3600),
            offerType: "Formatted Test",
            offerDetails: "Test price format"
        )

        let formatted = offer.convertedDiscountedPrice
        print("Formatted Price: \(formatted)")
        #expect(formatted.contains("42") || formatted.contains("42.5")) // Varies by locale
    }
   
}
