//
//  Cart.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation


@Observable
class Cart: Codable, Equatable {
    
    var products: [Product] = []
    
    var deliveryCharge: Decimal = 40.0
    var taxRate: Decimal = 0.05
    var discount: Decimal = 0.0
    
   
    var taxAmount: Decimal {
        let subtotal = totalPrice()
        return subtotal * taxRate
    }
    
    var totalItems: Int {
        return products.reduce(0) { $0 + $1.quantity }
    }
    
    var computedDeliveryCharge: Decimal {
        totalPrice() > 599.0 ? 0.0 : deliveryCharge
    }

    
    var grandTotal: Decimal {
        let subtotal = totalPrice()
        return subtotal + taxAmount + computedDeliveryCharge - discount
    }
    
    var convertedGrandTotal: String {
        grandTotal.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    
    
    var convertedTotalPrice: String {
        let price = totalPrice()
        return price.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    
    enum CodingKeys: String, CodingKey {
        case _products = "products"
    }
    
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.products == rhs.products
    }
    
    
    func addToCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            products.append(newProduct)
        }
        saveToUserDefaults()
    }
    
    
    func quantity(for product: Product) -> Int {
        return products.first(where: { $0.id == product.id })?.quantity ?? 0
    }
    
    func updateQuantity(for product: Product, by amount: Int) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += amount
        }
    }
    
    func removeProductFromCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }
    
    
    func totalPrice() -> Decimal {
        return products.reduce(0) { total, product in
            let pricePerItem: Decimal
            if let offer = product.exclusiveOffer, product.isOffer {
                pricePerItem = offer.discountedPrice
            } else {
                pricePerItem = product.price
            }
            
            return total + (pricePerItem * Decimal(product.quantity))
        }
    }
    
    
    func totalSavings() -> Decimal {
        return products.reduce(0) { savings, product in
            if let offer = product.exclusiveOffer {
                let savedPerItem = product.price - offer.discountedPrice
                return savings + (savedPerItem * Decimal(product.quantity))
            }
            return savings
        }
    }
    
    
    
    
    static var example: Cart {
        let cart = Cart()
        cart.products = [Product.example]
        return cart
    }
    
}
