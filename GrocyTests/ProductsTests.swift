//
//  ProductsTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Foundation
import Testing
@testable import Grocy

struct ProductsTests {

    
    @Test func testProductConvertedPriceAndTotalPrice() {
        let product = Product.example
        let expectedPrice = product.convertedPrice
        let expectedTotalPrice = product.convertedTotalPrice
        let currencySymbol = Locale.current.currencySymbol ?? "₹"

        // Extracting the currency symbol from the formatted price string (using a regular expression to capture the symbol)
        let expectedPriceCurrencySymbol = expectedPrice.prefix { $0.isSymbol }
        let expectedTotalPriceCurrencySymbol = expectedTotalPrice.prefix { $0.isSymbol }
        
        // Checking if the price and total price contain the expected currency symbol
        #expect(expectedPriceCurrencySymbol == currencySymbol)
        #expect(expectedTotalPriceCurrencySymbol == currencySymbol)
    }



    @Test func testProductDiscountPercentage() {
            let product = Product.example
            
            if let offer = product.exclusiveOffer {
                let priceDifference = product.price - offer.discountedPrice
                let discount = priceDifference / product.price * Decimal(100)
                let expectedDiscount = NSDecimalNumber(decimal: discount).intValue
                
                #expect(product.percentDiscount == "\(expectedDiscount)%")
            } else {
                #expect(product.percentDiscount == "0%")
            }
        }


    @Test func testParsedUnit() {
        let product = Product.example
        if let parsed = product.parsedUnit {
            #expect(parsed.unit.isEmpty == false)
            #expect(parsed.value > 0)
        }
    }

  

}
