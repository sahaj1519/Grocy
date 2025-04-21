//
//  ObservableProduct.swift
//  Grocy
//
//  Created by Ajay Sangwan on 21/04/25.
//

import Foundation

@Observable
class ObservableProduct: Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID
    var name: String
    var category: String
    var price: Decimal
    var unit: String
    var quantity: Int
    var thumbnail: URL
    var images: [URL]
    var exclusiveOffer: ExclusiveOffer?
   
    var description: String
    var source: String
    var seasonal: Bool
    var organic: Bool
    var newArrival: Bool
    var bestSeller: Bool
    
    var isOffer: Bool {
           guard let offer = exclusiveOffer else { return false }
           return offer.isOfferValid
       }
    
    init(product: Product) {
        self.id = product.id
        self.name = product.name
        self.category = product.category
        self.price = product.price
        self.unit = product.unit
        self.quantity = product.quantity
        self.thumbnail = product.thumbnail
        self.images = product.images
        self.exclusiveOffer = product.exclusiveOffer
       
        self.description = product.description
        self.source = product.source
        self.seasonal = product.seasonal
        self.organic = product.organic
        self.newArrival = product.newArrival
        self.bestSeller = product.bestSeller
        
      
    }
    


    // Equatable conformance
    static func == (lhs: ObservableProduct, rhs: ObservableProduct) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
           hasher.combine(id) 
       }


    // Computed properties
    var percentDiscount: String {
        guard let offer = exclusiveOffer else { return "0%" }
        let discount = price - offer.discountedPrice
        guard price > 0 else { return "0%" }
        let percent = (discount / price) * 100
        let doublePercent = NSDecimalNumber(decimal: percent).doubleValue
        return "\(Int(doublePercent.rounded()))%"
    }

    var convertedPrice: String {
        price.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
    }

    var convertedTotalPrice: String {
        let totalPrice = price * Decimal(quantity)
        return totalPrice.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
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
    

    // Static example for preview
    static var example: ObservableProduct {
        // Creating a mock `Product` to initialize the example
        let exampleProduct = Product(
            id: UUID(),
            name: "Example Product",
            category: "Grocery",
            price: 10.99,
            unit: "kg",
            quantity: 5,
            thumbnail: URL(string: "https://example.com/thumbnail.jpg")!,
            images: [URL(string: "https://example.com/image1.jpg")!, URL(string: "https://example.com/image2.jpg")!],
            exclusiveOffer: nil,
            isOffer: true,
            description: "This is a sample product.",
            source: "Sample Supplier",
            seasonal: false,
            organic: true,
            newArrival: true,
            bestSeller: true
        )
        return ObservableProduct(product: exampleProduct)
    }
   
}
