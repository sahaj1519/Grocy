//
//  Order.swift
//  Grocy
//
//  Created by Ajay Sangwan on 13/04/25.
//

import Foundation

struct Order: Hashable, Codable, Identifiable, Equatable {
    var id = UUID()
    var date: Date = .now
    var isCompleted: Bool = false
    var observableProducts: [ObservableProduct] = []
    
    var deliveryCharge: Decimal = 40.0
    var taxRate: Decimal = 0.05
    var discount: Decimal = 0.0
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case isCompleted = "isCompleted"
        case observableProducts = "observableProducts"
       
    }
    
    var convertedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
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
    
    
    static var example: Order {
        guard let products: [Product] = Bundle.main.decode(file: "products.json") else {
               return Order(date: .now, isCompleted: false, observableProducts: [])
           }
           
          
           let observableProducts = products.map { ObservableProduct(product: $0) }
           
           return Order(date: .now, isCompleted: false, observableProducts: observableProducts)
       }
}
