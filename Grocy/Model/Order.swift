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
    
    func subTotalPrice() -> Decimal {
        return observableProducts.reduce(0) { total, product in
            
            let pricePerItem: Decimal
            
            // Check if the offer is valid and only apply once
            if let offer = product.exclusiveOffer, offer.isOfferValid {
                // Apply the discounted price once
                pricePerItem = offer.discountedPrice
            } else {
                // Otherwise, use the regular price
                pricePerItem = product.price
            }

            // Add the total price based on the quantity
            return total + (pricePerItem * Decimal(product.quantity))
        }
    }

    

    var taxAmount: Decimal {
        let subtotal = subTotalPrice()
        return subtotal * taxRate
    }
    
    var totalItems: Int {
        return observableProducts.reduce(0) { $0 + $1.quantity }
    }
    
    var computedDeliveryCharge: Decimal {
        subTotalPrice() > 599.0 ? 0.0 : deliveryCharge
    }
    
    var grandTotal: Decimal {
        let subtotal = subTotalPrice()
        return subtotal + taxAmount + computedDeliveryCharge - discount
    }
    
    var convertedGrandTotal: String {
        grandTotal.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    
    
    var convertedTotalPrice: String {
        let price = subTotalPrice()
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
