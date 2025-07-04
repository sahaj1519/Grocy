//
//  Product.swift
//  Grocy
//
//  Created by Ajay Sangwan on 12/04/25.
//


import Foundation

struct Product: Identifiable, Hashable, Codable, Equatable {
    
    let id: UUID
    var name: String
    var category: String
    var price: Decimal
    var unit: String
    var quantity: Int
    var thumbnail: URL
    var images: [URL]
    var exclusiveOffer: ExclusiveOffer?
    var isOffer: Bool
    
    var description: String
    var source: String
    var seasonal: Bool
    var organic: Bool
    var newArrival: Bool
    var bestSeller: Bool
    
    var percentDiscount: String {
        guard let offer = exclusiveOffer else { return "0%" }
        let discount = price - offer.discountedPrice
        guard price > 0 else { return "0%" }
        
        let percent = (discount / price) * 100
        let roundedPercent = (percent as NSDecimalNumber).intValue  // Use NSDecimalNumber to round and get int value
        
        return "\(roundedPercent)%"
    }


    var convertedPrice: String {
        price.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    var convertedTotalPrice: String {
        let totalprice = price * Decimal(quantity)
        return totalprice.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
    
    var parsedUnit: (value: Double, unit: String)? {
        let pattern = #"(\d+\.?\d*)\s*(\w+)"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: unit, range: NSRange(unit.startIndex..., in: unit)),
              let valueRange = Range(match.range(at: 1), in: unit),
              let unitRange = Range(match.range(at: 2), in: unit),
              let value = Double(unit[valueRange]) else { return nil }

        let unitString = String(unit[unitRange])
        return (value, unitString)
    }
    
   
    static var example: Product {
        Product(
            id: UUID(),
            name: "Example Product",
            category: "Fruits",
            price: 100,
            unit: "1kg",
            quantity: 1,
            thumbnail: URL(string: "https://i.imgur.com/d7dzK2xt.jpg")!,
            images: [],
            exclusiveOffer: nil,
            isOffer: false,
            description: "Sample description",
            source: "Farm",
            seasonal: false,
            organic: false,
            newArrival: true,
            bestSeller: false
        )
    }

}
