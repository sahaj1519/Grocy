//
//  Cart.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation


@Observable
class Cart: Codable, Equatable {
    
    var observableProducts: [ObservableProduct] = []
    
    var deliveryCharge: Decimal = 40.0
    var taxRate: Decimal = 0.002
    var discount: Decimal = 0.0
    
    
    var taxAmount: Decimal {
        let subtotal = totalPrice()
        return subtotal * taxRate
    }
    
    var totalItems: Int {
        return observableProducts.reduce(0) { $0 + $1.quantity }
    }
    
    var computedDeliveryCharge: Decimal {
        totalPrice() > 599.0 ? 0.0 : deliveryCharge
    }

    var deliveryChargesPlusSubtotal: String {
        let subtotal = totalPrice()
        let deliverycharge = computedDeliveryCharge
        let deliveryChargePlusTotalprice = subtotal + deliverycharge
        return deliveryChargePlusTotalprice.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
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
        case _observableProducts = "observableProducts"
    }
    
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.observableProducts == rhs.observableProducts
    }
    
    
    func addToCart(product: ObservableProduct) {
        if let index = observableProducts.firstIndex(where: { $0.id == product.id }) {
            observableProducts[index].quantity += 1
        } else {
            product.quantity = 1
            observableProducts.append(product)
        }
        saveToUserDefaults()
    }

    
    
    func quantity(for product: ObservableProduct) -> Int {
        return observableProducts.first(where: { $0.id == product.id })?.quantity ?? 0
    }
    
    func updateQuantity(for product: ObservableProduct, by amount: Int) {
        if let index = observableProducts.firstIndex(where: { $0.id == product.id }) {
            observableProducts[index].quantity += amount
        }
    }
    
    func removeProductFromCart(product: ObservableProduct) {
        if let index = observableProducts.firstIndex(where: { $0.id == product.id }) {
            observableProducts.remove(at: index)
        }
    }
    
    
    func totalPrice() -> Decimal {
        return observableProducts.reduce(0) { total, product in
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
        return observableProducts.reduce(0) { savings, product in
            if let offer = product.exclusiveOffer {
                let savedPerItem = product.price - offer.discountedPrice
                return savings + (savedPerItem * Decimal(product.quantity))
            }
            return savings
        }
    }
    
    
    
    
    static var example: Cart {
        let cart = Cart()
        cart.observableProducts = [ObservableProduct.example]
        return cart
    }
    
}
